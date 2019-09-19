{
    "class": "CommandLineTool",
    "baseCommand": "jq",
    "hints": [
        {
            "class": "LoadListingRequirement",
            "loadListing": "deep_listing"
        },
        {
            "class": "NetworkAccess",
            "networkAccess": true
        },
        {
            "dockerPull": "quay.io/biocontainers/jq:1.5--0",
            "class": "DockerRequirement"
        },
        {
            "packages": [
                {
                    "specs": [
                        "https://anaconda.org/conda-forge/jq",
                        "https://packages.debian.org/stretch/jq",
                        "https://packages.debian.org/buster/jq",
                        "https://packages.debian.org/bullseye/jq",
                        "https://packages.debian.org/sid/jq"
                    ],
                    "version": [
                        "1.5",
                        "1.6"
                    ],
                    "package": "jq"
                }
            ],
            "class": "SoftwareRequirement"
        }
    ],
    "inputs": [
        {
            "type": "string",
            "default": ".",
            "doc": "A jq filter runs on a stream of JSON data, for instance the filter .foo on { \"bar\": 1, \"foo\": [1,2,3] } will  output [1,2,3]. Filters can be chained together with |. See <https://stedolan.github.io/jq/manual/v1.5/#Basicfilters> for details.\n",
            "inputBinding": {
                "position": 2
            },
            "id": "#main/filter"
        },
        {
            "type": {
                "type": "array",
                "items": "File"
            },
            "streamable": true,
            "doc": "JSON files which will be filtered. Each file may contain multiple JSON sequences separated by whitespace  (e.g. output from another jq execution)\n",
            "inputBinding": {
                "position": 3
            },
            "id": "#main/json"
        },
        {
            "type": "boolean",
            "default": false,
            "doc": "Instead of running the filter for each JSON object in the input,  read the entire input stream into a large array and run  the filter just once.\n",
            "inputBinding": {
                "prefix": "--slurp",
                "position": 1
            },
            "id": "#main/slurp"
        }
    ],
    "outputs": [
        {
            "type": "File",
            "streamable": true,
            "doc": "The result of applying the jq filter, returned as a sequence of JSON elements, separated by whitespace.\n",
            "id": "#main/filtered",
            "outputBinding": {
                "glob": "filtered.jsonseq"
            }
        }
    ],
    "stdout": "filtered.jsonseq",
    "label": "jq: JSON processor",
    "doc": "JQ is a lightweight and flexible command-line JSON processor that consumes a stream of JSON expressions separated by whitespace,  applies the specified filter(s), and outputs result as JSON separated by whitespace.\n",
    "id": "#main",
    "http://schema.org/url": "https://stedolan.github.io/jq/",
    "http://schema.org/mainEntityOfPage": "https://stedolan.github.io/jq/manual/v1.5/",
    "http://schema.org/codeRepository": "https://github.com/stedolan/jq",
    "http://schema.org/license": "https://spdx.org/licenses/MIT",
    "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
    "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
    "http://schema.org/author": [
        {
            "class": "http://schema.org/Person",
            "http://schema.org/name": "Stephen Dolan",
            "http://schema.org/url": "http://stedolan.net/"
        }
    ],
    "http://schema.org/potentialAction": [
        {
            "class": "http://schema.org/ActivateAction",
            "http://schema.org/label": "example run",
            "http://schema.org/instrument": "../test/jq-filter/jq-filter-job.yml"
        }
    ],
    "http://commonwl.org/cwltool#original_cwlVersion": "v1.0",
    "cwlVersion": "v1.1",
    "$schemas": [
        "https://schema.org/version/3.9/schema.rdf"
    ],
    "$namespaces": {
        "iana": "https://www.iana.org/assignments/media-types/",
        "s": "http://schema.org/"
    }
}