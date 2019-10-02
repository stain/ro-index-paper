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

baseCommand: "split"

requirements:
  - class: InlineJavascriptRequirement 

hints:
  SoftwareRequirement:
    packages:
      coreutils:
          specs:
            - https://anaconda.org/conda-forge/coreutils
            - https://packages.debian.org/jessie/coreutils
            - https://packages.debian.org/stretch/coreutils
            - https://packages.debian.org/buster/coreutils
            - https://packages.debian.org/bullseye/coreutils
            - https://packages.debian.org/sid/coreutils
          version: [ "8.31", "8.30", "8.26", "8.23"] # .. and many more
  DockerRequirement:
    dockerPull: debian:10

inputs:
  splittable:
    type: File
    streamable: true
    doc: >
      The file which should be split
    inputBinding:
      position: 100

  prefix:
    type: string?
    default: x
    doc: > 
      Prefix for generated files, the default is "x", 
      e.g. generating "xaa", "xab", etc.
      
  lines:
    type: int?
    default: 1000
    doc: >
        maximum number of lines/records per output file. The last file may
        have less lines.
    inputBinding:
      prefix: "--lines"

  extension:
    type: string?
    doc: >
      Optional extension (additional suffix) for generated files, e.g. ".txt" 
      will generate "xaa.txt", "xab.txt" etc. The default is no extension.
    inputBinding:
      prefix: "--additional-suffix"

  separator:
    type: string?
    doc: >
      Character to split input file into records; default is \n (newline).

      This parameter must be an unescaped single character 
      (which may need to be escaped in CWL/YAML/JSON/shell),
      e.g. in YAML syntax \x1e for ASCII control character RE record separator.
      
      To split by NUL character use quoted literal
      '\0' in shell or double backslash \\0 in YAML
      
    inputBinding:
      prefix: "--separator"

outputs:
  smaller:
    type: File[]
    doc: The split files. 
    outputBinding:
      glob: "*"
      # The CWL glob pattern 
      # <https://www.commonwl.org/v1.0/CommandLineTool.html#CommandOutputBinding>
      # does not guarantee any particular order, although particular file systems
      # and CWL engines might give such an apparence.
      #
      # To ensure consistency with line order in file input, sort File[] array
      # in alphabetical order by the attribute basename.
      outputEval: |
        ${
          // NOTE: Assumes the glob array self is modifiable
          self.sort(function(a, b){
              if (a.basename < b.basename) { return -1; }
              if (a.basename > b.basename) { return  1; }
              return 0;
            });
          return self; // now sorted
        }

label: "split a file into smaller pieces"

doc: >
    Output pieces of FILE by splitting into multiple files,
    e.g. "xaa", "xab", "xac", ... where "x" is the default prefix.

    The filename suffixes are alphabetical in order 
    corresponding to file input, using a suffix letters a-z.
      
    The suffix is expanded by 2 characters before exhaustion to "z", 
    making increasingly longer filenames that are still ordered
    correctly, e.g. "yy", "yz", "zaaa", "zaab", later
    "zyzz", "zzaaaa", "zzaaab".

s:author:
  - class: s:Person
    s:name: Torbjørn Granlund
  - class: s:Person
    s:name: Richard M. Stallman

s:copyrightHolder:
  - class: s:Organization
    s:name: Free Software Foundation
    s:url: https://www.fsf.org/

s:url: https://www.gnu.org/software/coreutils/
s:mainEntityOfPage: https://www.gnu.org/software/coreutils/manual/html_node/split-invocation.html#split-invocation
s:codeRepository: https://git.savannah.gnu.org/cgit/coreutils.git
s:license: https://spdx.org/licenses/GPL-3.0-or-later
s:sdLicense: https://spdx.org/licenses/Apache-2.0 
s:sdPublisher: https://orcid.org/0000-0001-9842-9718
s:description: > 
    Given a file input, split will output its content 
    in pieces of multiple sequentially named files.

    split is part of GNU Coreutils.

s:potentialAction:
  - class: s:ActivateAction
    s:label: "example run"
    s:instrument: "../test/split/split-job.yml"

$schemas: 
  - https://schema.org/version/3.9/schema.rdf

$namespaces: 
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/
