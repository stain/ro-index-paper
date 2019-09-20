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

baseCommand: "jar"
arguments: 
- "t"

hints:
  SoftwareRequirement:
    packages:
      openjdk:
        specs: 
          - https://anaconda.org/conda-forge/openjdk
#          - https://packages.debian.org/jessie/java/openjdk-7-jre ## untested
          - https://packages.debian.org/stretch/openjdk-8-jdk-headless
          - https://packages.debian.org/buster/openjdk-11-jdk-headless
          - https://packages.debian.org/bullseye/openjdk-11-jdk-headless
          - https://packages.debian.org/sid/openjdk-11-jdk-headless
        version: [ "11.0.1", "11.0.4", "10.0.1", "8u162-b12-1", "8u222-b10-1ubuntu1", "8u222-b10-1" ]
  DockerRequirement:
    dockerPull: openjdk:11.0-slim

label: "jar: list zip file content"

doc: > 
  List content of a ZIP file using OpenJDK jar, which can
  process the ZIP file in a streaming fashion.


inputs:
  zipstream:
    doc: > 
      File or stream of .zip file that should be read. The file will be
      read in a streaming mode.
    type: stdin
    streamable: true
    format: iana:application/zip

outputs:
  filenames:
    type: stdout
    streamable: true
    doc: >
      A list of filenames and directories encountered in the ZIP archive, 
      seperated by newline. Paths are relative to the root of the ZIP archive.
      The list is written in a streaming mode.

stdout: filenames.txt

s:codeRepository: https://hg.openjdk.java.net/jdk/jdk11/file/1ddf9a99e4ad/src/jdk.jartool
s:url: https://openjdk.java.net/
s:license: https://spdx.org/licenses/GPL-2.0-with-classpath-exception
s:sdLicense: https://spdx.org/licenses/Apache-2.0 

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/

