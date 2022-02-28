version 1.0

task ab_string {
  input {
    String nothing
  }
  
  command <<<
    echo "Doing nothing..."
  >>>
  
  output {
    String a = "a"
    String ab = a + "b"
  }

  runtime {
    memory: "4 GB"
    docker: "ubuntu:latest"
    preemptibles: "1"
  }
}

task ab_file {
  input {
    String nothing
  }
  
  command <<<
    touch a.txt
    echo "hello world" > a.txt
  >>>
  
  output {
    String a = read_string("a.txt")
    String ab = a + "b"
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
  
  call ab_string {
    input:
      nothing = nothing
  }

  call ab_file {
    input:
      nothing = nothing
  }
}