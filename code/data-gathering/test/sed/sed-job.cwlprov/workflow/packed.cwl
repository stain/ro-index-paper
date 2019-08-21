{
    "class": "CommandLineTool",
    "baseCommand": "sed",
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
            "id": "#main/command"
        },
        {
            "type": "File",
            "streamable": true,
            "doc": "The original file or byte stream which content is to be modified\n",
            "inputBinding": {
                "position": 2
            },
            "id": "#main/original"
        }
    ],
    "outputs": [
        {
            "type": "File",
            "streamable": true,
            "doc": "The modified text file",
            "id": "#main/modified",
            "outputBinding": {
                "glob": "modified.txt"
            }
        }
    ],
    "stdout": "modified.txt",
    "label": "sed search-replace",
    "doc": "Search-replace a stream using regular expressions and other SED commands.\n",
    "id": "#main",
    "https://schema.org/author": [
        {
            "class": "https://schema.org/Person",
            "https://schema.org/name": "Jay Fenlason"
        },
        {
            "class": "https://schema.org/Person",
            "https://schema.org/name": "Tom Lord"
        },
        {
            "class": "https://schema.org/Person",
            "https://schema.org/name": "Ken Pizzini"
        },
        {
            "class": "https://schema.org/Person",
            "https://schema.org/name": "Paolo Bonzini"
        }
    ],
    "https://schema.org/copyrightHolder": [
        {
            "class": "https://schema.org/Organization",
            "https://schema.org/name": "Free Software Foundation",
            "https://schema.org/url": "https://www.fsf.org/"
        }
    ],
    "https://schema.org/url": "https://www.gnu.org/software/sed/",
    "https://schema.org/mainEntityOfPage": "https://www.gnu.org/software/sed/manual/",
    "https://schema.org/codeRepository": "https://github.com/LibreCat/perl-oai-lib/",
    "https://schema.org/license": "https://spdx.org/licenses/GPL-3.0-or-later",
    "https://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
    "https://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
    "https://schema.org/description": "sed (stream editor) is a non-interactive command-line text editor. \nsed is commonly used to filter text, i.e., it takes text input, performs  some operation (or set of operations) on it, and outputs the modified text.  sed is typically used for extracting part of a file using pattern matching or  substituting multiple occurrences of a string within a file. \n",
    "https://schema.org/potentialAction": [
        {
            "class": "https://schema.org/ActivateAction",
            "https://schema.org/label": "example run",
            "https://schema.org/instrument": "../test/sed-job.yml"
        }
    ],
    "http://commonwl.org/cwltool#original_cwlVersion": "v1.0",
    "cwlVersion": "v1.1",
    "$schemas": [
        "https://schema.org/version/3.9/schema.rdf"
    ],
    "$namespaces": {
        "iana": "https://www.iana.org/assignments/media-types/",
        "s": "https://schema.org/"
    }
}