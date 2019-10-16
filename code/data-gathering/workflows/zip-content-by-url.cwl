#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

#  Copyright 2019 The University of Manchester
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  Y=ou may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

label: "list ZIP content by URL"

# Uncomment if needing valueFrom: instead of default:
requirements:
    - class: StepInputExpressionRequirement


doc: > 
  curl will download a HTTP/HTTPS resource or file from a given URL,
  following any redirections.

inputs:
  url:
    type: string
    doc: >
      The URL of the ZIP archive to inspect.

outputs:
  filenames:
    type: File
    streamable: true
    doc: >
      A list of filenames and directories encountered in the ZIP archive, 
      seperated by newline. 
    outputSource: list/filenames
  headers:
    type: File
    streamable: true
    doc: > 
      A log of the HTTP response headers.
    outputSource: fetch/headers

steps:
    fetch:
        run: ../tools/curl-get.cwl
        in: 
            url: url
            acceptType:
                default: "application/zip"
        out: [downloaded, headers]
    list:
        in:
            zipstream: fetch/downloaded
        out: [filenames]
        #run: ../tools/sunzip-list.cwl
        run: ../tools/jar-list.cwl


s:creator:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9842-9718
    s:name: Stian Soiland-Reyes

s:codeRepository: https://github.com/stain/ro-index-paper/
s:dateCreated: "2019-08-20"
s:license: https://spdx.org/licenses/Apache-2.0 

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/zip=content-by-url/zip=content-by-url-job.yml"
    s:object: "https://github.com/stain/ro-index-paper/archive/38f2a711f9f115e92cea930398019c147e56ac5a.zip"
    s:result: "../test/zip=content-by-url/filenames.txt"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: https://schema.org/
