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

baseCommand: "cat"
arguments: 
- "--squeeze-blank"

hints:
  SoftwareRequirement:
    packages:
      coreutils:
        specs: 
          - https://anaconda.org/conda-forge/coreutils
          - https://packages.debian.org/jessie/coreutils
          - https://packages.debian.org/stretch/coreutils
          - https://packages.debian.org/buster/coreutils
          - https://packages.debian.org/bullseye/coreutils
          - https://packages.debian.org/sid/coreutils
        version: [ "7.39.0", "7.65.3", "7.38.0", "7.52.1", "7.64.0", "7.65.3" ]
  DockerRequirement:
    dockerPull: debian:9

inputs:
  files:
    type: File[]
    streamable: true
    doc: >
      A list of files to be concatinated
    inputBinding:
      position: 1

outputs:
  concatinated:
    type: stdout
    streamable: true
    doc: The concatinated file, written in streamable mode.    

stdout: concatinated

label: "cat: concatinate files"

doc: > 
  concatinate files to a single streamable file


$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/

