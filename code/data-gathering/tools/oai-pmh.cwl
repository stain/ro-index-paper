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

baseCommand: "oai_pmh"
arguments: 
- "--request" 
- "ListIdentifiers"
- shellQuote: false
  position: 100
  valueFrom: "| grep identifier:"
- shellQuote: false
  position: 200
  valueFrom: "| sed 's/^.*identifier: //g'"

requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: stain/perl-oai-lib:branch-429-retry-after
    # patched to support 429 Retry-After, see
    # <https://github.com/LibreCat/perl-oai-lib/pull/7>

inputs:
  baseurl:
    type: string
    doc: >
      The OAI-PMH base URL, e.g. "https://zenodo.org/oai2d"
    inputBinding:
      position: 1
  set:
    type: string?
    inputBinding:
        prefix: "--set"
  metadataPrefix:
    type: string
    default: oai_dc
    inputBinding:
        prefix: "--metadataPrefix"

outputs:
  identifiers:
    type: stdout
    streamable: true
    doc: The OAI-PMH identifiers
stdout: identifiers

label: "oai_pmh ListIdentifiers"

doc: > 
    List repository identifiers using OAI-PMH protocol

s:author:
  - class: s:Person    
    #s:identifier: https://orcid.org/0000-0001-6844-0123  ## Unverified
    s:url: https://github.com/timbrody
    s:name: Tim Brody

# From https://metacpan.org/pod/HTTP::OAI::Harvester
s:contributor:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8390-6171
    s:name: Patrick Hochstenbach
    s:url: https://github.com/phochste
  - class:  s:Person
    s:name: Gregor Herrman
    s:url:  https://metacpan.org/author/GREGOA
  - class: s:Person
    s:name: Jakob Voss
  - class: s:Person
    s:name: Mohammad S Anwar
    s:url: https://metacpan.org/author/MANWAR
  - class: s:Person
    s:name: Nicolas Steenlant
  - class: s:Person
    s:name: Sebastien Francois
  - class: s:Person
    s:name: Stephen Thirlwall
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9842-9718/
    s:name: Stian Soiland-Reyes
    s:url: https://github.com/stain


s:publisher: 
 - class: s:Organization
   s:name: LibreCat
   s:url: https://librecat.org/

s:url: https://metacpan.org/pod/HTTP::OAI::Harvester
s:codeRepository: https://github.com/LibreCat/perl-oai-lib/
s:isBasedOn: https://github.com/timbrody/perl-oai-lib
s:license: https://spdx.org/licenses/BSD-3-Clause
s:sdLicense: https://spdx.org/licenses/Apache-2.0 
s:sdPublisher: https://orcid.org/0000-0001-9842-9718
s:description: |
    OAI-PERL are a set of Perl modules that provide an API to the Open Archives
    Initiative Protocol for Metadata Harvesting (OAI-PMH).

    OAI-PMH is a XML-over-HTTP protocol for transferring metadata between a
    repository (the HTTP server) and service provider (the HTTP client).

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/oai-pmh-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/
