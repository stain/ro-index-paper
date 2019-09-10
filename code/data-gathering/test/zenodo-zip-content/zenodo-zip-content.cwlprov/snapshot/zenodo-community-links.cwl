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

label: "find downloadable files in zenodo community"

doc: > 
  For a given Zenodo community, retrieve a list of all its downloadable files

requirements:
  - class: StepInputExpressionRequirement
  - class: ScatterFeatureRequirement
#  - class: InlineJavascriptRequirement

inputs:
  community:
    type: string
    default: ro
    doc: >
      The short-name of the Zenodo community, e.g. "ro" for <https://zenodo.org/communities/ro>

outputs:
  urls:
    type: File
    streamable: true
    doc: >
      A list of downloadable URLs across the community
    outputSource: flatten/concatinated

steps:
    list-ids:
      run: ../tools/oai-pmh.cwl
      in: 
        baseurl:
          valueFrom: "https://zenodo.org/oai2d"
        set:
          source: community
          valueFrom: user-$(self)
      out: [identifiers]
    make-uri:
      run: ../tools/sed.cwl
      
      in:
        original:
          source: list-ids/identifiers
        command:
          # Assumes Zenodo's correspondance between OAI identifiers and
          # HTML URL
          valueFrom: "s,oai:zenodo.org:,https://zenodo.org/record/,"
      out: [modified]
    split-ids-by-line:
      in:
        file:
          source: make-uri/modified
      out: [lines]
      run: ../tools/split-by-line.cwl

    fetch-meta:
      run: ../tools/scrapy-meta.cwl
      scatter: [url]
      in:
        url:
          source: split-ids-by-line/lines
      out: [links]
    
    flatten:
      run: ../tools/cat.cwl
      in:
        files: 
          source: fetch-meta/links
      out: [concatinated]

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
    s:instrument: "../test/zip=zenodo-to-rdfa-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: https://schema.org/
