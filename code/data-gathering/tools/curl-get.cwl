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

baseCommand: "curl"
arguments: 
- "--silent"
- "--show-error"
- "--fail"
- "--location"
- "--dump-header"
- "headers.txt"

hints:
  SoftwareRequirement:
    packages:
      curl:
        specs: 
          - https://anaconda.org/conda-forge/curl
          - https://packages.debian.org/jessie/curl
          - https://packages.debian.org/stretch/curl
          - https://packages.debian.org/buster/curl
          - https://packages.debian.org/bullseye/curl
          - https://packages.debian.org/sid/curl
        version: [ "7.39.0", "7.65.3", "7.38.0", "7.52.1", "7.64.0", "7.65.3" ]
  DockerRequirement:
    dockerPull: appropriate/curl:3.1

inputs:
  url:
    type: string
    doc: >
      The URL of the resource to be downloaded. 
      Any HTTP redirections (302/303/307/308) will be followed.
    inputBinding:
      position: 1
  acceptType:
    type: string
    doc: >
      Optional IANA media-type to request using Accept: header, 
      for example "application/json" or "text/html".
      The default "*/*" requests any content type.
    s:about: https://tools.ietf.org/html/rfc7231#section-5.3.2
    default: "*/*"
    inputBinding:
      prefix: "--header"
      valueFrom: "Accept: $(inputs.acceptType)"

outputs:
  downloaded:
    type: stdout
    streamable: true
    doc: The downloaded file, written in streamable mode.
    format: "https://www.iana.org/assignments/media-types/$(inputs.acceptType)"
  headers:
    type: File
    streamable: true
    doc: > 
      A log of the HTTP response headers. If HTTP redirection with a 
      Location: header was received, an empty line separates the headers
      from subsequent requests.
    outputBinding:
      glob: headers.txt

stdout: downloaded

label: "curl: download HTTP resource from URL"

doc: > 
  curl will download a HTTP/HTTPS resource or file from a given URL,
  following any redirections.

s:author:
  - class: s:Person
    s:identifier: https://keybase.io/bagder
    s:name: Daniel Stenberg

s:codeRepository: https://github.com/curl/curl
s:url: https://curl.haxx.se/
s:license: https://spdx.org/licenses/curl
s:sdLicense: https://spdx.org/licenses/Apache-2.0 
s:description: >
  curl is a command line tool and library for transferring data with URLs.
s:version: "7.39.0"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: https://schema.org/

