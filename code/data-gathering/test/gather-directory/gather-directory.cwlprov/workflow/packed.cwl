{
    "class": "ExpressionTool",
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        }
    ],
    "label": "Gather directory",
    "doc": "Gather array of array of Files, flattened into a single Directory. \nFiles are assumed to have unique filenames.  \nOptionally the files can be renamed to add an provided file extension.\n",
    "inputs": [
        {
            "doc": "Optional extension to add for each file, e.g. \".txt\". \nThe extension is combined with the \"nameroot\" attribute,  (usually filled in by the CWL engine), any existing file  extension is replaced.\nProvide the empty string \"\" to simply remove existing extension.\n",
            "type": [
                "null",
                "string"
            ],
            "id": "#main/extension"
        },
        {
            "type": {
                "type": "array",
                "items": {
                    "type": "array",
                    "items": "File"
                }
            },
            "id": "#main/files"
        },
        {
            "type": "string",
            "doc": "Relative name to give generated Directory, e.g. \"results\"\n",
            "id": "#main/name"
        }
    ],
    "outputs": [
        {
            "type": "Directory",
            "id": "#main/gathered"
        }
    ],
    "expression": "${\n    var listing = Array.prototype.concat.apply([], inputs.files);\n\n    if (inputs.extension != null) {\n        listing = listing.map(function rename(f) {\n            var renamed = Object.assign({}, f);\n            renamed[\"nameext\"] = inputs.extension\n            renamed[\"basename\"] = f[\"nameroot\"] + inputs.extension;\n            delete renamed[\"@id\"]; // Force CWLProv to re-register with new extension\n            return renamed;\n        });\n    }\n\n    var directory = {\n                \"class\": \"Directory\",\n                \"basename\": inputs.name,\n                \"listing\": listing\n              };\n                  \n    return { \"gathered\": directory } ;\n              \n}\n",
    "id": "#main",
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
    "cwlVersion": "v1.1"
}