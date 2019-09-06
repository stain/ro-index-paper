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

baseCommand: "sed"

hints:
  SoftwareRequirement:
    packages:
      sed:
          specs:
            - https://anaconda.org/conda-forge/sed
            - https://packages.debian.org/jessie/sed
            - https://packages.debian.org/stretch/sed
            - https://packages.debian.org/buster/sed
            - https://packages.debian.org/bullseye/sed
            - https://packages.debian.org/sid/sed
          version: [ "4.2.2", "4.4", "4.7"] # .. and many more
  DockerRequirement:
    dockerPull: debian:9

arguments:
  - "--unbuffered"
  - "--regexp-extended"

inputs:
  original:
    type: File
    streamable: true
    doc: >
      The original file or byte stream which content is to be modified
    inputBinding:
      position: 2

  command:
    type: string
    doc: |
      The regular expression to be used for search-replace, 
      in the form of a sed "s/from/to/" command, e.g. 
      "s/^/_/" will insert an underscore at beginning of each line, 
      while "s/http/https/g" will replace every "http" with "https".

      This CWL wrapper enables the extended (ERE) regular expression
      and operates in streamable mode.

      See also 
      <https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html> and 
      <https://www.gnu.org/software/sed/manual/html_node/sed-regular-expressions.html>
    inputBinding:
      position: 1

outputs:
  modified:
    type: stdout
    streamable: true
    doc: The modified text file

stdout: modified.txt

label: "sed search-replace"

doc: >
    Search-replace a stream using regular expressions and other SED commands.

s:author:
  - class: s:Person
    s:name: Jay Fenlason
  - class: s:Person
    s:name: Tom Lord
  - class: s:Person
    s:name: Ken Pizzini
  - class: s:Person
    s:name: Paolo Bonzini

s:copyrightHolder:
  - class: s:Organization
    s:name: Free Software Foundation
    s:url: https://www.fsf.org/

s:url: https://www.gnu.org/software/sed/
s:mainEntityOfPage: https://www.gnu.org/software/sed/manual/
s:codeRepository: https://github.com/LibreCat/perl-oai-lib/
s:license: https://spdx.org/licenses/GPL-3.0-or-later
s:sdLicense: https://spdx.org/licenses/Apache-2.0 
s:sdPublisher: https://orcid.org/0000-0001-9842-9718
s:description: >
     sed (stream editor) is a non-interactive command-line text editor. 

     sed is commonly used to filter text, i.e., it takes text input, performs 
     some operation (or set of operations) on it, and outputs the modified text. 
     sed is typically used for extracting part of a file using pattern matching or 
     substituting multiple occurrences of a string within a file. 

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/sed-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/
