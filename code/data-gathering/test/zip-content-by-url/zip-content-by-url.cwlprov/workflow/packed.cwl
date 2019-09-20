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
                    "http://schema.org/about": "https://tools.ietf.org/html/rfc7231#section-5.3.2"
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
            "$namespaces": {
                "iana": "https://www.iana.org/assignments/media-types/",
                "s": "https://schema.org/"
            }
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "jar",
            "arguments": [
                "t"
            ],
            "hints": [
                {
                    "dockerPull": "openjdk:11.0-slim",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk",
                                "https://packages.debian.org/stretch/openjdk-8-jdk-headless",
                                "https://packages.debian.org/buster/openjdk-11-jdk-headless",
                                "https://packages.debian.org/bullseye/openjdk-11-jdk-headless",
                                "https://packages.debian.org/sid/openjdk-11-jdk-headless"
                            ],
                            "version": [
                                "11.0.1",
                                "11.0.4",
                                "10.0.1",
                                "8u162-b12-1",
                                "8u222-b10-1ubuntu1",
                                "8u222-b10-1"
                            ],
                            "package": "openjdk"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "label": "jar: list zip file content",
            "doc": "List content of a ZIP file using OpenJDK jar, which can process the ZIP file in a streaming fashion.\n",
            "inputs": [
                {
                    "doc": "File or stream of .zip file that should be read. The file will be read in a streaming mode.\n",
                    "type": "stdin",
                    "streamable": true,
                    "id": "#jar-list.cwl/zipstream"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "A list of filenames and directories encountered in the ZIP archive,  seperated by newline. Paths are relative to the root of the ZIP archive. The list is written in a streaming mode.\n",
                    "id": "#jar-list.cwl/filenames"
                }
            ],
            "stdout": "filenames.txt",
            "id": "#jar-list.cwl",
            "http://schema.org/codeRepository": "https://hg.openjdk.java.net/jdk/jdk11/file/1ddf9a99e4ad/src/jdk.jartool",
            "http://schema.org/url": "https://openjdk.java.net/",
            "http://schema.org/license": "https://spdx.org/licenses/GPL-2.0-with-classpath-exception",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0"
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
                    "run": "#jar-list.cwl",
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
                    "https://schema.org/instrument": "../test/zip=content-by-url/zip=content-by-url-job.yml",
                    "https://schema.org/object": "https://github.com/stain/ro-index-paper/archive/38f2a711f9f115e92cea930398019c147e56ac5a.zip",
                    "https://schema.org/result": "../test/zip=content-by-url/filenames.txt"
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