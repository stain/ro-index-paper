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

baseCommand: "scrapy"

hints:
  SoftwareRequirement:
    packages:
      python3-scrapy:
          specs:
            - https://anaconda.org/conda-forge/scrapy
            - https://packages.debian.org/buster/python3-scrapy
            - https://packages.debian.org/bullseye/python3-scrapy
            - https://packages.debian.org/sid/python3-scrapy
          version: [ "1.7.3", "1.5.1"] 
  DockerRequirement:
    dockerPull: aciobanu/scrapy


requirements:
  InitialWorkDirRequirement:
    listing:
      - class: File
        location: scrapy-meta.py

arguments:
  - "runspider"
  - position: 100
    valueFrom: "scrapy-meta.py"

    
inputs:
  url:
    type: string
    doc: URL of HTML document to extract links from
    inputBinding:
      prefix: "-aurl="
      separate: false
      position: 1

outputs:
  links:
    type: stdout
    streamable: true
    doc: The link URLs found, separated by newline

stdout: links.txt

label: "scrapy find meta rel=alternate links"

doc: >
    Parse HTML and find meta link elements with rel="alternate"

