#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

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

label: "retrieve metadata from Zenodo community"

doc: > 
  For a given Zenodo community, retrieve its repository records
  as Zenodo JSON and (eventually) schema.org JSON-LD and DataCite v4 XML.

requirements:
  - class: StepInputExpressionRequirement
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  community:
    type: string?
    default: ro
    doc: >
      The short-name of the Zenodo community, e.g. "ro" for <https://zenodo.org/communities/ro>
      Use null for all of Zenodo.

outputs:
  zenodo-json:
    type: Directory
    doc: >
      A directory of Zenodo JSON records retrieved from the given Zenodo community
    outputSource: gather-json/gathered

steps:
    list-ids:
      run: ../tools/oai-pmh.cwl
      in: 
        baseurl:
          valueFrom: "https://zenodo.org/oai2d"
        set:
          source: community
          valueFrom: user-$(self) ## TODO: Does this work if community is null?
      out: [identifiers]

    make-uri:
      doc: > 
        Search-replace from oai identifier to Zenodo API URL
      run: ../tools/sed.cwl 
      in:g
        original:
          source: list-ids/identifiers
        command:
          # Assumes Zenodo's correspondance between OAI identifiers and
          # Zenodo's API URI template.
          # NOTE: This uses undocumented Zenodo API call, see
          # <https://github.com/zenodo/zenodo/blob/master/zenodo/config.py#L814>
          valueFrom: "s,oai:zenodo.org:,https://zenodo.org/api/records/,"
      out: [modified]

    chunk-by-line:
      in:
        splittable:
          source: make-uri/modified
        maxlines:
          default: 5 # Number of URIs for curl to fetch at same time (reusing HTTP connection)
      out: [splitted]
      run: ../tools/split-lines.cwl

    split-ids-by-line:
      in:
        file:
          source: chunk-by-line/splitted
      out: [lines]
      run: ../tools/split-by-line.cwl
      scatter: [file]

    fetch-zenodo-json:
      ## TODO: Set resource requirements
      ## to avoid too many concurrent requests
      run: ../tools/curl-get-many.cwl
      scatter: [urls]
      in:
        urls:
          source: split-ids-by-line/lines
        acceptType: 
            valueFrom: "application/vnd.zenodo.v1+json"
      out: [downloaded]

    fetch-zenodo-jsonld:
      run: ../tools/curl-get-many.cwl
      scatter: [urls]
      in:
        urls:
          source: split-ids-by-line/lines
        acceptType: 
            valueFrom: "application/ld+json"
      out: [downloaded]

    fetch-zenodo-datacite4:
      run: ../tools/curl-get-many.cwl
      scatter: [urls]
      in:
        urls:
          source: split-ids-by-line/lines
        acceptType: 
            valueFrom: "application/x-datacite-v41+xml"
      out: [downloaded]

    gather-json:
      run:
        class: ExpressionTool
        inputs:
          name:
            type: string
          files:
            type: 
              type: array
              items: 
                type: array
                items: File
        outputs:
          gathered:
            type: Directory
        expression: |
          ${return { "gathered": {
              "class": "Directory",
              "name": inputs.name,
              "listing": inputs.files, // TODO: Rename each file to add extension .json
              "path": "."
              }
            };
          }
      in:
        files: 
          source: fetch-zenodo-json/downloaded
        name: 
            default: "zenodo-json"
      out: [gathered]

s:creator:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9842-9718
    s:name: Stian Soiland-Reyes

s:codeRepository: https://github.com/stain/ro-index-paper/
s:dateCreated: "2019-08-23"
s:license: https://spdx.org/licenses/Apache-2.0 

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/zenodo-records/zenodo-records-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: https://schema.org/
