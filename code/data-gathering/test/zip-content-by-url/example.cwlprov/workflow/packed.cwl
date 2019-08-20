{
    "$graph": [
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
                    "id": "#curl-get.cwl/acceptType",
                    "https://schema.org/about": "https://tools.ietf.org/html/rfc7231#section-5.3.2"
                },
                {
                    "type": "string",
                    "doc": "The URL of the resource to be downloaded.  Any HTTP redirections (302/303/307/308) will be followed.\n",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#curl-get.cwl/url"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "The downloaded file, written in streamable mode.",
                    "format": "https://www.iana.org/assignments/media-types/$(inputs.acceptType)",
                    "id": "#curl-get.cwl/downloaded"
                },
                {
                    "type": "File",
                    "streamable": true,
                    "doc": "A log of the HTTP response headers. If HTTP redirection with a  Location: header was received, an empty line separates the headers from subsequent requests.\n",
                    "outputBinding": {
                        "glob": "headers.txt"
                    },
                    "id": "#curl-get.cwl/headers"
                }
            ],
            "stdout": "downloaded",
            "label": "curl: download HTTP resource from URL",
            "doc": "curl will download a HTTP/HTTPS resource or file from a given URL, following any redirections.\n",
            "id": "#curl-get.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://keybase.io/bagder",
                    "https://schema.org/name": "Daniel Stenberg"
                }
            ],
            "https://schema.org/codeRepository": "https://github.com/curl/curl",
            "https://schema.org/url": "https://curl.haxx.se/",
            "https://schema.org/license": "https://spdx.org/licenses/curl",
            "https://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/description": "curl is a command line tool and library for transferring data with URLs.\n",
            "https://schema.org/version": "7.39.0",
            "$namespaces": {
                "iana": "https://www.iana.org/assignments/media-types/",
                "s": "https://schema.org/"
            }
        },
        {
            "class": "CommandLineTool",
            "label": "sunzip: list files from zip stream",
            "doc": "sunzip is a streaming unzip tool that bypasses or delays the  need for reading the ZIP files table of content, which is located at end of the ZIP file. \nThe sunzip -l option print the file and directory names  as they are encountered in the stream, without uncompressing any of the content.\nNote that file names from the local file headers are less reliable  than the end-of-file TOC that would otherwise be used, and  may include duplicates, deleted and encrypted files.\nThe output may be incomplete or wrong if the ZIP file is corrupt or incomplete. \n",
            "baseCommand": "sunzip",
            "arguments": [
                "-l"
            ],
            "hints": [
                {
                    "dockerPull": "stain/sunzip",
                    "class": "DockerRequirement"
                }
            ],
            "inputs": [
                {
                    "doc": "File or stream of .zip file that should be read. The file will be read in a streaming mode.\n",
                    "type": "stdin",
                    "streamable": true,
                    "format": "https://www.iana.org/assignments/media-types/application/zip",
                    "id": "#sunzip-list.cwl/zipstream"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "A list of filenames and directories encountered in the ZIP archive,  seperated by newline. Paths are relative to the root of the ZIP archive. The list is written in a streaming mode.\n",
                    "id": "#sunzip-list.cwl/filenames"
                }
            ],
            "stdout": "filenames.txt",
            "id": "#sunzip-list.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "http://dbpedia.org/resource/Mark_Adler",
                    "https://schema.org/url": "https://github.com/madler",
                    "https://schema.org/name": "Mark Adler"
                }
            ],
            "https://schema.org/contributor": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "https://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "https://schema.org/codeRepository": "https://github.com/stain/sunzip/",
            "https://schema.org/isBasedOn": "https://github.com/madler/sunzip",
            "https://schema.org/dateModified": "2019-08-13",
            "https://schema.org/license": "https://spdx.org/licenses/Zlib",
            "https://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "https://schema.org/description": "stain/sunzip is a fork of madler/sunzip, a streaming unzip utility. \nThe modifications add a -l list option to print the file and directory\nnames as they are encountered in the stream. \n\nNote that file names from the local file headers are less reliable \nthan the end-of-file TOC that would otherwise be used, and \nmay include duplicates, deleted and encrypted files.\n",
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/sunzip-list-job.yml",
                    "https://schema.org/object": "../test/test.zip",
                    "https://schema.org/result": "../test/test-sunzip-files.txt"
                }
            ]
        },
        {
            "class": "Workflow",
            "label": "list ZIP content by URL",
            "doc": "curl will download a HTTP/HTTPS resource or file from a given URL, following any redirections.\n",
            "inputs": [
                {
                    "type": "string",
                    "doc": "The URL of the ZIP archive to inspect.\n",
                    "id": "#main/url"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "streamable": true,
                    "doc": "A list of filenames and directories encountered in the ZIP archive,  seperated by newline. \n",
                    "outputSource": "#main/list/filenames",
                    "id": "#main/filenames"
                },
                {
                    "type": "File",
                    "streamable": true,
                    "doc": "A log of the HTTP response headers.\n",
                    "outputSource": "#main/fetch/headers",
                    "id": "#main/headers"
                }
            ],
            "steps": [
                {
                    "run": "#curl-get.cwl",
                    "in": [
                        {
                            "default": "application/zip",
                            "id": "#main/fetch/acceptType"
                        },
                        {
                            "source": "#main/url",
                            "id": "#main/fetch/url"
                        }
                    ],
                    "out": [
                        "#main/fetch/downloaded",
                        "#main/fetch/headers"
                    ],
                    "id": "#main/fetch"
                },
                {
                    "in": [
                        {
                            "source": "#main/fetch/downloaded",
                            "id": "#main/list/zipstream"
                        }
                    ],
                    "out": [
                        "#main/list/filenames"
                    ],
                    "run": "#sunzip-list.cwl",
                    "id": "#main/list"
                }
            ],
            "id": "#main",
            "https://schema.org/creator": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "https://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "https://schema.org/codeRepository": "https://github.com/stain/ro-index-paper/",
            "https://schema.org/dateCreated": "2019-08-20",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/zip=content-by-url-job.yml"
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
            "http://commonwl.org/cwltool#original_cwlVersion": "v1.0"
        }
    ],
    "cwlVersion": "v1.1",
    "$schemas": [
        "https://schema.org/version/3.9/schema.rdf"
    ]
}