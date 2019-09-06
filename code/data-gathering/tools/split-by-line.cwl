#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: ExpressionTool

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

requirements:
  - class: InlineJavascriptRequirement 

label: Split by line
doc: >
    Read file content and split by newline into array of strings.

inputs:
    file:
        doc: >
            File to split by line. Note that the file should not be larger
            than the CWL restrictions for loadContents (64 kiB) and should
            have Windows (\r\n) or UNIX file endings (\n)
        type: File
        inputBinding:
            loadContents: true

outputs:
    lines:
        doc: >
            Array of lines from file, excluding newline symbol.
        type: string[]

expression: |
    ${ return {"lines": inputs.file.contents.split(/\r?\n/g) }; }

s:creator:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9842-9718
    s:name: Stian Soiland-Reyes

s:codeRepository: https://github.com/stain/ro-index-paper/
s:dateCreated: "2019-08-21"
s:license: https://spdx.org/licenses/Apache-2.0 

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/split-by-line/split-by-line-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  s: http://schema.org/
