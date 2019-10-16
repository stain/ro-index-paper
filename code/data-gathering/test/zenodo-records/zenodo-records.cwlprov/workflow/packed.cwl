{
    "$graph": [
        {
            "class": "CommandLineTool",
            "baseCommand": "curl",
            "arguments": [
                "--show-error",
                "--fail-early",
                "--retry",
                "10",
                "--retry-connrefused",
                "--location",
                "--remote-name-all",
                "--dump-header",
                "-"
            ],
            "hints": [
                {
                    "dockerPull": "stain/curl:7.67-DEV-f2941608f61adf1b2224ff4db400ffaeda3ea210",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "specs": [
                                "https://anaconda.org/conda-forge/curl"
                            ],
                            "version": [
                                "7.66.1"
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
                    "id": "#curl-get-many.cwl/acceptType",
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
                    "id": "#curl-get-many.cwl/urls"
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
                    "id": "#curl-get-many.cwl/downloaded"
                },
                {
                    "type": "stdout",
                    "streamable": true,
                    "doc": "A log of the HTTP response headers. If HTTP redirection with a  \"Location:\" header was received, an empty line separates the headers from subsequent requests. An empty line thereafter separates the headers from subsequent URL requests, repeated as above.\n",
                    "id": "#curl-get-many.cwl/headers"
                }
            ],
            "stdout": ".headers.txt",
            "label": "curl: download HTTP files from URLs",
            "doc": "curl will download the HTTP/HTTPS files from the given URLs, following any redirections. A list of files is returned, using filenames reflecting the URI path.\n",
            "id": "#curl-get-many.cwl",
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
            "$namespaces": {
                "iana": "https://www.iana.org/assignments/media-types/",
                "s": "https://schema.org/"
            }
        },
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
                    "id": "#gather-directory.cwl/extension"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": "File"
                        }
                    },
                    "id": "#gather-directory.cwl/files"
                },
                {
                    "type": "string",
                    "doc": "Relative name to give generated Directory, e.g. \"results\"\n",
                    "id": "#gather-directory.cwl/name"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#gather-directory.cwl/gathered"
                }
            ],
            "expression": "${\n    var listing = Array.prototype.concat.apply([], inputs.files);\n\n    if (inputs.extension != null) {\n        listing = listing.map(function rename(f) {\n            var renamed = Object.assign({}, f);\n            renamed[\"nameext\"] = inputs.extension\n            renamed[\"basename\"] = f[\"nameroot\"] + inputs.extension;\n            delete renamed[\"@id\"]; // Force CWLProv to re-register with new extension\n            return renamed;\n        });\n    }\n\n    var directory = {\n                \"class\": \"Directory\",\n                \"basename\": inputs.name,\n                \"listing\": listing\n              };\n                  \n    return { \"gathered\": directory } ;\n              \n}\n",
            "id": "#gather-directory.cwl"
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
                    "dockerPull": "stain/perl-oai-lib:branch-429-retry-after",
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
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Gregor Herrman",
                    "http://schema.org/url": "https://metacpan.org/author/GREGOA"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Jakob Voss"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Mohammad S Anwar",
                    "http://schema.org/url": "https://metacpan.org/author/MANWAR"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Nicolas Steenlant"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Sebastien Francois"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Stephen Thirlwall"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9842-9718/",
                    "http://schema.org/name": "Stian Soiland-Reyes",
                    "http://schema.org/url": "https://github.com/stain"
                }
            ],
            "http://schema.org/publisher": [
                {
                    "class": "http://schema.org/Organization",
                    "http://schema.org/name": "LibreCat",
                    "http://schema.org/url": "https://librecat.org/"
                }
            ],
            "http://schema.org/url": "https://metacpan.org/pod/HTTP::OAI::Harvester",
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
            "http://schema.org/codeRepository": "https://git.savannah.gnu.org/cgit/sed.git",
            "http://schema.org/license": "https://spdx.org/licenses/GPL-3.0-or-later",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "http://schema.org/description": "sed (stream editor) is a non-interactive command-line text editor. \nsed is commonly used to filter text, i.e., it takes text input, performs  some operation (or set of operations) on it, and outputs the modified text.  sed is typically used for extracting part of a file using pattern matching or  substituting multiple occurrences of a string within a file. \n",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/sec/sed-job.yml"
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
                    "doc": "File to split by line. Note that the file should not be larger than the CWL restrictions for loadContents (64 kiB) and should have Windows (\\r\\n) or UNIX file endings (\\n). \nLeading and trailing whitespace is ignored to avoid '' in the returned  array.\n",
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
            "expression": "${ return {\"lines\": inputs.file.contents.trim().split(/\\r?\\n/g) }; }\n",
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
            "class": "CommandLineTool",
            "baseCommand": "split",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "debian:10",
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
                                "8.31",
                                "8.30",
                                "8.26",
                                "8.23"
                            ],
                            "package": "coreutils"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Optional extension (additional suffix) for generated files, e.g. \".txt\"  will generate \"xaa.txt\", \"xab.txt\" etc. The default is no extension.\n",
                    "inputBinding": {
                        "prefix": "--additional-suffix"
                    },
                    "id": "#split-lines.cwl/extension"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1000,
                    "doc": "maximum number of lines/records per output file. The last file may have less lines.\n",
                    "inputBinding": {
                        "prefix": "--lines"
                    },
                    "id": "#split-lines.cwl/maxlines"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "default": "x",
                    "doc": "Prefix for generated files, the default is \"x\",  e.g. generating \"xaa\", \"xab\", etc.\n",
                    "id": "#split-lines.cwl/prefix"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Character to split input file into records; default is \\n (newline).\nThis parameter must be an unescaped single character  (which may need to be escaped in CWL/YAML/JSON/shell), e.g. in YAML syntax \\x1e for ASCII control character RE record separator.\nTo split by NUL character use quoted literal '\\0' in shell or double backslash \\\\0 in YAML\n",
                    "inputBinding": {
                        "prefix": "--separator"
                    },
                    "id": "#split-lines.cwl/separator"
                },
                {
                    "type": "File",
                    "streamable": true,
                    "doc": "The file which should be split\n",
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#split-lines.cwl/splittable"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "The split files.",
                    "outputBinding": {
                        "glob": "*",
                        "outputEval": "${\n  // NOTE: Assumes the glob array self is modifiable\n  self.sort(function(a, b){\n      if (a.basename < b.basename) { return -1; }\n      if (a.basename > b.basename) { return  1; }\n      return 0;\n    });\n  return self; // now sorted\n}\n"
                    },
                    "id": "#split-lines.cwl/splitted"
                }
            ],
            "label": "split a file into smaller pieces",
            "doc": "Output pieces of FILE by splitting into multiple files, e.g. \"xaa\", \"xab\", \"xac\", ... where \"x\" is the default prefix.\nThe filename suffixes are alphabetical in order  corresponding to file input, using a suffix letters a-z.\n  \nThe suffix is expanded by 2 characters before exhaustion to \"z\",  making increasingly longer filenames that are still ordered correctly, e.g. \"yy\", \"yz\", \"zaaa\", \"zaab\", later \"zyzz\", \"zzaaaa\", \"zzaaab\".\n",
            "id": "#split-lines.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Torbj\u00f8rn Granlund"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/name": "Richard M. Stallman"
                }
            ],
            "http://schema.org/copyrightHolder": [
                {
                    "class": "http://schema.org/Organization",
                    "http://schema.org/name": "Free Software Foundation",
                    "http://schema.org/url": "https://www.fsf.org/"
                }
            ],
            "http://schema.org/url": "https://www.gnu.org/software/coreutils/",
            "http://schema.org/mainEntityOfPage": "https://www.gnu.org/software/coreutils/manual/html_node/split-invocation.html#split-invocation",
            "http://schema.org/codeRepository": "https://git.savannah.gnu.org/cgit/coreutils.git",
            "http://schema.org/license": "https://spdx.org/licenses/GPL-3.0-or-later",
            "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
            "http://schema.org/description": "Given a file input, split will output its content  in pieces of multiple sequentially named files.\nsplit is part of GNU Coreutils.\n",
            "http://schema.org/potentialAction": [
                {
                    "class": "http://schema.org/ActivateAction",
                    "http://schema.org/label": "example run",
                    "http://schema.org/instrument": "../test/split/split-job.yml"
                }
            ]
        },
        {
            "class": "Workflow",
            "label": "retrieve metadata from Zenodo community",
            "doc": "For a given Zenodo community, retrieve its repository records as Zenodo JSON and (eventually) schema.org JSON-LD and DataCite v4 XML.\n",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "default": "ro",
                    "doc": "The short-name of the Zenodo community, e.g. \"ro\" for <https://zenodo.org/communities/ro> Use null for all of Zenodo.\n",
                    "id": "#main/community"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "doc": "A directory of Zenodo DataCitev4 XML records retrieved from the given Zenodo community\n",
                    "outputSource": "#main/gather-datacite4/gathered",
                    "id": "#main/zenodo-datacite4"
                },
                {
                    "type": "Directory",
                    "doc": "A directory of Zenodo JSON records retrieved from the given Zenodo community\n",
                    "outputSource": "#main/gather-json/gathered",
                    "id": "#main/zenodo-json"
                },
                {
                    "type": "Directory",
                    "doc": "A directory of Zenodo schema.org JSON-LD records retrieved from the given Zenodo community\n",
                    "outputSource": "#main/gather-jsonld/gathered",
                    "id": "#main/zenodo-jsonld"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "default": 50,
                            "id": "#main/chunk-by-line/maxlines"
                        },
                        {
                            "source": "#main/make-uri/modified",
                            "id": "#main/chunk-by-line/splittable"
                        }
                    ],
                    "out": [
                        "#main/chunk-by-line/splitted"
                    ],
                    "run": "#split-lines.cwl",
                    "id": "#main/chunk-by-line"
                },
                {
                    "run": "#curl-get-many.cwl",
                    "scatter": [
                        "#main/fetch-zenodo-datacite4/urls"
                    ],
                    "in": [
                        {
                            "valueFrom": "application/x-datacite-v41+xml",
                            "id": "#main/fetch-zenodo-datacite4/acceptType"
                        },
                        {
                            "source": "#main/split-ids-by-line/lines",
                            "id": "#main/fetch-zenodo-datacite4/urls"
                        }
                    ],
                    "out": [
                        "#main/fetch-zenodo-datacite4/downloaded"
                    ],
                    "id": "#main/fetch-zenodo-datacite4"
                },
                {
                    "run": "#curl-get-many.cwl",
                    "scatter": [
                        "#main/fetch-zenodo-json/urls"
                    ],
                    "in": [
                        {
                            "valueFrom": "application/vnd.zenodo.v1+json",
                            "id": "#main/fetch-zenodo-json/acceptType"
                        },
                        {
                            "source": "#main/split-ids-by-line/lines",
                            "id": "#main/fetch-zenodo-json/urls"
                        }
                    ],
                    "out": [
                        "#main/fetch-zenodo-json/downloaded"
                    ],
                    "id": "#main/fetch-zenodo-json"
                },
                {
                    "run": "#curl-get-many.cwl",
                    "scatter": [
                        "#main/fetch-zenodo-jsonld/urls"
                    ],
                    "in": [
                        {
                            "valueFrom": "application/ld+json",
                            "id": "#main/fetch-zenodo-jsonld/acceptType"
                        },
                        {
                            "source": "#main/split-ids-by-line/lines",
                            "id": "#main/fetch-zenodo-jsonld/urls"
                        }
                    ],
                    "out": [
                        "#main/fetch-zenodo-jsonld/downloaded"
                    ],
                    "id": "#main/fetch-zenodo-jsonld"
                },
                {
                    "run": "#gather-directory.cwl",
                    "in": [
                        {
                            "default": ".datacite4.xml",
                            "id": "#main/gather-datacite4/extension"
                        },
                        {
                            "source": "#main/fetch-zenodo-datacite4/downloaded",
                            "id": "#main/gather-datacite4/files"
                        },
                        {
                            "default": "zenodo-datacite4",
                            "id": "#main/gather-datacite4/name"
                        }
                    ],
                    "out": [
                        "#main/gather-datacite4/gathered"
                    ],
                    "id": "#main/gather-datacite4"
                },
                {
                    "run": "#gather-directory.cwl",
                    "in": [
                        {
                            "default": ".zenodo.json",
                            "id": "#main/gather-json/extension"
                        },
                        {
                            "source": "#main/fetch-zenodo-json/downloaded",
                            "id": "#main/gather-json/files"
                        },
                        {
                            "default": "zenodo-json",
                            "id": "#main/gather-json/name"
                        }
                    ],
                    "out": [
                        "#main/gather-json/gathered"
                    ],
                    "id": "#main/gather-json"
                },
                {
                    "run": "#gather-directory.cwl",
                    "in": [
                        {
                            "default": ".schemaorg.jsonld",
                            "id": "#main/gather-jsonld/extension"
                        },
                        {
                            "source": "#main/fetch-zenodo-jsonld/downloaded",
                            "id": "#main/gather-jsonld/files"
                        },
                        {
                            "default": "zenodo-jsonld",
                            "id": "#main/gather-jsonld/name"
                        }
                    ],
                    "out": [
                        "#main/gather-jsonld/gathered"
                    ],
                    "id": "#main/gather-jsonld"
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
                    "doc": "Search-replace from oai identifier to Zenodo API URL\n",
                    "run": "#sed.cwl",
                    "in": [
                        {
                            "valueFrom": "s,oai:zenodo.org:,https://zenodo.org/api/records/,",
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
                            "source": "#main/chunk-by-line/splitted",
                            "id": "#main/split-ids-by-line/file"
                        }
                    ],
                    "out": [
                        "#main/split-ids-by-line/lines"
                    ],
                    "run": "#split-by-line.cwl",
                    "scatter": [
                        "#main/split-ids-by-line/file"
                    ],
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
            "https://schema.org/dateCreated": "2019-08-23",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/potentialAction": [
                {
                    "class": "https://schema.org/ActivateAction",
                    "https://schema.org/label": "example run",
                    "https://schema.org/instrument": "../test/zenodo-records/zenodo-records-job.yml"
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