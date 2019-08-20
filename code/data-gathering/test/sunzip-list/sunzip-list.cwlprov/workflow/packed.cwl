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
            "class": "LoadListingRequirement",
            "loadListing": "deep_listing"
        },
        {
            "class": "NetworkAccess",
            "networkAccess": true
        },
        {
            "dockerPull": "stain/sunzip",
            "class": "DockerRequirement"
        }
    ],
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
    ],
    "stdin": "$(inputs.zipstream.path)",
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