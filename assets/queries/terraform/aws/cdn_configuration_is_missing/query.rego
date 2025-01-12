package Cx

import data.generic.common as common_lib
import data.generic.terraform as tf_lib

CxPolicy[result] {
	document := input.document[i]
	resource := document.resource.aws_cloudfront_distribution[name]

	not common_lib.valid_key(resource, "enabled")

	result := {
		"documentId": document.id,
		"resourceType": "aws_cloudfront_distribution",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("resource.aws_cloudfront_distribution[%s]", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("resource.aws_cloudfront_distribution[%s].enabled is set to 'true'", [name]),
		"keyActualValue": sprintf("resource.aws_cloudfront_distribution[%s].enabled is not defined", [name]),
	}
}

CxPolicy[result] {
	document := input.document[i]
	resource := document.resource.aws_cloudfront_distribution[name]

	resource.enabled == false

	result := {
		"documentId": document.id,
		"resourceType": "aws_cloudfront_distribution",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("resource.aws_cloudfront_distribution[%s].enabled", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("resource.aws_cloudfront_distribution[%s].enabled is set to 'true'", [name]),
		"keyActualValue": sprintf("resource.aws_cloudfront_distribution[%s].enabled is configured as 'false'", [name]),
	}
}

CxPolicy[result] {
	document := input.document[i]
	resource := document.resource.aws_cloudfront_distribution[name]

	not common_lib.valid_key(resource, "origin")

	result := {
		"documentId": document.id,
		"resourceType": "aws_cloudfront_distribution",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("resource.aws_cloudfront_distribution[%s]", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("resource.aws_cloudfront_distribution[%s].origin is defined", [name]),
		"keyActualValue": sprintf("resource.aws_cloudfront_distribution[%s].origin is not defined", [name]),
	}
}
