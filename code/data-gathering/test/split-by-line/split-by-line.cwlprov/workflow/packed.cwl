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
            "doc": "File to split by line. Note that the file should not be larger than the CWL restrictions for loadContents (64 kiB) and should have Windows (\\r\\n) or UNIX file endings (\\n)\n",
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
    "expression": "${ return {\"lines\": inputs.file.contents.split(/\\r?\\n/g) }; }\n",
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