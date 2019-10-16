#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: ExpressionTool

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

requirements:
  - class: InlineJavascriptRequirement 

label: Gather directory

doc: > 
  Gather array of array of Files, flattened into a single Directory. 
  
  Files are assumed to have unique filenames.  
  
  Optionally the files can be renamed to add an
  provided file extension.

inputs:
  name:
    type: string
    doc: > 
     Relative name to give generated Directory, e.g. "results"
  files:
    type: 
      type: array
      items: 
        type: array
        items: File
  extension:
    doc: >
      Optional extension to add for each file, e.g. ".txt". 
      
      The extension is combined with the "nameroot" attribute, 
      (usually filled in by the CWL engine), any existing file 
      extension is replaced.
      
      Provide the empty string "" to simply remove existing extension.
    type: string?

outputs:
  gathered:
    type: Directory

expression: |
  ${
      var listing = Array.prototype.concat.apply([], inputs.files);

      if (inputs.extension != null) {
          listing = listing.map(function rename(f) {
              var renamed = Object.assign({}, f);
              renamed["nameext"] = inputs.extension
              renamed["basename"] = f["nameroot"] + inputs.extension;
              delete renamed["@id"]; // Force CWLProv to re-register with new extension
              return renamed;
          });
      }

      var directory = {
                  "class": "Directory",
                  "basename": inputs.name,
                  "listing": listing
                };
                    
      return { "gathered": directory } ;
                
  }
