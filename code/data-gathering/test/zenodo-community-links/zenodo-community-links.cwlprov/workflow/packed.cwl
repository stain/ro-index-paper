{
    "$graph": [
        {
            "class": "CommandLineTool",
            "baseCommand": "cat",
            "arguments": [
                "--squeeze-blank"
            ],
            "hints": [
                {
                    "dockerPull": "debian:9",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "specs": [
                                "https://anaconda.org/conda-forge/coreutils",
                                "https://packages.debian.org/jessie/coreutils",
                                "https://packages.debian.org/stretch/coreutils",
                                "https://packages.debian.org/buster/coreutils",
                                "https://packages.debian.org/bullseye/coreutils",
                                "https://packages.debian.org/sid/coreutils"
                            ],
                            "version": [
                                "7.39.0",
                                "7.65.3",
                                "7.38.0",
                                "7.52.1",
                                "7.64.0",
                                "7.65.3"
                            ],
                            "package": "coreutils"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "streamable": true,
                    "doc": "A list of files to be concatinated\n",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#cat.cwl/files"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "The concatinated file, written in streamable mode.",
                    "id": "#cat.cwl/concatinated"
                }
            ],
            "stdout": "concatinated",
            "label": "cat: concatinate files",
            "doc": "concatinate files to a single streamable file\n",
            "id": "#cat.cwl",
            "$namespaces": {
                "iana": "https://www.iana.org/assignments/media-types/",
                "s": "https://schema.org/"
            }
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "oai_pmh",
            "arguments": [
                "--request",
                "ListIdentifiers",
                {
                    "shellQuote": false,
                    "position": 100,
                    "valueFrom": "| grep identifier:"
                },
                {
                    "shellQuote": false,
                    "position": 200,
                    "valueFrom": "| sed 's/^.*identifier: //g'"
                }
            ],
            "requirements": [
                {
                    "dockerImageId": "stain/perl-oai-lib",
                    "dockerFile": "FROM debian:9\nRUN apt-get update && apt-get -y install libhttp-oai-perl\n# Quick-and-dirty patch for https://github.com/LibreCat/perl-oai-lib/pull/5\nRUN sed -i \"/identifier=s/ a 'set=s',\" /usr/bin/oai_pmh\n",
                    "class": "DockerRequirement"
                },
                {
                    "class": "ShellCommandRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "doc": "The OAI-PMH base URL, e.g. \"https://zenodo.org/oai2d\"\n",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#oai-pmh.cwl/baseurl"
                },
                {
                    "type": "string",
                    "default": "oai_dc",
                    "inputBinding": {
                        "prefix": "--metadataPrefix"
                    },
                    "id": "#oai-pmh.cwl/metadataPrefix"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--set"
                    },
                    "id": "#oai-pmh.cwl/set"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "The OAI-PMH identifiers",
                    "id": "#oai-pmh.cwl/identifiers"
                }
            ],
            "stdout": "identifiers",
            "label": "oai_pmh ListIdentifiers",
            "doc": "List repository identifiers using OAI-PMH protocol\n",
            "id": "#oai-pmh.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/url": "https://github.com/timbrody",
                    "http://schema.org/name": "Tim Brody"
                }
            ],
            "http://schema.org/contributor": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8390-6171",
                    "http://schema.org/name": "Patrick Hochstenbach",
                    "http://schema.org/url": "https://github.com/phochste"
                }
            ],
            "http://schema.org/publisher": [
                {
                    "class": "http://schema.org/Organization",
                    "http://schema.org/name": "LibreCat",
                    "http://schema.org/url": "https://librecat.org/"
                }
            ],
            "http://schema.org/codeRepository": "https://github.com/LibreCat/perl-oai-lib/",
            "http://schema.org/isBasedOn": "https://github.com/timbrody/perl-oai-lib",
            "http://schema.org/license": "https://spdx.org/licenses/BSD-3-Clause",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "http://schema.org/description": "OAI-PERL are a set of Perl modules that provide an API to the Open Archives\nInitiative Protocol for Metadata Harvesting (OAI-PMH).\n\nOAI-PMH is a XML-over-HTTP protocol for transferring metadata between a\nrepository (the HTTP server) and service provider (the HTTP client).\n",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/oai-pmh-job.yml"
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "scrapy",
            "hints": [
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
                    "id": "#scrapy-meta.cwl/url"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "The link URLs found, separated by newline",
                    "id": "#scrapy-meta.cwl/links"
                }
            ],
            "stdout": "links.txt",
            "label": "scrapy find meta rel=alternate links",
            "doc": "Parse HTML and find meta link elements with rel=\"alternate\"\n",
            "id": "#scrapy-meta.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "sed",
            "hints": [
                {
                    "dockerPull": "debian:9",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "specs": [
                                "https://anaconda.org/conda-forge/sed",
                                "https://packages.debian.org/jessie/sed",
                                "https://packages.debian.org/stretch/sed",
                                "https://packages.debian.org/buster/sed",
                                "https://packages.debian.org/bullseye/sed",
                                "https://packages.debian.org/sid/sed"
                            ],
                            "version": [
                                "4.2.2",
                                "4.4",
                                "4.7"
                            ],
                            "package": "sed"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                "--unbuffered",
                "--regexp-extended"
            ],
            "inputs": [
                {
                    "type": "string",
                    "doc": "The regular expression to be used for search-replace, \nin the form of a sed \"s/from/to/\" command, e.g. \n\"s/^/_/\" will insert an underscore at beginning of each line, \nwhile \"s/http/https/g\" will replace every \"http\" with \"https\".\n\nThis CWL wrapper enables the extended (ERE) regular expression\nand operates in streamable mode.\n\nSee also \n<https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html> and \n<https://www.gnu.org/software/sed/manual/html_node/sed-regular-expressions.html>\n",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#sed.cwl/command"
                },
                {
                    "type": "File",
                    "streamable": true,
                    "doc": "The original file or byte stream which content is to be modified\n",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#sed.cwl/original"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "The modified text file",
                    "id": "#sed.cwl/modified"
                }
            ],
            "stdout": "modified.txt",
            "label": "sed search-replace",
            "doc": "Search-replace a stream using regular expressions and other SED commands.\n",
            "id": "#sed.cwl",
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
            "http://schema.org/copyrightHolder": [
                {
                    "class": "http://schema.org/Organization",
                    "http://schema.org/name": "Free Software Foundation",
                    "http://schema.org/url": "https://www.fsf.org/"
                }
            ],
            "http://schema.org/url": "https://www.gnu.org/software/sed/",
            "http://schema.org/mainEntityOfPage": "https://www.gnu.org/software/sed/manual/",
            "http://schema.org/codeRepository": "https://github.com/LibreCat/perl-oai-lib/",
            "http://schema.org/license": "https://spdx.org/licenses/GPL-3.0-or-later",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "http://schema.org/description": "sed (stream editor) is a non-interactive command-line text editor. \nsed is commonly used to filter text, i.e., it takes text input, performs  some operation (or set of operations) on it, and outputs the modified text.  sed is typically used for extracting part of a file using pattern matching or  substituting multiple occurrences of a string within a file. \n",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/sed-job.yml"
                }
            ]
        },
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
                    "id": "#split-by-line.cwl/file"
                }
            ],
            "outputs": [
                {
                    "doc": "Array of lines from file, excluding newline symbol.\n",
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "id": "#split-by-line.cwl/lines"
                }
            ],
            "expression": "${ return {\"lines\": inputs.file.contents.split(/\\r?\\n/g) }; }\n",
            "id": "#split-by-line.cwl",
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
            ]
        },
        {
            "class": "Workflow",
            "label": "find downloadable files in zenodo community",
            "doc": "For a given Zenodo community, retrieve a list of all its downloadable files\n",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "default": "ro",
                    "doc": "The short-name of the Zenodo community, e.g. \"ro\" for <https://zenodo.org/communities/ro>\n",
                    "id": "#main/community"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "streamable": true,
                    "doc": "A list of downloadable URLs across the community\n",
                    "outputSource": "#main/flatten/concatinated",
                    "id": "#main/urls"
                }
            ],
            "steps": [
                {
                    "run": "#scrapy-meta.cwl",
                    "scatter": [
                        "#main/fetch-meta/url"
                    ],
                    "in": [
                        {
                            "source": "#main/split-ids-by-line/lines",
                            "id": "#main/fetch-meta/url"
                        }
                    ],
                    "out": [
                        "#main/fetch-meta/links"
                    ],
                    "id": "#main/fetch-meta"
                },
                {
                    "run": "#cat.cwl",
                    "in": [
                        {
                            "source": "#main/fetch-meta/links",
                            "id": "#main/flatten/files"
                        }
                    ],
                    "out": [
                        "#main/flatten/concatinated"
                    ],
                    "id": "#main/flatten"
                },
                {
                    "run": "#oai-pmh.cwl",
                    "in": [
                        {
                            "valueFrom": "https://zenodo.org/oai2d",
                            "id": "#main/list-ids/baseurl"
                        },
                        {
                            "source": "#main/community",
                            "valueFrom": "user-$(self)",
                            "id": "#main/list-ids/set"
                        }
                    ],
                    "out": [
                        "#main/list-ids/identifiers"
                    ],
                    "id": "#main/list-ids"
                },
                {
                    "run": "#sed.cwl",
                    "in": [
                        {
                            "valueFrom": "s,oai:zenodo.org:,https://zenodo.org/record/,",
                            "id": "#main/make-uri/command"
                        },
                        {
                            "source": "#main/list-ids/identifiers",
                            "id": "#main/make-uri/original"
                        }
                    ],
                    "out": [
                        "#main/make-uri/modified"
                    ],
                    "id": "#main/make-uri"
                },
                {
                    "in": [
                        {
                            "source": "#main/make-uri/modified",
                            "id": "#main/split-ids-by-line/file"
                        }
                    ],
                    "out": [
                        "#main/split-ids-by-line/lines"
                    ],
                    "run": "#split-by-line.cwl",
                    "id": "#main/split-ids-by-line"
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
            "https://schema.org/dateCreated": "2019-08-21",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/zip=zenodo-to-rdfa-job.yml"
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