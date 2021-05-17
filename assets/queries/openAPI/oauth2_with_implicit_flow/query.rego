package Cx

import data.generic.openapi as openapi_lib

CxPolicy[result] {
	doc := input.document[i]
	openapi_lib.check_openapi(doc) != "undefined"

	security_scheme := doc.components.securitySchemes[name]
	security_scheme.type == "oauth2"
	flow := security_scheme.flows[flow_object]
	flow_object == "implicit"

	result := {
		"documentId": doc.id,
		"searchKey": sprintf("components.securitySchemes.{{%s}}.flows.implicit", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("components.securitySchemes.{{%s}}.flows do not contain an 'implicit' flow", [name]),
		"keyActualValue": sprintf("components.securitySchemes.{{%s}}.flows contain an 'implicit' flow", [name]),
	}
}
