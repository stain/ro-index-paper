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
            "class": "LoadListingRequirement",
            "loadListing": "deep_listing"
        },
        {
            "class": "NetworkAccess",
            "networkAccess": true
        },
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
            "id": "#main/extension"
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
            "id": "#main/lines"
        },
        {
            "type": [
                "null",
                "string"
            ],
            "default": "x",
            "doc": "Prefix for generated files, the default is \"x\",  e.g. generating \"xaa\", \"xab\", etc.\n",
            "id": "#main/prefix"
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
            "id": "#main/separator"
        },
        {
            "type": "File",
            "streamable": true,
            "doc": "The file which should be split\n",
            "inputBinding": {
                "position": 100
            },
            "id": "#main/splittable"
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
            "id": "#main/smaller"
        }
    ],
    "label": "split a file into smaller pieces",
    "doc": "Output pieces of FILE by splitting into multiple files, e.g. \"xaa\", \"xab\", \"xac\", ... where \"x\" is the default prefix.\nThe filename suffixes are alphabetical in order  corresponding to file input, using a suffix letters a-z.\n  \nThe suffix is expanded by 2 characters before exhaustion to \"z\",  making increasingly longer filenames that are still ordered correctly, e.g. \"yy\", \"yz\", \"zaaa\", \"zaab\", later \"zyzz\", \"zzaaaa\", \"zzaaab\".\n",
    "id": "#main",
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
    ],
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