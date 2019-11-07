# Zenodo metadata JSON records as of 2019-09-16

* Stian Soiland-Reyes <https://orcid.org/0000-0001-9842-9718>
* Paul Groth <https://orcid.org/0000-0003-0183-6910>

This preliminary dataset contains the `application/vnd.zenodo.v1+json`
JSON records of [Zenodo](http://zenodo.org/) deposits retrieved on 2019-09-16.

## Files

* `zenodo-records-json-2019-09-16.tar.xz` Zenodo JSON records  
  XZ-compressed tar archive of individual JSON records as retrieved from Zenodo. Filenames reflects record, e.g. `1310621.json` was retrieved from <https://zenodo.org/api/records/1310621> using content-negotiation for `application/vnd.zenodo.v1+json`
* `zenodo-records-json-2019-09-16-filtered.jsonseq.xz` Concatinated Zenodo JSON records  
  XZ-compressed [RFC7464](https://tools.ietf.org/html/rfc7464) JSON Sequence stream, readable by [jq](https://stedolan.github.io/jq/manual/v1.5/). Concatination of Zenodo JSON records. Order not significant.
* `zenodo-records.sh` Retrieve Zenodo JSON records   
   A retrospectively created Bash shell script that shows the commands used to retrieve JSON files and concationate to jsonseq.
* `ro-crate-metadata.jsonld` [RO-Crate 0.2](https://w3id.org/ro/crate/0.2) structured metadata
* `ro-crate-preview.html` Browser rendering of RO-Crate structured metadata
* `README.md` This dataset description

## License

This dataset is provided under the license [Apache License, version 2.0](https://www.apache.org/licenses/LICENSE-2.0):

Copyright 2019 The University of Manchester

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### CC0 for Zenodo metadata

The [Zenodo metadata](https://about.zenodo.org/terms/) in `zenodo-records-json-2019-09-16.tar.xz` is reused 
under the terms of [https://creativecommons.org/publicdomain/zero/1.0/](https://creativecommons.org/publicdomain/zero/1.0/)

## Reproducibility

To retrieve the Zenodo JSON it was deemed necessary to use 
the [undocumented](https://github.com/zenodo/zenodo/issues/1426#issuecomment-369171411) parts of [Zenodo API](https://developers.zenodo.org/).

From the [Zenodo source code](https://github.com/zenodo/zenodo/blob/deploy-qa-2019-09-19-0735/zenodo/config.py#L814)
it was identified that the REST template `https://zenodo.org/api/records/{pid_value}` could be used with `pid_value` 
as the numeric part from the OAI-PMH identifier, e.g. for `oai:zenodo.org:1310621` the Zenodo JSON can be retrieved
at <https://zenodo.org/api/records/1310621>.

The JSON API supports content negotiation, the content-types supported as of 2019-09-20 include:

* `application/vnd.zenodo.v1+json` giving the Zenodo record in Zenodo's [internal JSON schema](https://github.com/zenodo/zenodo/blob/deploy-qa-2019-09-19-0735/zenodo/modules/records/serializers/schemas/json.py#L267) (v1)
* `application/ld+json` giving [JSON-LD](https://www.w3.org/TR/2014/REC-json-ld-20140116/) Linked Data using the <http://schema.org/> vocabulary
* `application/x-datacite-v41+xml` giving [DataCite v4 XML](https://doi.org/10.5438/0012)
* `application/marcxml+xml` giving [MARC](http://www.loc.gov/standards/marcxml/) 21 XML

Using these (currently) undocumented parts of the Zenodo API thus avoids
the need for HTML scraping while also giving individual complete records
that are suitable to redistribute as records in a filtered dataset.

This preliminary exploration will be adapted into the reproducible CWL
workflow, for now included as a Bash script `zenodo-records.sh`

Execution time was about 3 days from a server at the University of Manchester
network on a single 1 GBps network link.  The script does:

* Retrieve each of the first 3.5 million Zenodo records  
  as Zenodo JSON by iterating over possible numeric IDs
  (the maximum ID `3450000` was estimated from ["Recent uploads"](https://zenodo.org/))
* Filter list to exclude records that are not found, 
  moved or deleted. The presence of the key `conceptrecid` is used as marker.
* Use [jq](https://stedolan.github.io/jq/manual/v1.5/) to ensure
  the JSON is on a single line
* Join the JSON files using the ASCII Record Separator (RS, `0x1e`)
  to make a `application/json-seq` [JSON text sequence](https://doi.org/10.17487/RFC7464) stream
* Save the JSON stream as a single compressed file using `xz`
