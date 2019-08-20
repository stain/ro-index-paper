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
            "id": "#main/baseurl"
        },
        {
            "type": "string",
            "default": "oai_dc",
            "inputBinding": {
                "prefix": "--metadataPrefix"
            },
            "id": "#main/metadataPrefix"
        },
        {
            "type": [
                "null",
                "string"
            ],
            "inputBinding": {
                "prefix": "--set"
            },
            "id": "#main/set"
        }
    ],
    "outputs": [
        {
            "type": "File",
            "streamable": true,
            "doc": "The OAI-PMH identifiers",
            "id": "#main/identifiers",
            "outputBinding": {
                "glob": "identifiers"
            }
        }
    ],
    "stdout": "identifiers",
    "label": "oai_pmh ListIdentifiers",
    "doc": "List repository identifiers using OAI-PMH protocol\n",
    "id": "#main",
    "https://schema.org/author": [
        {
            "class": "https://schema.org/Person",
            "https://schema.org/url": "https://github.com/timbrody",
            "https://schema.org/name": "Tim Brody"
        }
    ],
    "https://schema.org/contributor": [
        {
            "class": "https://schema.org/Person",
            "https://schema.org/identifier": "https://orcid.org/0000-0001-8390-6171",
            "https://schema.org/name": "Patrick Hochstenbach",
            "https://schema.org/url": "https://github.com/phochste"
        }
    ],
    "https://schema.org/publisher": [
        {
            "class": "https://schema.org/Organization",
            "https://schema.org/name": "LibreCat",
            "https://schema.org/url": "https://librecat.org/"
        }
    ],
    "https://schema.org/codeRepository": "https://github.com/LibreCat/perl-oai-lib/",
    "https://schema.org/isBasedOn": "https://github.com/timbrody/perl-oai-lib",
    "https://schema.org/license": "https://spdx.org/licenses/BSD-3-Clause",
    "https://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
    "https://schema.org/sdPublisher": "https://orcid.org/0000-0001-9842-9718",
    "https://schema.org/description": "OAI-PERL are a set of Perl modules that provide an API to the Open Archives\nInitiative Protocol for Metadata Harvesting (OAI-PMH).\n\nOAI-PMH is a XML-over-HTTP protocol for transferring metadata between a\nrepository (the HTTP server) and service provider (the HTTP client).\n",
    "https://schema.org/potentialAction": [
        {
            "class": "https://schema.org/ActivateAction",
            "https://schema.org/label": "example run",
            "https://schema.org/instrument": "../test/oai-pmh-job.yml"
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