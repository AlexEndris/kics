package Cx

import data.generic.terraform as tf_lib

CxPolicy[result] {
	compute := input.document[i].resource.google_compute_instance[name]
	metadata := compute.metadata
	oslogin := object.get(metadata, "enable-oslogin", "undefined")
	isFalse(oslogin)

	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_compute_instance",
		"resourceName": tf_lib.get_resource_name(compute, name),
		"searchKey": sprintf("google_compute_instance[%s].metadata.enable-oslogin", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("google_compute_instance[%s].metadata.enable-oslogin is true or undefined", [name]),
		"keyActualValue": sprintf("google_compute_instance[%s].metadata.enable-oslogin is false", [name]),
	}
}

isFalse(value) {
	is_string(value)
	lower(value) == "false"
}

isFalse(value) {
	is_boolean(value)
	not value
}
