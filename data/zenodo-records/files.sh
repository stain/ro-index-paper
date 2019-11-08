#!/bin/sh
xzcat zenodo-records-json-2019-09-16-filtered.jsonseq.xz |  jq -r '. | select(.metadata.access_right == "open") | .metadata.resource_type.type as $rectype | . as $rec | ( .files[]?  ) | [$rec.id, $rec.links.self, $rec.links.doi, .checksum, .links.self, .size, .type, .key, $rectype] | @tsv' | gz > files.tsv.gz
zcat files.tsv.gz  | awk -e '{print $7}' | sort | uniq -c | grep -v "^      "  | sort -h > files-extensions.txt

