{
    "class": "CommandLineTool",
    "baseCommand": "scrapy",
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
            "dockerPull": "aciobanu/scrapy",
            "class": "DockerRequirement"
        },
        {
            "packages": [
                {
                    "specs": [
                        "https://anaconda.org/conda-forge/scrapy",
                        "https://packages.debian.org/buster/python3-scrapy",
                        "https://packages.debian.org/bullseye/python3-scrapy",
                        "https://packages.debian.org/sid/python3-scrapy"
                    ],
                    "version": [
                        "1.7.3",
                        "1.5.1"
                    ],
                    "package": "python3-scrapy"
                }
            ],
            "class": "SoftwareRequirement"
        }
    ],
    "requirements": [
        {
            "listing": [
                {
                    "class": "File",
                    "location": "file:///home/stain/src/ro-index-paper/code/data-gathering/tools/scrapy-meta.py"
                }
            ],
            "class": "InitialWorkDirRequirement"
        }
    ],
    "arguments": [
        "runspider",
        {
            "position": 100,
            "valueFrom": "scrapy-meta.py"
        }
    ],
    "inputs": [
        {
            "type": "string",
            "doc": "URL of HTML document to extract links from",
            "inputBinding": {
                "prefix": "-aurl=",
                "separate": false,
                "position": 1
            },
            "id": "#main/url"
        }
    ],
    "outputs": [
        {
            "type": "File",
            "streamable": true,
            "doc": "The link URLs found, separated by newline",
            "id": "#main/links",
            "outputBinding": {
                "glob": "links.txt"
            }
        }
    ],
    "stdout": "links.txt",
    "label": "scrapy find meta rel=alternate links",
    "doc": "Parse HTML and find meta link elements with rel=\"alternate\"\n",
    "id": "#main",
    "http://commonwl.org/cwltool#original_cwlVersion": "v1.0",
    "cwlVersion": "v1.1"
}