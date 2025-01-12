package Cx

import data.generic.terraform as tf_lib

CxPolicy[result] {
	dnssec_config := input.document[i].resource.google_dns_managed_zone[name].dnssec_config
	dnssec_config.default_key_specs.algorithm == "rsasha1"
	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_dns_managed_zone",
		"resourceName": tf_lib.get_resource_name(dnssec_config, name),
		"searchKey": sprintf("google_dns_managed_zone[%s].dnssec_config.default_key_specs.algorithm", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "dnssec_config.default_key_specs.algorithm isn't 'rsasha1'",
		"keyActualValue": "dnssec_config.default_key_specs.algorithm is 'rsasha1'",
	}
}
