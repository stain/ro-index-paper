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
#- "--silent"  ## uncomment to avoid usual logging to stderr
- "--show-error" ## ..except errors to stderr
- "--fail-early" ## Disabled as --fail does not make sense on multiple URIs, 
## consider --fail-early from curl 7.52.0
- "--retry"  ## Incremental backoff: 1s 2s 4s 8s 16s 32s 64s 128s 256s 512s
- "10"
- "--retry-connrefused" # Requires 7.52.0
- "--location" ## Follow HTTP redirects
- "--remote-name-all" ## Save URLs to filenames from URI paths
- "--dump-header"  ## Record http response
- "-" # .. on stdout

hints:
  SoftwareRequirement:
    packages:
      curl:
        specs: 
          - https://anaconda.org/conda-forge/curl      
        version: [ "7.66.1" ] ## 7.66.1 to honour "429 Too Many Requests" rate-limiting from Zenodo
  DockerRequirement:
    # TODO: curlimages/curl:7.66.1 awaiting https://github.com/curl/curl/pull/4465 release
    dockerPull: stain/curl:7.67-DEV-f2941608f61adf1b2224ff4db400ffaeda3ea210

inputs:
  urls:
    type: string[]
    doc: >
      The URLs of the resources to be downloaded. 
      Any HTTP redirections (302/303/307/308) will be followed.
      The file names for saving are extracted from the given URLs, e.g.
      [ "http://example.com/foo.txt", "http://other.example.net/nested/bar.txt"]
      will be downloaded as files named "foo.txt" "bar.txt"
    inputBinding:
      position: 100
  acceptType:
    type: string
    doc: >
      Optional IANA media-type to request using Accept: header, 
      for example "application/json" or "text/html".
      The default "*/*" requests any content type.
    s:about: "https://tools.ietf.org/html/rfc7231#section-5.3.2"
    default: "*/*"
    inputBinding:
      prefix: "--header"
      valueFrom: "Accept: $(inputs.acceptType)"

outputs:
  downloaded:
    type: File[]
    doc: >
      The downloaded files. Note that the order may not correspond to the order
      of the input list "urls". This list may be shorter than "urls" if there were 
      redirections or errors in downloading (see the output "headers"), 
      or because multiple URLs had the same file path ending 
      (last URL overwrites).
    format: "https://www.iana.org/assignments/media-types/$(inputs.acceptType)"
    outputBinding:
      glob: "*"
  headers:
    type: stdout
    streamable: true
    doc: > 
      A log of the HTTP response headers. If HTTP redirection with a 
      "Location:" header was received, an empty line separates the headers
      from subsequent requests. An empty line thereafter separates the headers
      from subsequent URL requests, repeated as above.

stdout: ".headers.txt" # avoid matching glob * in downloaded

label: "curl: download HTTP files from URLs"

doc: > 
  curl will download the HTTP/HTTPS files from the given URLs,
  following any redirections. A list of files is returned, using
  filenames reflecting the URI path.

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

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/

