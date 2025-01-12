package Cx

import data.generic.terraform as tf_lib

#allow_users_to_change_password default is true
CxPolicy[result] {
	pol := input.document[i].resource.aws_iam_account_password_policy[name]
	pol.allow_users_to_change_password == false

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_iam_account_password_policy",
		"resourceName": tf_lib.get_resource_name(pol, name),
		"searchKey": sprintf("aws_iam_account_password_policy[%s].allow_users_to_change_password", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'allow_users_to_change_password' is equal 'true'",
		"keyActualValue": "'allow_users_to_change_password' is equal 'false'",
	}
}
