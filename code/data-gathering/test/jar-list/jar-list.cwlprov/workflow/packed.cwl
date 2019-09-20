{
    "class": "CommandLineTool",
    "baseCommand": "jar",
    "arguments": [
        "t"
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
            "type": "File",
            "streamable": true,
            "format": "https://www.iana.org/assignments/media-types/application/zip",
            "id": "#main/zipstream"
        }
    ],
    "outputs": [
        {
            "type": "File",
            "streamable": true,
            "doc": "A list of filenames and directories encountered in the ZIP archive,  seperated by newline. Paths are relative to the root of the ZIP archive. The list is written in a streaming mode.\n",
            "id": "#main/filenames",
            "outputBinding": {
                "glob": "filenames.txt"
            }
        }
    ],
    "stdout": "filenames.txt",
    "id": "#main",
    "http://schema.org/codeRepository": "https://hg.openjdk.java.net/jdk/jdk11/file/1ddf9a99e4ad/src/jdk.jartool",
    "http://schema.org/url": "https://openjdk.java.net/",
    "http://schema.org/license": "https://spdx.org/licenses/GPL-2.0-with-classpath-exception",
    "http://schema.org/sdLicense": "https://spdx.org/licenses/Apache-2.0",
    "stdin": "$(inputs.zipstream.path)",
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