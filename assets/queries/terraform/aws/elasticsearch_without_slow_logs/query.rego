package Cx

import data.generic.common as commonLib
import data.generic.terraform as tf_lib

CxPolicy[result] {
	awsElasticsearchDomain := input.document[i].resource.aws_elasticsearch_domain[name]
	logType := awsElasticsearchDomain.log_publishing_options.log_type

	not commonLib.inArray(["INDEX_SLOW_LOGS", "SEARCH_SLOW_LOGS"], logType)

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_elasticsearch_domain",
		"resourceName": tf_lib.get_resource_name(awsElasticsearchDomain, name),
		"searchKey": sprintf("aws_elasticsearch_domain[{{%s}}].log_publishing_options.log_type", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'log_publishing_options.log_type' is not INDEX_SLOW_LOGS or SEARCH_SLOW_LOGS  ",
		"keyActualValue": "'log_publishing_options.enabled' is ES_APPLICATION_LOGS or AUDIT_LOGS",
	}
}
