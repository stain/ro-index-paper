{
    "class": "CommandLineTool",
    "baseCommand": "curl",
    "arguments": [
        "--silent",
        "--show-error",
        "--fail",
        "--location",
        "--dump-header",
        "headers.txt"
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
            "type": "string",
            "doc": "The URL of the resource to be downloaded.  Any HTTP redirections (302/303/307/308) will be followed.\n",
            "inputBinding": {
                "position": 1
            },
            "id": "#main/url"
        }
    ],
    "outputs": [
        {
            "type": "File",
            "streamable": true,
            "doc": "The downloaded file, written in streamable mode.",
            "format": "https://www.iana.org/assignments/media-types/$(inputs.acceptType)",
            "id": "#main/downloaded",
            "outputBinding": {
                "glob": "downloaded"
            }
        },
        {
            "type": "File",
            "streamable": true,
            "doc": "A log of the HTTP response headers. If HTTP redirection with a  Location: header was received, an empty line separates the headers from subsequent requests.\n",
            "outputBinding": {
                "glob": "headers.txt"
            },
            "id": "#main/headers"
        }
    ],
    "stdout": "downloaded",
    "label": "curl: download HTTP resource from URL",
    "doc": "curl will download a HTTP/HTTPS resource or file from a given URL, following any redirections.\n",
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
    "http://schema.org/version": "7.39.0",
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