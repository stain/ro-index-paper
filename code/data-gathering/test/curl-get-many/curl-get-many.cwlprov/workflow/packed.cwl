{
    "class": "CommandLineTool",
    "baseCommand": "curl",
    "arguments": [
        "--silent",
        "--show-error",
        "--retry",
        "10",
        "--location",
        "--remote-name-all",
        "--dump-header",
        "-"
    ],
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
            "dockerPull": "appropriate/curl:3.1",
            "class": "DockerRequirement"
        },
        {
            "packages": [
                {
                    "specs": [
                        "https://anaconda.org/conda-forge/curl",
                        "https://packages.debian.org/jessie/curl",
                        "https://packages.debian.org/stretch/curl",
                        "https://packages.debian.org/buster/curl",
                        "https://packages.debian.org/bullseye/curl",
                        "https://packages.debian.org/sid/curl"
                    ],
                    "version": [
                        "7.39.0",
                        "7.65.3",
                        "7.38.0",
                        "7.52.1",
                        "7.64.0",
                        "7.65.3"
                    ],
                    "package": "curl"
                }
            ],
            "class": "SoftwareRequirement"
        }
    ],
    "inputs": [
        {
            "type": "string",
            "doc": "Optional IANA media-type to request using Accept: header,  for example \"application/json\" or \"text/html\". The default \"*/*\" requests any content type.\n",
            "default": "*/*",
            "inputBinding": {
                "prefix": "--header",
                "valueFrom": "Accept: $(inputs.acceptType)"
            },
            "id": "#main/acceptType",
            "http://schema.org/about": "https://tools.ietf.org/html/rfc7231#section-5.3.2"
        },
        {
            "type": {
                "type": "array",
                "items": "string"
            },
            "doc": "The URLs of the resources to be downloaded.  Any HTTP redirections (302/303/307/308) will be followed. The file names for saving are extracted from the given URLs, e.g. [ \"http://example.com/foo.txt\", \"http://other.example.net/nested/bar.txt\"] will be downloaded as files named \"foo.txt\" \"bar.txt\"\n",
            "inputBinding": {
                "position": 100
            },
            "id": "#main/urls"
        }
    ],
    "outputs": [
        {
            "type": {
                "type": "array",
                "items": "File"
            },
            "doc": "The downloaded files. Note that the order may not correspond to the order of the input list \"urls\". This list may be shorter than \"urls\" if there were  redirections or errors in downloading (see the output \"headers\"),  or because multiple URLs had the same file path ending  (last URL overwrites).\n",
            "format": "https://www.iana.org/assignments/media-types/$(inputs.acceptType)",
            "outputBinding": {
                "glob": "*"
            },
            "id": "#main/downloaded"
        },
        {
            "type": "File",
            "streamable": true,
            "doc": "A log of the HTTP response headers. If HTTP redirection with a  \"Location:\" header was received, an empty line separates the headers from subsequent requests. An empty line thereafter separates the headers from subsequent URL requests, repeated as above.\n",
            "id": "#main/headers",
            "outputBinding": {
                "glob": ".headers.txt"
            }
        }
    ],
    "stdout": ".headers.txt",
    "label": "curl: download HTTP files from URLs",
    "doc": "curl will download the HTTP/HTTPS files from the given URLs, following any redirections. A list of files is returned, using filenames reflecting the URI path.\n",
    "id": "#main",
    "http://schema.org/author": [
        {
            "class": "http://schema.org/Person",
            "http://schema.org/identifier": "https://keybase.io/bagder",
            "http://schema.org/name": "Daniel Stenberg"
        }
    ],
    "http://schema.org/codeRepository": "https://github.com/curl/curl",
    "http://schema.org/url": "https://curl.haxx.se/",
    "http://schema.org/license": "https://spdx.org/licenses/curl",
    "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
    "http://schema.org/description": "curl is a command line tool and library for transferring data with URLs.\n",
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