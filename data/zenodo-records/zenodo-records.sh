#!/bin/bash

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

## Naively Download first 3450000 records 
# TODO: Rebuild as CWL workflow

# Requirements: 
# - curl 7.67.0 or later
# - jq
# - xz
# - sed
# - grep

now=$(date -I)

mkdir data
cd data

# TODO: Run from OAI-PMH ids to avoid 404
# TODO: Respect Retry and X-Ratelimit headers (this only overrun once)
# .. see https://github.com/curl/curl/pull/4465 and use
# .. curl 7.67.0 or later
curl --retry 10 -H "Accept: application/vnd.zenodo.v1+json" \
  'https://zenodo.org/api/records/[1-3450000]' -o "record_#1.json"
# WARNING: Abovetakes about 3 days
# TODO: Parallelize 2-3 threads?

tar cJfv ../zenodo-records-json-$now.tar.xz .

# Note: many of these are 404 or redirects from version-less 
# record to latest version. We'll need to remove the non-records:

# Ignore "404" etc. by flattening each JSON file to oneliner,
# then selecting only JSON files with "conceptrecid" field.
# Concatinate to rfc7464 JSON Seq using record separator
# Compress with xz
find . -maxdepth 1 -type f -name 'record*json' | \
  xargs -n32 cat | \
  jq -c .  | \
  grep conceptrecid | \
  sed `echo -e "s/^/\x1e/g"` | \
  xz -4 -T5 >  ../zenodo-records-json-$now-filtered.jsonseq.xz 

cd ../
