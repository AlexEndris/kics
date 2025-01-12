package Cx

import data.generic.common as common_lib
import data.generic.terraform as tf_lib

CxPolicy[result] {
	password_policy := input.document[i].resource.aws_neptune_cluster[name]
	not common_lib.valid_key(password_policy, "storage_encrypted")

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_neptune_cluster",
		"resourceName": tf_lib.get_resource_name(password_policy, name),
		"searchKey": sprintf("aws_neptune_cluster[%s]", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'storage_encrypted' should be set with value true",
		"keyActualValue": "'storage_encrypted' is undefined",
	}
}

CxPolicy[result] {
	password_policy := input.document[i].resource.aws_neptune_cluster[name]
	password_policy.storage_encrypted == false

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_neptune_cluster",
		"resourceName": tf_lib.get_resource_name(password_policy, name),
		"searchKey": sprintf("aws_neptune_cluster[%s].storage_encrypted", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'storage_encrypted' should be true",
		"keyActualValue": "'storage_encrypted' is false",
	}
}
