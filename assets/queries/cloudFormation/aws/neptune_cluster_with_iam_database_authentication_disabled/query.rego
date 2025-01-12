package Cx

import data.generic.common as common_lib
import data.generic.cloudformation as cf_lib

CxPolicy[result] {
	resource := input.document[i].Resources[name]
	resource.Type == "AWS::Neptune::DBCluster"
	properties := resource.Properties
	properties.IamAuthEnabled == false

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties.IamAuthEnabled", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("Resources.%s.Properties.IamAuthEnabled is set to true", [name]),
		"keyActualValue": sprintf("Resources.%s.Properties.IamAuthEnabled is set to false", [name]),
	}
}

CxPolicy[result] {
	resource := input.document[i].Resources[name]
	resource.Type == "AWS::Neptune::DBCluster"
	properties := resource.Properties

	not common_lib.valid_key(properties, "IamAuthEnabled")

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("Resources.%s.Properties.IamAuthEnabled is set to true", [name]),
		"keyActualValue": sprintf("Resources.%s.Properties.IamAuthEnabled is undefined", [name]),
	}
}
