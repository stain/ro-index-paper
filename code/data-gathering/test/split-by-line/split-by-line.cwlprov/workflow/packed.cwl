{
    "class": "ExpressionTool",
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        }
    ],
    "label": "Split by line",
    "doc": "Read file content and split by newline into array of strings.\n",
    "inputs": [
        {
            "doc": "File to split by line. Note that the file should not be larger than the CWL restrictions for loadContents (64 kiB) and should have Windows (\\r\\n) or UNIX file endings (\\n). \nLeading and trailing whitespace is ignored to avoid '' in the returned  array.\n",
            "type": "File",
            "inputBinding": {
                "loadContents": true
            },
            "id": "#main/file"
        }
    ],
    "outputs": [
        {
            "doc": "Array of lines from file, excluding newline symbol.\n",
            "type": {
                "type": "array",
                "items": "string"
            },
            "id": "#main/lines"
        }
    ],
    "expression": "${ return {\"lines\": inputs.file.contents.trim().split(/\\r?\\n/g) }; }\n",
    "id": "#main",
    "http://schema.org/creator": [
        {
            "class": "http://schema.org/Person",
            "http://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
            "http://schema.org/name": "Stian Soiland-Reyes"
        }
    ],
    "http://schema.org/codeRepository": "https://github.com/stain/ro-index-paper/",
    "http://schema.org/dateCreated": "2019-08-21",
    "http://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
    "http://schema.org/potentialAction": [
        {
            "class": "http://schema.org/ActivateAction",
            "http://schema.org/label": "example run",
            "http://schema.org/instrument": "../test/split-by-line/split-by-line-job.yml"
        }
    ],
    "hints": [
        {
            "class": "LoadListingRequirement",
            "loadListing": "deep_listing"
        },
        {
            "class": "NetworkAccess",
            "networkAccess": true
        }
    ],
    "http://commonwl.org/cwltool#original_cwlVersion": "v1.0",
    "cwlVersion": "v1.1",
    "$schemas": [
        "https://schema.org/version/3.9/schema.rdf"
    ],
    "$namespaces": {
        "s": "http://schema.org/"
    }
}