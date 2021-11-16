#!/usr/bin/env cwl-runner

cwlVersion: v1.2 # Q1: Tool I'm converting is v1.1, is that okay?
class: Workflow
# Q2: Do the label and doc strings go here or elsewhere?
# Q3: Should the namespaces be deleted?

# To wrap the CWL tool in a workflow you will still need to specify the inputs and outputs
inputs:
  ## Specify the inputs to the CWL workflow here
  ## They will be the same as the CWL tool inputs

  # Q4: Can these stay in the format used in the tool? ie, using id format
  - id: gds_file
    label: GDS file
    doc: GDS file
    type: File
    inputBinding:
      position: 1
      shellQuote: false
  - id: out_prefix
    label: Output prefix
    doc: Prefix for output files
    type: string
    inputBinding:
      position: 2
      valueFrom: |-
        ${
            var chr = inputs.gds_file.nameroot.split('chr')[1]
            return inputs.out_prefix + "_allele_freq_chr" + chr + ".rds"
        }
      shellQuote: false
  - id: sample_file
    label: Sample file
    doc: RDS file with vector of sample.id to include in calculating allele frequency
    type: File?
    inputBinding:
      prefix: --sample.file
      position: 3
      shellQuote: false
  - id: cpu
    type: int?
    inputBinding:
      prefix: --cpu
      position: 4
      shellQuote: false
    sbg:toolDefaultValue: '1' 

outputs:
  ## Specify the outputs from the CWL workflow here
  ## They will be the same as the outputs from the CWL tool
  - id: output_file
    label: Output file
    doc: |-
      RDS file containing R data.frame with variant.id, chromosome, position, and alternate allele frequency.
    type: File
    outputBinding:
      glob: '*.rds'

steps:
  cwl_tool_wrapper_workflow_step:
    in:
      ## Specify the inputs to the CWL tool here
       gds_file: gds_file
       out_prefix: out_prefix
       sample_file: sample_file
       cpu: cpu

    out:
      ## Specify the outputs from the CWL tool here
      - id: output_file
        label: Output file
        doc: |-
          RDS file containing R data.frame with variant.id, chromosome, position, and alternate allele frequency.
        type: File
        outputBinding:
          glob: '*.rds'
    run:
      cwlVersion: v1.1
      class: CommandLineTool
      label: Allele frequency
      doc: This tool is for testing only. All good code is by Stephanie Gogarten and Walt Shands. All bad code is by Ash O-apostrophe-Farrell.
        
      #dct:creator:
      #  "@id": "http://orcid.org/0000-0002-7231-9745"
      #  foaf:name: Stephanie Gogarten
      #  foaf:mbox: sdmorris@uw.edu
        
      requirements:
      - class: ShellCommandRequirement
      - class: ResourceRequirement
        coresMin: ${ return inputs.cpu }
      - class: DockerRequirement
        dockerPull: uwgac/simphen:0.2.2
      - class: InlineJavascriptRequirement

      inputs:
      - id: gds_file
        label: GDS file
        doc: GDS file
        type: File
        inputBinding:
          position: 1
          shellQuote: false
      - id: out_prefix
        label: Output prefix
        doc: Prefix for output files
        type: string
        inputBinding:
          position: 2
          valueFrom: |-
            ${
                var chr = inputs.gds_file.nameroot.split('chr')[1]
                return inputs.out_prefix + "_allele_freq_chr" + chr + ".rds"
            }
          shellQuote: false
      - id: sample_file
        label: Sample file
        doc: RDS file with vector of sample.id to include in calculating allele frequency
        type: File?
        inputBinding:
          prefix: --sample.file
          position: 3
          shellQuote: false
      - id: cpu
        type: int?
        inputBinding:
          prefix: --cpu
          position: 4
          shellQuote: false
        sbg:toolDefaultValue: '1'

      outputs:
      - id: output_file
        label: Output file
        doc: |-
          RDS file containing R data.frame with variant.id, chromosome, position, and alternate allele frequency.
        type: File
        outputBinding:
          glob: '*.rds'

      baseCommand:
      - Rscript
      - /usr/local/simulate_phenotypes/tools/allele_freq.R

      stdout: job.out.log
      hints:
      - class: sbg:SaveLogs
        value: job.out.log


