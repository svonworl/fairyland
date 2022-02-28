version 1.0

task outputs_with_unknown_names {
	input {
		File to_rename
		File also_to_rename
	}
	
	command <<<
		# Obligatory disclaimer: Do not use this to generate an encryption key or password
		NEW_NAME=$RANDOM
		mv ~{to_rename} $NEW_NAME # this will not only rename but also move it to workdir
		echo $NEW_NAME | tee -a output.txt
		
		NEW_NEW_NAME=$RANDOM
		mv ~{also_to_rename} $NEW_NEW_NAME
		echo $NEW_NEW_NAME | tee -a output.txt
	>>>
	
	output {
		#File renamed_file = read_lines(stdout()) # fail, read_lines() returns Array[File]
		#File renamed_file = stdout()             # pass, but returns the stdout file instead of the actual renamed file
		#File renamed_file = $NEW_NAME            # syntax error
		#File renamed_file = $(NEW_NAME)          # syntax error
		#File renamed_file = ${NEW_NAME}          # syntax error
		#File renamed_file = read_string("NEW_NAME") # fail, interprets it as a filename
		#File renamed_file = read_string("output.txt") # this works for one file output
		Array[File] renamed_files = read_lines("output.txt")
	}

	runtime {
		memory: "4 GB"
		docker: "ubuntu:latest"
		preemptibles: "1"
	}
}

workflow proof_of_concept {
	input {
		File some_input_with_no_extension
		File another_input
	}
	
	call outputs_with_unknown_names {
		input:
			to_rename = some_input_with_no_extension,
			also_to_rename = another_input
	}
}