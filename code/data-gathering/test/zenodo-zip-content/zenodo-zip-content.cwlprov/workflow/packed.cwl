{
    "cwlVersion": "v1.1",
    "$graph": [
        {
            "class": "CommandLineTool",
            "outputs": [
                {
                    "streamable": true,
                    "type": "stdout",
                    "doc": "The concatinated file, written in streamable mode.",
                    "id": "#cat.cwl/concatinated"
                }
            ],
            "id": "#cat.cwl",
            "stdout": "concatinated",
            "$namespaces": {
                "s": "https://schema.org/",
                "iana": "https://www.iana.org/assignments/media-types/"
            },
            "arguments": [
                "--squeeze-blank"
            ],
            "baseCommand": "cat",
            "doc": "concatinate files to a single streamable file\n",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "debian:9"
                },
                {
                    "class": "SoftwareRequirement",
                    "packages": [
                        {
                            "package": "coreutils",
                            "version": [
                                "7.39.0",
                                "7.65.3",
                                "7.38.0",
                                "7.52.1",
                                "7.64.0",
                                "7.65.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/coreutils",
                                "https://packages.debian.org/jessie/coreutils",
                                "https://packages.debian.org/stretch/coreutils",
                                "https://packages.debian.org/buster/coreutils",
                                "https://packages.debian.org/bullseye/coreutils",
                                "https://packages.debian.org/sid/coreutils"
                            ]
                        }
                    ]
                }
            ],
            "label": "cat: concatinate files",
            "inputs": [
                {
                    "streamable": true,
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "A list of files to be concatinated\n",
                    "id": "#cat.cwl/files",
                    "inputBinding": {
                        "position": 1
                    }
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "curl: download HTTP resource from URL",
            "stdout": "downloaded",
            "id": "#curl-get.cwl",
            "arguments": [
                "--silent",
                "--show-error",
                "--fail",
                "--location",
                "--dump-header",
                "headers.txt"
            ],
            "inputs": [
                {
                    "type": "string",
                    "id": "#curl-get.cwl/acceptType",
                    "inputBinding": {
                        "valueFrom": "Accept: $(inputs.acceptType)",
                        "prefix": "--header"
                    },
                    "doc": "Optional IANA media-type to request using Accept: header,  for example \"application/json\" or \"text/html\". The default \"*/*\" requests any content type.\n",
                    "http://schema.org/about": "https://tools.ietf.org/html/rfc7231#section-5.3.2",
                    "default": "*/*"
                },
                {
                    "type": "string",
                    "doc": "The URL of the resource to be downloaded.  Any HTTP redirections (302/303/307/308) will be followed.\n",
                    "id": "#curl-get.cwl/url",
                    "inputBinding": {
                        "position": 1
                    }
                }
            ],
            "http://schema.org/description": "curl is a command line tool and library for transferring data with URLs.\n",
            "outputs": [
                {
                    "streamable": true,
                    "type": "stdout",
                    "doc": "The downloaded file, written in streamable mode.",
                    "format": "https://www.iana.org/assignments/media-types/$(inputs.acceptType)",
                    "id": "#curl-get.cwl/downloaded"
                },
                {
                    "streamable": true,
                    "type": "File",
                    "doc": "A log of the HTTP response headers. If HTTP redirection with a  Location: header was received, an empty line separates the headers from subsequent requests.\n",
                    "outputBinding": {
                        "glob": "headers.txt"
                    },
                    "id": "#curl-get.cwl/headers"
                }
            ],
            "http://schema.org/url": "https://curl.haxx.se/",
            "http://schema.org/license": "https://spdx.org/licenses/curl",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "baseCommand": "curl",
            "http://schema.org/version": "7.39.0",
            "doc": "curl will download a HTTP/HTTPS resource or file from a given URL, following any redirections.\n",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://keybase.io/bagder",
                    "http://schema.org/name": "Daniel Stenberg"
                }
            ],
            "http://schema.org/codeRepository": "https://github.com/curl/curl",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "appropriate/curl:3.1"
                },
                {
                    "class": "SoftwareRequirement",
                    "packages": [
                        {
                            "package": "curl",
                            "version": [
                                "7.39.0",
                                "7.65.3",
                                "7.38.0",
                                "7.52.1",
                                "7.64.0",
                                "7.65.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/curl",
                                "https://packages.debian.org/jessie/curl",
                                "https://packages.debian.org/stretch/curl",
                                "https://packages.debian.org/buster/curl",
                                "https://packages.debian.org/bullseye/curl",
                                "https://packages.debian.org/sid/curl"
                            ]
                        }
                    ]
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "oai_pmh ListIdentifiers",
            "id": "#oai-pmh.cwl",
            "stdout": "identifiers",
            "http://schema.org/publisher": [
                {
                    "class": "http://schema.org/Organization",
                    "http://schema.org/url": "https://librecat.org/",
                    "http://schema.org/name": "LibreCat"
                }
            ],
            "arguments": [
                "--request",
                "ListIdentifiers",
                {
                    "position": 100,
                    "shellQuote": false,
                    "valueFrom": "| grep identifier:"
                },
                {
                    "position": 200,
                    "shellQuote": false,
                    "valueFrom": "| sed 's/^.*identifier: //g'"
                }
            ],
            "requirements": [
                {
                    "class": "DockerRequirement",
                    "dockerImageId": "stain/perl-oai-lib",
                    "dockerFile": "FROM debian:9\nRUN apt-get update && apt-get -y install libhttp-oai-perl\n# Quick-and-dirty patch for https://github.com/LibreCat/perl-oai-lib/pull/5\nRUN sed -i \"/identifier=s/ a 'set=s',\" /usr/bin/oai_pmh\n"
                },
                {
                    "class": "ShellCommandRequirement"
                }
            ],
            "http://schema.org/contributor": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/url": "https://github.com/phochste",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8390-6171",
                    "http://schema.org/name": "Patrick Hochstenbach"
                }
            ],
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "inputs": [
                {
                    "type": "string",
                    "doc": "The OAI-PMH base URL, e.g. \"https://zenodo.org/oai2d\"\n",
                    "id": "#oai-pmh.cwl/baseurl",
                    "inputBinding": {
                        "position": 1
                    }
                },
                {
                    "type": "string",
                    "id": "#oai-pmh.cwl/metadataPrefix",
                    "default": "oai_dc",
                    "inputBinding": {
                        "prefix": "--metadataPrefix"
                    }
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "id": "#oai-pmh.cwl/set",
                    "inputBinding": {
                        "prefix": "--set"
                    }
                }
            ],
            "http://schema.org/description": "OAI-PERL are a set of Perl modules that provide an API to the Open Archives\nInitiative Protocol for Metadata Harvesting (OAI-PMH).\n\nOAI-PMH is a XML-over-HTTP protocol for transferring metadata between a\nrepository (the HTTP server) and service provider (the HTTP client).\n",
            "outputs": [
                {
                    "streamable": true,
                    "type": "stdout",
                    "doc": "The OAI-PMH identifiers",
                    "id": "#oai-pmh.cwl/identifiers"
                }
            ],
            "http://schema.org/license": "https://spdx.org/licenses/BSD-3-Clause",
            "http://schema.org/isBasedOn": "https://github.com/timbrody/perl-oai-lib",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/oai-pmh-job.yml"
                }
            ],
            "baseCommand": "oai_pmh",
            "doc": "List repository identifiers using OAI-PMH protocol\n",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/url": "https://github.com/timbrody",
                    "http://schema.org/name": "Tim Brody"
                }
            ],
            "http://schema.org/codeRepository": "https://github.com/LibreCat/perl-oai-lib/"
        },
        {
            "class": "CommandLineTool",
            "requirements": [
                {
                    "listing": [
                        {
                            "class": "File",
                            "location": "file:///home/stain/ro-index-paper/code/data-gathering/tools/scrapy-meta.py"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                }
            ],
            "outputs": [
                {
                    "streamable": true,
                    "type": "stdout",
                    "doc": "The link URLs found, separated by newline",
                    "id": "#scrapy-meta.cwl/links"
                }
            ],
            "stdout": "links.txt",
            "id": "#scrapy-meta.cwl",
            "arguments": [
                "runspider",
                {
                    "position": 100,
                    "valueFrom": "scrapy-meta.py"
                }
            ],
            "baseCommand": "scrapy",
            "doc": "Parse HTML and find meta link elements with rel=\"alternate\"\n",
            "inputs": [
                {
                    "type": "string",
                    "doc": "URL of HTML document to extract links from",
                    "id": "#scrapy-meta.cwl/url",
                    "inputBinding": {
                        "position": 1,
                        "separate": false,
                        "prefix": "-aurl="
                    }
                }
            ],
            "label": "scrapy find meta rel=alternate links",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "aciobanu/scrapy"
                },
                {
                    "class": "SoftwareRequirement",
                    "packages": [
                        {
                            "package": "python3-scrapy",
                            "version": [
                                "1.7.3",
                                "1.5.1"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/scrapy",
                                "https://packages.debian.org/buster/python3-scrapy",
                                "https://packages.debian.org/bullseye/python3-scrapy",
                                "https://packages.debian.org/sid/python3-scrapy"
                            ]
                        }
                    ]
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "sed search-replace",
            "stdout": "modified.txt",
            "id": "#sed.cwl",
            "arguments": [
                "--unbuffered",
                "--regexp-extended"
            ],
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "inputs": [
                {
                    "type": "string",
                    "doc": "The regular expression to be used for search-replace, \nin the form of a sed \"s/from/to/\" command, e.g. \n\"s/^/_/\" will insert an underscore at beginning of each line, \nwhile \"s/http/https/g\" will replace every \"http\" with \"https\".\n\nThis CWL wrapper enables the extended (ERE) regular expression\nand operates in streamable mode.\n\nSee also \n<https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html> and \n<https://www.gnu.org/software/sed/manual/html_node/sed-regular-expressions.html>\n",
                    "id": "#sed.cwl/command",
                    "inputBinding": {
                        "position": 1
                    }
                },
                {
                    "streamable": true,
                    "type": "File",
                    "doc": "The original file or byte stream which content is to be modified\n",
                    "id": "#sed.cwl/original",
                    "inputBinding": {
                        "position": 2
                    }
                }
            ],
            "http://schema.org/description": "sed (stream editor) is a non-interactive command-line text editor. \nsed is commonly used to filter text, i.e., it takes text input, performs  some operation (or set of operations) on it, and outputs the modified text.  sed is typically used for extracting part of a file using pattern matching or  substituting multiple occurrences of a string within a file. \n",
            "outputs": [
                {
                    "streamable": true,
                    "type": "stdout",
                    "doc": "The modified text file",
                    "id": "#sed.cwl/modified"
                }
            ],
            "http://schema.org/mainEntityOfPage": "https://www.gnu.org/software/sed/manual/",
            "http://schema.org/url": "https://www.gnu.org/software/sed/",
            "http://schema.org/license": "https://spdx.org/licenses/GPL-3.0-or-later",
            "http://schema.org/copyrightHolder": [
                {
                    "class": "http://schema.org/Organization",
                    "http://schema.org/url": "https://www.fsf.org/",
                    "http://schema.org/name": "Free Software Foundation"
                }
            ],
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/sed-job.yml"
                }
            ],
            "baseCommand": "sed",
            "doc": "Search-replace a stream using regular expressions and other SED commands.\n",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Jay Fenlason"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Tom Lord"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Ken Pizzini"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Paolo Bonzini"
                }
            ],
            "http://schema.org/codeRepository": "https://github.com/LibreCat/perl-oai-lib/",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "debian:9"
                },
                {
                    "class": "SoftwareRequirement",
                    "packages": [
                        {
                            "package": "sed",
                            "version": [
                                "4.2.2",
                                "4.4",
                                "4.7"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/sed",
                                "https://packages.debian.org/jessie/sed",
                                "https://packages.debian.org/stretch/sed",
                                "https://packages.debian.org/buster/sed",
                                "https://packages.debian.org/bullseye/sed",
                                "https://packages.debian.org/sid/sed"
                            ]
                        }
                    ]
                }
            ]
        },
        {
            "class": "ExpressionTool",
            "label": "Split by line",
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "doc": "Array of lines from file, excluding newline symbol.\n",
                    "id": "#split-by-line.cwl/lines"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "expression": "${ return {\"lines\": inputs.file.contents.split(/\\r?\\n/g) }; }\n",
            "http://schema.org/dateCreated": "2019-08-21",
            "http://schema.org/creator": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "http://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "id": "#split-by-line.cwl",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/split-by-line/split-by-line-job.yml"
                }
            ],
            "doc": "Read file content and split by newline into array of strings.\n",
            "inputs": [
                {
                    "type": "File",
                    "doc": "File to split by line. Note that the file should not be larger than the CWL restrictions for loadContents (64 kiB) and should have Windows (\\r\\n) or UNIX file endings (\\n)\n",
                    "id": "#split-by-line.cwl/file",
                    "inputBinding": {
                        "loadContents": true
                    }
                }
            ],
            "http://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/codeRepository": "https://github.com/stain/ro-index-paper/"
        },
        {
            "class": "CommandLineTool",
            "label": "sunzip: list files from zip stream",
            "id": "#sunzip-list.cwl",
            "stdout": "filenames.txt",
            "arguments": [
                "-t",
                "-q"
            ],
            "http://schema.org/contributor": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "http://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "inputs": [
                {
                    "streamable": true,
                    "type": "stdin",
                    "doc": "File or stream of .zip file that should be read. The file will be read in a streaming mode.\n",
                    "format": "https://www.iana.org/assignments/media-types/application/zip",
                    "id": "#sunzip-list.cwl/zipstream"
                }
            ],
            "http://schema.org/description": "stain/sunzip is a fork of madler/sunzip, a streaming unzip utility. \nThe modifications add a -l list option to print the file and directory\nnames as they are encountered in the stream. \n\nNote that file names from the local file headers are less reliable \nthan the end-of-file TOC that would otherwise be used, and \nmay include duplicates, deleted and encrypted files.\n",
            "outputs": [
                {
                    "streamable": true,
                    "type": "stdout",
                    "doc": "A list of filenames and directories encountered in the ZIP archive,  seperated by newline. Paths are relative to the root of the ZIP archive. The list is written in a streaming mode.\n",
                    "id": "#sunzip-list.cwl/filenames"
                }
            ],
            "http://schema.org/dateModified": "2019-08-13",
            "http://schema.org/license": "https://spdx.org/licenses/Zlib",
            "http://schema.org/isBasedOn": "https://github.com/madler/sunzip",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/result": "../test/sunzip-list/test-sunzip-files.txt",
                    "http://schema.org/label": "example run",
                    "http://schema.org/object": "../test/sunzip-list/test.zip",
                    "http://schema.org/instrument": "../test/sunzip-list/sunzip-list-job.yml"
                }
            ],
            "baseCommand": "sunzip",
            "doc": "sunzip is a streaming unzip tool that bypasses or delays the  need for reading the ZIP files table of content, which is located at end of the ZIP file. \nThe sunzip -l option print the file and directory names  as they are encountered in the stream, without uncompressing any of the content.\nNote that file names from the local file headers are less reliable  than the end-of-file TOC that would otherwise be used, and  may include duplicates, deleted and encrypted files.\nThe output may be incomplete or wrong if the ZIP file is corrupt or incomplete. \n",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/url": "https://github.com/madler",
                    "http://schema.org/identifier": "http://dbpedia.org/resource/Mark_Adler",
                    "http://schema.org/name": "Mark Adler"
                }
            ],
            "http://schema.org/codeRepository": "https://github.com/stain/sunzip/",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "stain/sunzip"
                }
            ]
        },
        {
            "class": "Workflow",
            "label": "find downloadable files in zenodo community",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "outputs": [
                {
                    "streamable": true,
                    "type": "File",
                    "doc": "A list of downloadable URLs across the community\n",
                    "outputSource": "#zenodo-community-links.cwl/flatten/concatinated",
                    "id": "#zenodo-community-links.cwl/urls"
                }
            ],
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                }
            ],
            "https://schema.org/codeRepository": "https://github.com/stain/ro-index-paper/",
            "https://schema.org/creator": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "https://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "steps": [
                {
                    "id": "#zenodo-community-links.cwl/fetch-meta",
                    "out": [
                        "#zenodo-community-links.cwl/fetch-meta/links"
                    ],
                    "in": [
                        {
                            "id": "#zenodo-community-links.cwl/fetch-meta/url",
                            "source": "#zenodo-community-links.cwl/split-ids-by-line/lines"
                        }
                    ],
                    "run": "#scrapy-meta.cwl",
                    "scatter": [
                        "#zenodo-community-links.cwl/fetch-meta/url"
                    ]
                },
                {
                    "id": "#zenodo-community-links.cwl/flatten",
                    "in": [
                        {
                            "id": "#zenodo-community-links.cwl/flatten/files",
                            "source": "#zenodo-community-links.cwl/fetch-meta/links"
                        }
                    ],
                    "run": "#cat.cwl",
                    "out": [
                        "#zenodo-community-links.cwl/flatten/concatinated"
                    ]
                },
                {
                    "id": "#zenodo-community-links.cwl/list-ids",
                    "in": [
                        {
                            "id": "#zenodo-community-links.cwl/list-ids/baseurl",
                            "valueFrom": "https://zenodo.org/oai2d"
                        },
                        {
                            "id": "#zenodo-community-links.cwl/list-ids/set",
                            "source": "#zenodo-community-links.cwl/community",
                            "valueFrom": "user-$(self)"
                        }
                    ],
                    "run": "#oai-pmh.cwl",
                    "out": [
                        "#zenodo-community-links.cwl/list-ids/identifiers"
                    ]
                },
                {
                    "id": "#zenodo-community-links.cwl/make-uri",
                    "in": [
                        {
                            "id": "#zenodo-community-links.cwl/make-uri/command",
                            "valueFrom": "s,oai:zenodo.org:,https://zenodo.org/record/,"
                        },
                        {
                            "id": "#zenodo-community-links.cwl/make-uri/original",
                            "source": "#zenodo-community-links.cwl/list-ids/identifiers"
                        }
                    ],
                    "run": "#sed.cwl",
                    "out": [
                        "#zenodo-community-links.cwl/make-uri/modified"
                    ]
                },
                {
                    "id": "#zenodo-community-links.cwl/split-ids-by-line",
                    "in": [
                        {
                            "id": "#zenodo-community-links.cwl/split-ids-by-line/file",
                            "source": "#zenodo-community-links.cwl/make-uri/modified"
                        }
                    ],
                    "out": [
                        "#zenodo-community-links.cwl/split-ids-by-line/lines"
                    ],
                    "run": "#split-by-line.cwl"
                }
            ],
            "id": "#zenodo-community-links.cwl",
            "https://schema.org/dateCreated": "2019-08-21",
            "doc": "For a given Zenodo community, retrieve a list of all its downloadable files\n",
            "inputs": [
                {
                    "type": "string",
                    "doc": "The short-name of the Zenodo community, e.g. \"ro\" for <https://zenodo.org/communities/ro>\n",
                    "default": "ro",
                    "id": "#zenodo-community-links.cwl/community"
                }
            ],
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/zip=zenodo-to-rdfa-job.yml"
                }
            ]
        },
        {
            "class": "Workflow",
            "label": "List ZIP content for zenodo community",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "outputs": [
                {
                    "type": "File",
                    "doc": "Filenames found across ZIP files\n",
                    "outputSource": "#main/flatten/concatinated",
                    "id": "#main/zip-content"
                }
            ],
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "https://schema.org/codeRepository": "https://github.com/stain/ro-index-paper/",
            "https://schema.org/creator": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "https://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "steps": [
                {
                    "label": "Filter *.zip",
                    "id": "#main/filter-zip-extension",
                    "in": [
                        {
                            "id": "#main/filter-zip-extension/list",
                            "source": "#main/split-links/lines"
                        }
                    ],
                    "doc": "Select only those downloadable files which URL indicate a known ZIP file extension (*.zip for now)\n",
                    "out": [
                        "#main/filter-zip-extension/filtered"
                    ],
                    "run": {
                        "class": "ExpressionTool",
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "string"
                                },
                                "id": "#main/filter-zip-extension/44906e6a-5224-4e95-8911-42c06a8e0a73/filtered"
                            }
                        ],
                        "id": "#main/filter-zip-extension/44906e6a-5224-4e95-8911-42c06a8e0a73",
                        "expression": "${return { \"filtered\": \n        inputs.list.filter(function (url) { return url.endsWith(\".zip\") })\n    }\n}\n",
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "string"
                                },
                                "id": "#main/filter-zip-extension/44906e6a-5224-4e95-8911-42c06a8e0a73/list"
                            }
                        ]
                    }
                },
                {
                    "id": "#main/flatten",
                    "in": [
                        {
                            "id": "#main/flatten/files",
                            "source": "#main/zip-content-by-url/zip-content"
                        }
                    ],
                    "run": "#cat.cwl",
                    "out": [
                        "#main/flatten/concatinated"
                    ]
                },
                {
                    "id": "#main/split-links",
                    "in": [
                        {
                            "id": "#main/split-links/file",
                            "source": "#main/zenodo-community-links/urls"
                        }
                    ],
                    "out": [
                        "#main/split-links/lines"
                    ],
                    "run": "#split-by-line.cwl"
                },
                {
                    "id": "#main/zenodo-community-links",
                    "in": [
                        {
                            "id": "#main/zenodo-community-links/community",
                            "source": "#main/community"
                        }
                    ],
                    "run": "#zenodo-community-links.cwl",
                    "out": [
                        "#main/zenodo-community-links/urls"
                    ]
                },
                {
                    "id": "#main/zip-content-by-url",
                    "in": [
                        {
                            "id": "#main/zip-content-by-url/urls",
                            "source": "#main/filter-zip-extension/filtered"
                        }
                    ],
                    "run": {
                        "class": "Workflow",
                        "steps": [
                            {
                                "scatterMethod": "flat_crossproduct",
                                "in": [
                                    {
                                        "id": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/list-zip-content/url",
                                        "source": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/urls"
                                    }
                                ],
                                "id": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/list-zip-content",
                                "scatter": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/list-zip-content/url",
                                "out": [
                                    "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/list-zip-content/filenames"
                                ],
                                "run": "#zip-content-by-url.cwl"
                            }
                        ],
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "outputSource": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/list-zip-content/filenames",
                                "id": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/zip-content"
                            }
                        ],
                        "id": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba",
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "string"
                                },
                                "id": "#main/zip-content-by-url/c6462b8e-f5c4-4d44-9a06-614e6ec6efba/urls"
                            }
                        ]
                    },
                    "out": [
                        "#main/zip-content-by-url/zip-content"
                    ]
                }
            ],
            "id": "#main",
            "https://schema.org/dateCreated": "2019-09-06",
            "doc": "For a given Zenodo community, list file content of its downloadable *.zip files\n",
            "inputs": [
                {
                    "type": "string",
                    "doc": "The short-name of the Zenodo community, e.g. \"ro\" for <https://zenodo.org/communities/ro>\n",
                    "default": "ro",
                    "id": "#main/community"
                }
            ],
            "http://commonwl.org/cwltool#original_cwlVersion": "v1.0",
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
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/zip=zenodo-to-rdfa-job.yml"
                }
            ]
        },
        {
            "class": "Workflow",
            "label": "list ZIP content by URL",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "outputs": [
                {
                    "streamable": true,
                    "type": "File",
                    "doc": "A list of filenames and directories encountered in the ZIP archive,  seperated by newline. \n",
                    "outputSource": "#zip-content-by-url.cwl/list/filenames",
                    "id": "#zip-content-by-url.cwl/filenames"
                },
                {
                    "streamable": true,
                    "type": "File",
                    "doc": "A log of the HTTP response headers.\n",
                    "outputSource": "#zip-content-by-url.cwl/fetch/headers",
                    "id": "#zip-content-by-url.cwl/headers"
                }
            ],
            "https://schema.org/codeRepository": "https://github.com/stain/ro-index-paper/",
            "https://schema.org/creator": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718",
                    "https://schema.org/name": "Stian Soiland-Reyes"
                }
            ],
            "steps": [
                {
                    "id": "#zip-content-by-url.cwl/fetch",
                    "in": [
                        {
                            "id": "#zip-content-by-url.cwl/fetch/acceptType",
                            "default": "application/zip"
                        },
                        {
                            "id": "#zip-content-by-url.cwl/fetch/url",
                            "source": "#zip-content-by-url.cwl/url"
                        }
                    ],
                    "run": "#curl-get.cwl",
                    "out": [
                        "#zip-content-by-url.cwl/fetch/downloaded",
                        "#zip-content-by-url.cwl/fetch/headers"
                    ]
                },
                {
                    "id": "#zip-content-by-url.cwl/list",
                    "in": [
                        {
                            "id": "#zip-content-by-url.cwl/list/zipstream",
                            "source": "#zip-content-by-url.cwl/fetch/downloaded"
                        }
                    ],
                    "out": [
                        "#zip-content-by-url.cwl/list/filenames"
                    ],
                    "run": "#sunzip-list.cwl"
                }
            ],
            "id": "#zip-content-by-url.cwl",
            "https://schema.org/dateCreated": "2019-08-20",
            "doc": "curl will download a HTTP/HTTPS resource or file from a given URL, following any redirections.\n",
            "inputs": [
                {
                    "type": "string",
                    "doc": "The URL of the ZIP archive to inspect.\n",
                    "id": "#zip-content-by-url.cwl/url"
                }
            ],
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/result": "../test/zip=content-by-url/filenames.txt",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/zip=content-by-url/zip=content-by-url-job.yml",
                    "https://schema.org/object": "https://github.com/stain/ro-index-paper/archive/38f2a711f9f115e92cea930398019c147e56ac5a.zip"
                }
            ]
        }
    ],
    "$schemas": [
        "https://schema.org/version/3.9/schema.rdf"
    ]
}