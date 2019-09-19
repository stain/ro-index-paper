#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

#  Copyright 2019 The University of Manchester
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

baseCommand: "jq"

# See https://stedolan.github.io/jq/manual/v1.5/#Invokingjq
#arguments: 
#- --seq # application/json-seq

hints:
  SoftwareRequirement:
    packages:
      jq:
        specs: 
          - https://anaconda.org/conda-forge/jq
          # - https://packages.debian.org/jessie/jq ## Disabled as it's 1.4
          - https://packages.debian.org/stretch/jq
          - https://packages.debian.org/buster/jq
          - https://packages.debian.org/bullseye/jq
          - https://packages.debian.org/sid/jq
        version: [ "1.5", "1.6" ]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/jq:1.5--0

inputs:
  slurp:
    type: boolean
    default: false
    doc: >
      Instead of running the filter for each JSON object in the input, 
      read the entire input stream into a large array and run 
      the filter just once.
    inputBinding:
      prefix: --slurp
      position: 1

  filter:
    type: string
    default: .
    doc: >
        A jq filter runs on a stream of JSON data, for instance
        the filter .foo on { "bar": 1, "foo": [1,2,3] } will 
        output [1,2,3]. Filters can be chained together with |.
        See <https://stedolan.github.io/jq/manual/v1.5/#Basicfilters> for
        details.
    inputBinding:
      position: 2

  json:
    type: File[]
    streamable: true
    doc: >
      JSON files which will be filtered. Each file may contain multiple
      JSON sequences separated by whitespace 
      (e.g. output from another jq execution)
    inputBinding:
      position: 3

outputs:
  filtered:
    type: stdout
    streamable: true
    doc: > 
        The result of applying the jq filter, returned as a sequence
        of JSON elements, separated by whitespace.

stdout:
  filtered.jsonseq

label: "jq: JSON processor"

doc: >
  JQ is a lightweight and flexible command-line JSON processor
  that consumes a stream of JSON expressions separated by whitespace, 
  applies the specified filter(s), and outputs result as JSON
  separated by whitespace.

s:url: https://stedolan.github.io/jq/
s:mainEntityOfPage: https://stedolan.github.io/jq/manual/v1.5/
s:codeRepository: https://github.com/stedolan/jq
s:license: https://spdx.org/licenses/MIT
s:sdLicense: https://spdx.org/licenses/Apache-2.0 
s:sdPublisher: https://orcid.org/0000-0001-9842-9718

s:author:
  - class: s:Person    
    s:name: Stephen Dolan
    s:url: http://stedolan.net/

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/jq-filter/jq-filter-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/
