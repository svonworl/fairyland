task outputs_with_unknown_names {
	input {
		File to_rename
	}
	
	command <<<
		# Obligatory disclaimer: Do not use this to generate an encryption key or password
		tree
		mv ~{whatever} $RANDOM
		tree
	>>>
	
	output {
		String renamed_file = "oops"
	}
}

workflow proof_of_concept {
	input {
		File some_input_with_no_extension
	}
	
	call outputs_with_unknown_names {
		input:
			to_rename = some_input_with_no_extension
	}
}