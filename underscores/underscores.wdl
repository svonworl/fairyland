version 1.0

task underscores {
  input {
    String _underscore_input_
    #String underscore_input_
  }
  
  command <<<
    echo "Doing nothing..."
  >>>
  
  output {
    String _underscore_output_ = "_"
    #String underscore_output_ = "_"
  }

  runtime {
    memory: "4 GB"
    docker: "ubuntu:latest"
    preemptibles: "1"
  }
}

workflow proof_of_concept {
  input {
    String nothing
  }
  
  call underscores {
    input:
      _underscore_input_ = nothing
      #underscore_input_ = nothing
  }
}