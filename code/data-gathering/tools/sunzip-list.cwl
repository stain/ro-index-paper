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
#  limitatiopathsns under the License.

label: "sunzip: list files from zip stream"

doc: >
  sunzip is a streaming unzip tool that bypasses or delays the 
  need for reading the ZIP files table of content, which is
  located at end of the ZIP file. 

  The sunzip -l option print the file and directory names 
  as they are encountered in the stream, without uncompressing
  any of the content.

  Note that file names from the local file headers are less reliable 
  than the end-of-file TOC that would otherwise be used, and 
  may include duplicates, deleted and encrypted files.

  The output may be incomplete or wrong if the ZIP file is corrupt
  or incomplete. 

baseCommand: sunzip
arguments: ["-t", "-q"]

hints:
  DockerRequirement:
    dockerPull: stain/sunzip

inputs:
  zipstream:
    doc: > 
      File or stream of .zip file that should be read. The file will be
      read in a streaming mode.
    type: stdin
    streamable: true
    # Disabled to avoid error when using with more generic curl-get.zip
    # ERROR [step list] Cannot make job: Expected value of 'zipstream' to have format https://www.iana.org/assignments/media-types/application/zip but File has no 'format' defined: {

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

s:author:
  - class: s:Person
    s:identifier: http://dbpedia.org/resource/Mark_Adler
    s:url: https://github.com/madler
    s:name: Mark Adler

s:contributor:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9842-9718
    s:name: Stian Soiland-Reyes

s:codeRepository: https://github.com/stain/sunzip/
s:isBasedOn: https://github.com/madler/sunzip
s:dateModified: "2019-08-13"
s:license: https://spdx.org/licenses/Zlib 
s:sdLicense: https://spdx.org/licenses/Apache-2.0 
s:sdPublisher: https://orcid.org/0000-0001-9842-9718
s:description: |
  stain/sunzip is a fork of madler/sunzip, a streaming unzip utility. 
  The modifications add a -l list option to print the file and directory
  names as they are encountered in the stream. 

  Note that file names from the local file headers are less reliable 
  than the end-of-file TOC that would otherwise be used, and 
  may include duplicates, deleted and encrypted files.

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/sunzip-list/sunzip-list-job.yml"
    s:object: "../test/sunzip-list/test.zip"
    s:result: "../test/sunzip-list/test-sunzip-files.txt"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/
