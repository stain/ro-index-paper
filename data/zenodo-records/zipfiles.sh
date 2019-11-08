#!/bin/sh
xzcat zenodo-records-json-2019-09-16-filtered.jsonseq.xz |  jq -r '. | select(.metadata.access_right == "open") | .metadata.resource_type.type as $rectype | . as $rec | ( .files[]?  | select(.type == "zip") ) | [$rec.id, $rec.links.self, $rec.links.doi, .checksum, .links.self, .size, .type, .key, $rectype] | @tsv' > zipfiles.tsv
grep software$ zipfiles.tsv > zipfiles-software.tsv
grep dataset$ zipfiles.tsv > zipfiles-dataset.tsv
grep -v software$ zipfiles.tsv | grep -v dataset$ > zipfiles-others.tsv
