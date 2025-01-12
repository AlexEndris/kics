package Cx

import data.generic.terraform as tf_lib

CxPolicy[result] {
	resource := input.document[i].resource.aws_eks_cluster[name]
	resource.vpc_config.endpoint_public_access == true

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_eks_cluster",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("aws_eks_cluster[%s].vpc_config.endpoint_public_access", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'vpc_config.endpoint_public_access' is equal 'false'",
		"keyActualValue": "'vpc_config.endpoint_public_access' is equal 'true'",
	}
}
