package test

import (
	"context"
	"fmt"
	"os"
	"regexp"
	"testing"

	"github.com/cgascoig/intersight-go-sdk/intersight"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBasicCluster(t *testing.T) {
	// Setup Terraform options
	uniqueId := random.UniqueId()
	instanceName := fmt.Sprintf("test_basic_cluster-%s", uniqueId)

	vars := map[string]interface{}{}
	terraform.GetAllVariablesFromVarFile(t, os.Getenv("TF_CREDS_FILE"), &vars)
	// terraform.GetAllVariablesFromVarFile(t, "../test_creds.tfvars", &vars)
	vars["name"] = instanceName

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./basic_cluster",
		Vars:         vars,
	})

	client, ctx := setupIntersight(t, vars["intersight_apikey"].(string), vars["intersight_secretkey"].(string), vars["intersight_endpoint"].(string))

	// Tests start here:

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	k8sClusterProfileMoid := terraform.Output(t, terraformOptions, "k8s_cluster_profile_moid")
	assert.Regexp(t, regexp.MustCompile("^[[:xdigit:]]{24}$"), k8sClusterProfileMoid, "Cluster Profile Moid")

	k8sClusterMoid := terraform.Output(t, terraformOptions, "k8s_cluster_moid")
	assert.Regexp(t, regexp.MustCompile("^[[:xdigit:]]{24}$"), k8sClusterMoid, "Cluster Moid")

	// Validate Kubernetes Cluster Profile
	res, _, err := client.KubernetesApi.GetKubernetesClusterProfileByMoid(ctx, k8sClusterProfileMoid).Execute()
	assert.NoError(t, err, "Getting Kubernetes Cluster Profile by Moid")
	assert.NotNil(t, res, "Getting Kubernetes Cluster Profile by Moid")

	assert.Equal(t, instanceName, *res.Name, "Check Kubernetes Cluster Profile Name")
	assert.Equal(t, "", *res.Description, "Check Kubernetes Cluster Profile Description")
	assert.Equal(t, "Unassign", *res.Action, "Check Kubernetes Cluster Profile Action")
	assert.EqualValues(t, 4, *res.ManagementConfig.Get().LoadBalancerCount, "Check Kubernetes Cluster Profile Load Balancer Count")

	// Validate Kubernetes Cluster
	kcRes, _, err := client.KubernetesApi.GetKubernetesClusterByMoid(ctx, k8sClusterMoid).Execute()
	assert.Equal(t, instanceName, *kcRes.Name, "Check Kubernetes Cluster Name")

	// Validate Node Group Profiles - Control Plane
	ngpRes, _, err := client.KubernetesApi.GetKubernetesNodeGroupProfileList(ctx).Filter(fmt.Sprintf("Name eq '%s-control_profile'", instanceName)).Execute()
	assert.NoError(t, err, "Get Control Plane Node Group Profile")
	assert.NotNil(t, ngpRes, "Get Control Plane Node Group Profile")
	assert.Equal(t, 1, len(ngpRes.KubernetesNodeGroupProfileList.Results), "Get Control Plane Node Group Profile by Name should return 1 result")

	ngp := ngpRes.KubernetesNodeGroupProfileList.Results[0]
	validateNodeGroupProfile(t, ngp, "ControlPlane", 1, 1, 2, k8sClusterProfileMoid)

	// Validate Node Group Profiles - Workers
	ngpRes, _, err = client.KubernetesApi.GetKubernetesNodeGroupProfileList(ctx).Filter(fmt.Sprintf("Name eq '%s-worker_profile'", instanceName)).Execute()
	assert.NoError(t, err, "Get Worker Node Group Profile")
	assert.NotNil(t, ngpRes, "Get Worker Node Group Profile")
	assert.Equal(t, 1, len(ngpRes.KubernetesNodeGroupProfileList.Results), "Get Worker Node Group Profile by Name should return 1 result")

	ngp = ngpRes.KubernetesNodeGroupProfileList.Results[0]
	validateNodeGroupProfile(t, ngp, "Worker", 5, 5, 20, k8sClusterProfileMoid)

}

func setupIntersight(t *testing.T, keyID, key, endpoint string) (*intersight.APIClient, context.Context) {
	// Setup Intersight API client
	config := intersight.NewConfiguration()
	client := intersight.NewAPIClient(config)

	// Set up the authentication configuration struct
	authConfig := intersight.HttpSignatureAuth{
		KeyId: keyID,

		SigningScheme: intersight.HttpSigningSchemeRsaSha256,
		SignedHeaders: []string{
			intersight.HttpSignatureParameterRequestTarget, // The special (request-target) parameter expresses the HTTP request target.
			"Host",   // The Host request header specifies the domain name of the server, and optionally the TCP port number.
			"Date",   // The date and time at which the message was originated.
			"Digest", // A cryptographic digest of the request body.
		},
		SigningAlgorithm: intersight.HttpSigningAlgorithmRsaPKCS1v15,
	}
	err := authConfig.SetPrivateKey(key)
	assert.NoError(t, err)

	// Get a context that includes the authentication config
	ctx, err := authConfig.ContextWithValue(context.Background())
	assert.NoError(t, err)
	assert.NotNil(t, ctx)

	ctx = context.WithValue(ctx, intersight.ContextServerVariables, map[string]string{
		"server": endpoint,
	})

	return client, ctx
}

func validateNodeGroupProfile(t *testing.T, res intersight.KubernetesNodeGroupProfile, nodeType string, desiredNodes, minNodes, maxNodes int, clusterProfileMoid string) {
	msg := fmt.Sprintf("Validate %s Node Group Profile", nodeType)

	assert.Equal(t, nodeType, *res.NodeType, msg)
	assert.EqualValues(t, desiredNodes, *res.Desiredsize, msg)
	assert.EqualValues(t, minNodes, *res.Minsize, msg)
	assert.EqualValues(t, maxNodes, *res.Maxsize, msg)
	assert.Equal(t, clusterProfileMoid, *res.ClusterProfile.MoMoRef.Moid)
}
