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

label: "List ZIP content for zenodo community"

doc: > 
  For a given Zenodo community, list file content of its downloadable *.zip files

requirements:
  - class: StepInputExpressionRequirement
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  community:
    type: string
    default: ro
    doc: >
      The short-name of the Zenodo community, e.g. "ro" for <https://zenodo.org/communities/ro>

outputs:
  zip-content:
    type: File
    doc: >
      Filenames found across ZIP files
    outputSource: flatten/concatinated
    #outputSource: zip-content-by-url/zip-content

steps:
    zenodo-community-links:
      run: zenodo-community-links.cwl
      in: 
        community: community
      out: [urls]
    
    split-links:
      in:
        file:
          source: zenodo-community-links/urls
      out: [lines]
      run: ../tools/split-by-line.cwl

    filter-zip-extension:
      label: Filter *.zip
      doc: >
        Select only those downloadable files which URL indicate a known
        ZIP file extension (*.zip for now)
      in: 
        list:
          source: split-links/lines
      out: [filtered]
      #scatter: [list]
      run: 
        class: ExpressionTool
        inputs:
          list:
            type: string[]
        outputs:
          filtered:
            type: string[]
        expression: |
          ${return { "filtered": 
                  inputs.list.filter(function (url) { return url.endsWith(".zip") })
              }
          }

    zip-content-by-url:
      in:
        urls:
          source: filter-zip-extension/filtered
      run: 
        class: Workflow
        inputs: 
          urls:
            type: string[]
        steps:
          list-zip-content:
            in:
              url:
                source: urls
            scatter: url
            scatterMethod: flat_crossproduct
            run: zip-content-by-url.cwl
            out: [filenames]
        outputs: 
          zip-content:
            type: File[]
            outputSource: list-zip-content/filenames
      #scatter: [urls]
      #scatterMethod: flat_crossproduct
      out: [zip-content]

    flatten:
      run: ../tools/cat.cwl
      in:
        files: 
          source: zip-content-by-url/zip-content
      out: [concatinated]

s:creator:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9842-9718
    s:name: Stian Soiland-Reyes

s:codeRepository: https://github.com/stain/ro-index-paper/
s:dateCreated: "2019-09-06"
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
