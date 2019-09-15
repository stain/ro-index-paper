---
author-meta:
- Stian Soiland-Reyes
- Paul Groth
date-meta: '2019-09-15'
keywords:
- research object
- linked data
- scholarly communication
- null
lang: en-GB
title: 'RO-Index: A survey of Research Object usage'
...






<small><em>
This manuscript
([permalink](https://stain.github.io/ro-index-paper/v/5acdbf80c8ee51fc2309a5b228171b868e6a40b5/))
was automatically generated
from [stain/ro-index-paper@5acdbf8](https://github.com/stain/ro-index-paper/tree/5acdbf80c8ee51fc2309a5b228171b868e6a40b5)
on September 15, 2019.
</em></small>

## Authors



+ **Stian Soiland-Reyes**<br>
    ![ORCID icon](images/orcid.svg){.inline_icon}
    [0000-0001-9842-9718](https://orcid.org/0000-0001-9842-9718)
    · ![GitHub icon](images/github.svg){.inline_icon}
    [stain](https://github.com/stain)
    · ![Twitter icon](images/twitter.svg){.inline_icon}
    [soilandreyes](https://twitter.com/soilandreyes)<br>
  <small>
     Department of Computer Science, The University of Manchester, UK; Informatics Institute, Faculty of Science, University of Amsterdam, NL
     · Funded by BioExcel-2 (European Commission H2020-INFRAEDI-02-2018-823830)
  </small>

+ **Paul Groth**<br>
    ![ORCID icon](images/orcid.svg){.inline_icon}
    [0000-0003-0183-6910](https://orcid.org/0000-0003-0183-6910)
    · ![GitHub icon](images/github.svg){.inline_icon}
    [pgroth](https://github.com/pgroth)<br>
  <small>
     Informatics Institute, Faculty of Science, University of Amsterdam, NL
  </small>



## Abstract

> This manuscript is **work in progress** and (for now) follows the style of a [Study Protocol](https://f1000research.com/for-authors/article-guidelines/study-protocols) for [F1000Research Registered Reports](https://f1000research.com/for-authors/article-guidelines/registered-reports)


For this study we aim to build **RO-Index**, a broad and comprehensive corpus of Research Objects found "in the wild". The proposed methodology follows multiple strands to find the "breeding grounds" of research objects and further describes how Research Objects are selected for inclusion, along with post-processing to build the corpus. 

The corpus of Research Objects will primarily be distributed as Open Data, including:

* Identifiers and access URLs
* Extracted manifests and annotation files
* Checksums/references for external data
* Metadata from repository (e.g. Datacite XML)
* Provenance of data gathering and post-processing

Research Objects that cannot be redistributed (e.g. unknown license) will only be examined for aggregates.

A brief set of qualitative and quantitative analytics will then be performed across the overall corpus, in particular to address research questions like:

* Where are Research Objects published?
* Which scientific domains produce Research Objects?
* What serializations are used for making Research Objects?
* What vocabularies are used to describe Research Objects and their content?
* What type of resources to Research Objects contain?
* What kinds of life cycles do Research Objects follow?




## Introduction

# 

## Protocol

<!-- From https://f1000research.com/for-authors/article-guidelines/study-protocols

     

Please include a clear rationale for the study, as well as a detailed description of the protocol, including:

    How the sample is to be selected
    Interventions to be measured
    Sample size calculation - i.e. expected number of participants to make the outcome significant
    Primary outcomes to be measured, as well as a list of secondary outcomes
    Data analysis and statistical plan
    Details of any ethical issues relating to the study (and of the ethical approval received).
    Plans for dissemination of the study outcome (including the associated data) once completed.
     

Ethics policies: All research must have been conducted within an appropriate ethical framework. Details of approval by the authors’ institution or an ethics committee must be provided in the Methods section. Please refer to the detailed ’Ethics’ section in our editorial policies for more information.
 -->


### Finding Research Objects

One goal of this work is to determine what kind of artifacts, in practice, can be considered a _research object_. For the purpose of building a corpus we need to have both inclusion and exclusion criteria.

The foundational article on the RO concept is [@sRYUCzCq] and its workshop predecessor [@14U5XT313]. The Research Object community has maintained lists of [initiatives](http://www.researchobject.org/initiative/) and [Research Object profiles](http://www.researchobject.org/scopes/) which provide curated, although potentially biased, collections of Research Object approaches and implementations. 

#### Declared Research Object usage

In order to determine potential sources of Research Objects we will start with these community lists, but expand based on a literature review by following any academic citation of the before-mentioned Research Object articles to find potential repositories, tools and communities that may conceptually claim to have or make "research objects". This is a broad interpretation that does not expand into general datasets or packaging formats. The list may be expanded by literate search for "Research Object", the RO vocabularies and standard URLs.

Each of the citing articles will then be assessed to see if they have openly accessible research objects that are possible to identify, and ideally retrieve, by building a programmatic crawler. Ideally such access would use an open harvesting protocol like [OAI-PMH](http://www.openarchives.org/OAI/2.0/openarchivesprotocol.htm) or [ResourceSync](http://www.openarchives.org/rs/1.1/resourcesync), but it is predicted that in the majority of cases custom crawler code will need to be developed per repository, in addition to manual harvesting of identifiers for smaller collections and individual Research Objects. 

#### Keyword searches

In addition to this "self-claimed" research object usage we will search in more general repositories by developing a list of keywords like "research object", "robundle" or the RO vocabulary URLs. We will search in at least:

* <https://github.com/>
* <https://gitlab.com/>
* <http://datacite.org/> 
* <https://zenodo.org/>
* <https://toolbox.google.com/datasetsearch/>
* <https://dataverse.harvard.edu/>

It is predicted that these searches will yield duplicates, but will be used to find potentially new Research Object sources or free-standing instances.

#### Archives with manifests

Finally we will consider broadly Open Data repositories of file archives (e.g. ZIP, tar.gz) to inspect for the presence of a _manifest_-like file (e.g. `/manifest.rdf`). For practical reasons this search will be restricted to a smaller selection of public repositories and formats, e.g. [Zenodo (20k *.zip Datasets)](https://zenodo.org/search?page=1&size=20&q=&file_type=zip&type=dataset), [FigShare ("zip" Datasets)](https://figshare.com/search?q=zip&searchMode=1&types=3), [Mendeley Data "zip" File Set](https://data.mendeley.com/datasets?query=zip&page=0&type=FILE_SET&repositoryType=NON_ARTICLE_BASED_REPOSITORY&source=MENDELEY_DATA).

A list of trigger filename patterns will be developed, including:

* `META-INF/manifest.xml` and `META-INF/container.xml` from [EPUB Open Container Format](https://www.w3.org/publishing/epub3/epub-ocf.html)
* `manifest.xml` from [COMBINE archives](http://co.mbine.org/documents/archive) [@vGs0hZI]
* `.ro/manifest.rdf` from [RO Hub](http://www.rohub.org/) [@Ut1RxNtm]
* `.ro/manifest.json`  from [Research Object Bundle](https://w3id.org/bundle/) [@dijZpInF] 
* `metadata/manifest.json` from [RO-Bagit](https://w3id.org/ro/bagit) and BDBag [@3FDNoHin; ]
* `CATALOG.json` from [DataCrate](https://github.com/UTS-eResearch/datacrate) [@1Hsf35Rx7]
* `ro-crate-metadata.jsonld` from [RO-Crate](http://researchobject.org/ro-crate/) [@19ead6wt6]

It is predicted that most of the archive files will _not_ contain such a manifest, therefore they can be inspected "on the fly" by the crawler without intermediate storage, to first detect a short-list of archives that contain a manifest-like file. These can then be downloaded in full for further inspection. File-name matching will inspect potential sub-directories, e.g. to detect `nested/data/manifest.xml`, but will classify these archives differently from direct matches.

### Candidate sources

For each candidate source we will collect and assess:

* Date assessed
* Assessed by
* URL
* Name
* Estimate # ROs
* Estimate # users
* Maintainer/publisher
* Community links  (if any)
* RO profile/format  (if any)
* Identifier scheme(s)  (if any)
* Persistence/Versioning (if any)

Then for each candidate source we will evaluate:

* Accessability - can we retrieve RO and/or their metadata
* License - permissions and/or restrictions to redistribute the ROs and/or their metadata
* Feasibility - can we programmatically retrieve all ROs (or just a sample)?
* Duplication - could the "same" RO be present by multiple identifiers or in other repositories?
* Self-identified - are Research Objects classified as such (or using similar terminology)?

We may contact the provider or maintainer to expand on these questions if unclear from public information, however we are not conducting a formal survey, as our main interest lays in the machine-readable information from the research objects themselves.

We will finally form a shortlist of sources for further harvesting, considering:

* Programmatically access (or interesting enough to warrant manual access)
* Diversity - might this source be different from the majority of sources?
* Legality - are we allowed to retrieve ROs (or their identifiers and metadata?)
* Confidentiality - are the research objects accessible to the public? (anonymous access or access by 'fresh' user registration)


### Handling personally identifiable information

Research Objects may, by their nature, contain information about people and their research activities. It is therefore important that our data collection, processing and potential re-distribution is in consistent with the [General Data Protection Regulation (GDPR)](https://www.gov.uk/government/publications/guide-to-the-general-data-protection-regulation). To this end we will evaluate:

* Does the source have a GDPR-compliant privacy policy or equivalent?
* Is personally identifiable information contained by identifier (e.g. username)?
* May personally identifiable information be contained by the Research Object manifest/description
* May personally identifiable information be contained by the Research Object files/content?
* Does the RO (or the metadata) have a license that permits redistribution and attribution, e.g. [Creative Commons Attribution 4.0 (CC-BY)](https://creativecommons.org/licenses/by/4.0/)?

Evaluating this may require retrieving research objects in the first place, but particular care will be taken to classify Research Objects and their sources according to the above evaluation in order to filter information that can progress to be part of the Open Data RO-Index corpus. This forms a staged inclusion list:

1. Unfiltered list of identifiers for a source will be shared if the identifiers tend not to include personally identifiable information
2. Metadata will be shared if it is accessible and does not tend to include personally identifiable information
3. Metadata and identifier will be shared if an open attribution-permitting license is indicated (or implied by site)
4. Content/files will be shared if accessible and an open license is indicated (or, for archives, implied by archive license)

_Note: In the above, "tend to" will be determined manually by inspecting a smaller subset of typically 10 research objects. The selection will aim to approximate a simple random subset, but may need to be expanded to take into account the overall diversity of ROs at the source, e.g. date, authors, subsystem, formats. The identifiers of the ROs of this subset will be recorded, along with a description of how the subset was selected._

The inclusion list may be further restricted based on findings from further processing (e.g. a repository is found to distribute sensitive data).

It is worth noting that compliance with open licenses like [Creative Commons Attribution 4.0 (CC-BY)](https://creativecommons.org/licenses/by/4.0/) or [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)  **require** attribution to be propagated (if present). Attribution may sometimes take the form of a URL, identifier, project or organization which do not directly identify a person.

The inclusion list will form different subsets of Research Objects:

1. Identified Research Objects
2. "Non-sensitive" (but potentially closed) metadata
3. Open metadata (potentially personally identifiable)
4. Open content (potentially personally identifiable)

Data for any excluded Research Objects will only be kept for the purpose and duration of this study on computer infrastructure managed by The University of Manchester. Data from excluded Research Objects will only be used for non-person-identifiable aggregated results (e.g. number of CSV files) and broad categorization (e.g. vocabularies used in metadata).

The identifiers from category 1, metadata from category 3 and data from category 4 will be shared in the public Open Data repository  [Zenodo](https://zenodo.org/) according to [Zenodo's policies](https://about.zenodo.org/policies/). Metadata from category 3 and 4 above may be exposed for programmatic querying (e.g. SPARQL) or converted to other formats. No additional linking with internal and external data sources will be performed, although the collected Research Objects may already contain such links (e.g. <https://orcid.org/> identifiers of authors); an exception to this rule is that linking will be permitted to detect duplicate Research Objects across multiple sources, and to access resources clearly _aggregated_ as part of the Research Object.

For GDPR purposes the _Data Controller_ is The University of Manchester, data subjects may contact `info@esciencelab.org.uk` for any enquiries, such as to request access to data about themselves, or to request update or removal of personally identifiable information.

### Pre-identified data sources

#### Proto-research objects

* [myExperiment packs](https://www.myexperiment.org/packs)
* [COMBINE archives](https://combinearchive.org/index/) [@vGs0hZI; @FJly0f6l]
* VoID datasets http://www.openphacts.org/specs/2013/WD-datadesc-20130912/ [@vGs0hZI; @13RYarvnd]
* DataONE Data packages [@B4ffHizQ]
* DataLad <https://www.datalad.org/datasets.html> [@lciHFS2H]
* [BloodHound](http://bloodhound-tracker.net/) / [Global Biodiversity Information Facility](https://gbif.org) GBIF Darwin Core Archives [@tLIHmzFN] e.g. [@11XlStsyA] <https://www.gbif.org/dataset/search>
* Crystallographic Binary File CBS/imgCIF [@YzzfnDAq] - instrument-specific metadata. HBF

#### ORE-based research objects

* CWL Viewer <https://view.commonwl.org/workflows> [@xhtkrFLT]
* RO Bundle <https://w3id.org/bundle/2014-11-05/> [@dijZpInF] 
* Workflow PROV corpus [@eV4QvWFF]
* CWLProv 10.1093/gigascience/giz095 aka [@YsYtVdV4]
* <http://www.rohub.org/> [@Ut1RxNtm]
* <http://rohub.linkeddata.es/>
* SEEK: <https://fairdomhub.org/investigations>
* BDBags with [MinID](http://minid.bd2k.org/) [@3FDNoHin; ]
* Zenodo e.g. [@Ypeevn8I]
* Mendeley Data eg [@1CrTaYKc2]
* Maven <https://repository.mygrid.org.uk/artifactory/ops/org/openphacts/data/>
* DocumentObject <https://github.com/binfalse/DocumentObjectCompiler/>
* GitHub search
* EOSC-Life (too early?)

### Software/container-based research objects

* <https://sci-f.github.io/> [@OMB8E9Yi]
* <https://frictionlessdata.io/specs/data-package/>
* The Journal of Research Objects <http://jro.world/> (see also [presentation](https://docs.google.com/presentation/d/1c4eSbTbaJ2ydEujvL1AA1rWghVFesy__nEtRIZeI-kA/edit?usp=sharing)
* Tonkaz <https://docs.google.com/presentation/d/1YRKCM1KwHyNOz7B6AP2j5qIHjl7Ew9CnAtvXA1xSeNY/edit#slide=id.g419a3a9d09_1_93>
* [ActivePaper](https://www.activepapers.org) / HDF5  [@RpWvrttS]
  > HDF5 dataset attributes are used to store metadata, including a dataflow graph that records provenance (requirement 5), but also creation time stamps and a data type indicator distinguishing references and executable code from “plain” datasets.

#### 2nd generation ROs

* DataCrate: <https://github.com/UTS-eResearch/datacrate/blob/master/spec/1.0/data_crate_specification_v1.0.md#examples>
* RO-Crate: <https://data.research.uts.edu.au/examples/ro-crate/0.2/>

### Manifest formats

A key characteristic of a Research Object is the presence of a _manifest_ that describes and relates the content. However, multiple potential formats and conventions have emerged for how to serialize such a format. (..)

### Proposed data gathering workflow

The overall data gathering workflow is envisioned as:

1. Traverse repository (or one of its sub-sections) using API like [OAI-PMH](http://www.openarchives.org/OAI/2.0/openarchivesprotocol.htm)
2. Filter for entries that have an archive-like file type (e.g. ZIP, tar.gz)
3. Retrieve entry's Datacite-like metadata from repository (e.g. DOI, author, license)
3. Start downloading archive
4. Stream archive though a utility like [sunzip](https://github.com/madler/sunzip) to list filenames within
5. Record filenames mapped to identifier
6. Select entries which have a manifest-like file in list
7. Re-download selected archives
8. Extract manifest(s) from archives
9. Classify manifests based on format and vocabulary (e.g. RDF/XML using ORE-OAI)
10. Record provenance of data gathering

Post-processing workflow:

1. Convert manifests to a unified RDF format (e.g. N-Triples)
2. Populate quad store (e.g. Apache Jena) with converted manifests
3. 


https://zenodo.org/communities/ro/?page=1&size=20

https://developers.zenodo.org/#metadata-formats

#### Prototype workflow

A [prototype workflow](https://github.com/stain/ro-index-paper/blob/master/code/data-gathering/workflows/zenodo-zip-content.cwl) is being developed using [Common Workflow Language](https://www.commonwl.org/) [@Ppg8PzBL], figure @fig:square-image shows how a a community sub-section of the [Zenodo](https://zenodo.org/) repository is being inspected to list the filenames contained within its downloadable ZIP files.

![
**CWL workflow: List ZIP content for Zenodo community**
Visualization by CWL Viewer <https://w3id.org/cwl/view/git/4360a062e7cff5aadacbf401e8e743a660657680/code/data-gathering/workflows/zenodo-zip-content.cwl>
](https://w3id.org/cwl/view/git/4360a062e7cff5aadacbf401e8e743a660657680/code/data-gathering/workflows/zenodo-zip-content.cwl?format=svg "Inspect downloadable zip files in Zenodo"){#fig:square-image}

In brief the prototype workflow consists of these steps:

1. For a given Zenodo community, e.g. <https://zenodo.org/communities/ro>, retrieve its OAI-PMH entries using DataCite v4 XML e.g. <https://zenodo.org/oai2d?verb=ListRecords&set=user-ro&metadataPrefix=datacite4>
2. Extract the URI for the Zenodo record, e.g. <oai:zenodo.org:1484341>
3. Search-replace to build the URI of the the corresponding Zenodo landing page, e.g. <https://zenodo.org/record/2838898>
4. Retrieve the HTML of the landing page
5. Extract the [link relations](https://tools.ietf.org/html/rfc8288) of type [alternate](https://html.spec.whatwg.org/multipage/links.html#rel-alternate) to find the download links
6. Filter for download links that end with `*.zip`
7. Retrieve ZIP file
8. List filenames within ZIP file
9. Detect filenames like `manifest.rdf` `eml.xml`  or `meta.xml` within list and return original Zenodo URI or `null` _(in development)_

The workflow and its components have been tested with the reference implementation `cwltool` [@YRViKAa0] which can provide rich provenance captured in CWLProv research objects [@12kpw3Zbe] <!-- in press 10.1093/gigascience/giz095-->

In developing this prototype several challenges where immediately detected:

* The [OAI-PMH records](https://zenodo.org/oai2d?verb=ListRecords&set=user-ro&metadataPrefix=datacite4) contain substansive DataCite information, but do not include the links to the Zenodo record or the ZIP downloads. The identifiers for records is in a form that is specific to OAI-PMH, e.g. `oai:zenodo.org:1310621` and had to be rewritten to a URI using the same record number.
  * The [Zenodo API](https://developers.zenodo.org/) does include these additional URIs - but is not available for anonymous use as it requires a registration token. Distributing this token as part of the workflow provenance would give access to the author's Zenodo account.
* The HTML landing page provides links to structured metadata, e.g. as JSON-LD using Schema.org <https://zenodo.org/record/1310621/export/schemaorg_jsonld> but the structured data is included in a `<pre>` block within HTML (for copy-pasting) and not programmatically accessible. HTTP content-negotiation does not give direct access to the structured data.  There are no `alternate` links from the HTML landing page to these "export" pages, so their URIs would have to be manually constructed. 
  * The JSON-LD does include links to downloads of ZIP files etc, but only if the Record is of type _Dataset_ in Zenodo, which [in JSON-LD](https://zenodo.org/record/2838898/export/schemaorg_jsonld#.XXdwzffTU5k) is represented as a [DataDownload](http://schema.org/DataDownload) with a [contentUrl](http://schema.org/contentUrl)
* To list filename contained in a ZIP file, the whole file must be downloaded because in the [ZIP format](https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT) the table of content is written at the end of the file
  * The host providing Zenodo downloads do not support the [HTTP Range](https://tools.ietf.org/html/rfc7233) request header, so it is not possible to download say only the last 128 kB of the ZIP file.
  * Some of the dataset downloads are larger than 1 GB
  * `cwltool` saves all intermediate values until the end of the workflow
* To preserve disk space use during download of ZIP file only, an initial idea was explored of using the CWL [streamable](https://www.commonwl.org/v1.1/CommandLineTool.html#CommandOutputRecordField) feature so that the output of `curl` could be passed to the utillity [sunzip](https://github.com/madler/sunzip) which can extract/inspect ZIP files in a streaming fashion
  * It was found that while the sunzip tool supports streamable extraction and testing based on the intermediate file entry records of the ZIP file, it does not decide or list the filenames before the end of the download. Thus the output of `sunzip -t` (test extract) itself is not streamable
  * An experimental new feature `sunzip -l` was [attempted](https://github.com/madler/sunzip/pull/3), where file names of records are printed as they are encountered. This is at the risk of printing files that have subsequently been deleted from the ZIP file and do not appear in the table of content. This was considered a small risk as the primary purpose was to detect ZIP files containing "manifest-like" files and it was assumed that most deposited ZIP files had been created in a one-off operation and would not have inconsistent file records.
  * The experimental feature however detected that several files found in Zenodo are written with a "deferred length" - the intermitting ZIP records do not record their length and so `sunzip` is unable to find the offset to the next record without actually decompressing the stream.
  * It was found that `cwltool --parallel`  did not seem to start the subsequent step and thus did not facilitate the `streamable` feature. The ZIP files were still saved to disk, and all the ZIP file downloads where completed before any of the ZIP extraction was started.  Future work will explore using the implementation `toil` which have been argued to have better support for concurrency.

<!--
TODO: 

- Create PROV entities for each record, download, manifest, datacite etc.

- Can we get data/stats for all of Zenodo? Start download to fill .cache


Some of the commands..

## Download all records (many of are 404)
# TODO: Run from OAI-PMH ids to avoid 404
# TODO: Respect Retry and X-Ratelimit headers
# TODO: Parallelize 2-3 threads so it does not take 3 days
curl --retry 10 -H "Accept: application/vnd.zenodo.v1+json" 'https://zenodo.org/api/records/[1-3450000]' -o "record_#1.json"

# TODO: Consistency check of records
find . -maxdepth 1 -type f -name 'record*json' | xargs grep ^.."status.*404" | cut -d ":" -f 1 | xargs mv -t 404/


### TODO: Redo as Jupyter notebook

### Let's check the size of the *.zip files

find . -maxdepth 1 -type f -name 'record*json' | xargs -n3 cat | jq '.files[]? | select(.type == "zip") | reduce .size as $s (0; . + $s)  ' > zipsizes.txt


## Some quick estimates on workload and network/disk requirements :

# How many terabytes to download?
cat zipsizes.txt | jq --slurp 'reduce .[] as $s (0; . + $s) | ./1024 /1024 /1024 / 1024'
3.8408555243122464
# (at 1008098/3450000 downloaded) 

# So in total we will need to download about 13 TB
stain@ondex2:/tmp/zenodo$ cat zipsizes.txt | jq --slurp 'reduce .[] as $s (0; . + $s) | ./1024 /1024 /1024 / 1024 /1008098*3450000'
13.144507338450477

# Downloading 19 MB takes 0.8 s
# stain@ondex2:/tmp$ time wget https://zenodo.org/api/files/36ee07d5-7c07-4382-8463-4502d98148a4/s10.zip
--2019-09-15 00:13:19--  https://zenodo.org/api/files/36ee07d5-7c07-4382-8463-4502d98148a4/s10.zip
Resolving zenodo.org (zenodo.org)... 188.184.65.20
Connecting to zenodo.org (zenodo.org)|188.184.65.20|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 20233334 (19M) [application/octet-stream]
Saving to: 's10.zip.1'

s10.zip.1                                          100%[================================================================================================================>]  19.30M  59.6MB/s    in 0.3s    

2019-09-15 00:13:20 (59.6 MB/s) - 's10.zip.1' saved [20233334/20233334]


real    0m0.823s
user    0m0.056s
sys     0m0.128s

## Only 6000/31370 files or so are more than 30 MB.
stain@ondex2:/tmp/zenodo$ cat zipsizes.txt | jq 'select(. > 30*1024*1024)' | wc -l
6318

## Only 655/31370 are more than 1 GB
stain@ondex2:/tmp/zenodo$ cat zipsizes.txt | jq 'select(. > 1024*1024*1024)' | wc -l
655

## Downloading a file of 10 GB runs at 73.9 MB/s avg
(tested at Sunday 2019-09-15 01:24 - so over-ideal timing)

stain@ondex2:/tmp$ time wget https://zenodo.org/api/files/2cdaea21-80be-48b9-9ab2-259671795f7a/br20832_cores.zip
--2019-09-15 00:22:52--  https://zenodo.org/api/files/2cdaea21-80be-48b9-9ab2-259671795f7a/br20832_cores.zip
Resolving zenodo.org (zenodo.org)... 188.184.65.20
Connecting to zenodo.org (zenodo.org)|188.184.65.20|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 10081056983 (9.4G) [application/octet-stream]
Saving to: 'br20832_cores.zip'

br20832_cores.zip                                  100%[================================================================================================================>]   9.39G   101MB/s    in 2m 10s  

2019-09-15 00:25:03 (73.9 MB/s) - 'br20832_cores.zip' saved [10081056983/10081056983]


real    2m10.634s
user    0m31.100s
sys     0m55.288s

## This machine is on a single Gbit link (capable of two links) with MTU 1500 
# in server room of Computer Science UNIMAN - jumboframes not supported by network




## Absolute fastest we can download 13 TB?
stain@ondex2:/tmp/zenodo$ jq -n '13.144507338450477 * 1024 *1024 / 73.9 / 3600 / 24'
2.158668954374506
# aka 2 days 

# how long would Non-parallel download of the small files take?

cat zipsizes.txt | jq 'select(. <= 30*1024*1024)' | wc -l
25052

(tip, 1008098*3450000 is the scaling factor as these estimates are done after
downloading about 30 % of zenodo records -- WARNING: Those are not representative but 
are the 30% oldest. )

stain@ondex2:/tmp/zenodo$ jq -n '25052 * 0.823 / 1008098*3450000 / 3600 / 24'
0.816

# Should take less than a day? (That would means API download is slower.. )

So in total 3 days for all zip downloads. No need for special measures.

# All the small ZIP files fit on single disk 
stain@ondex2:/tmp/zenodo$ cat zipsizes.txt | jq -s '.[] | select(. <= 30*1024*1024)' | jq -s 'reduce .[] as $s (0; . + $s)  / 0.30/ 1024/1024/1024'
322.71499813844764

# .. but just about!
stain@ondex2:/tmp/zenodo$ df -h .
Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-tmp  296G   46G  235G  17% /tmp

## TODO: Decide on threshold for data that should be kept on disk

## TODO: Can we use Isolon for local storage..? No bandwidth benefit
# but perhaps latency improvement. Might have just 300 GB quota left

# //nasr.man.ac.uk/epsrss$/snapped/replicated/goble/methodbox
#                      600T  555T   46T  93% /rds/methodbox


# Use methodbox.cs.man.ac.uk ...? More diskspace (0.8 TB * 2)
# the 1TB of Isilon storage has now been setup and is available for use. 

## artifactory Used: 790.6 GB
## methodbox 189G
## uh.. 1 TB alrady

-->



## Conclusions/Discussion



## Data (and Software) Availability

<!--
From https://f1000research.com/for-authors/article-guidelines/study-protocols


All articles must include a Data Availability statement, even where there is no data associated with the article - see our data guidelines and policies for more information.
The Data Availability statement should provide full details of how, where, and under what conditions the data underlying the results can be accessed; for practical guidance please see Add a Data Availability statement to your manuscript. See also Prepare your Data and Select a Repository for further guidance on data presentation, formatting and deposition. 


If you are describing new software, please make the source code available on a Version Control System (VCS) such as GitHub, BitBucket or SourceForge, and provide details of the repository and the license under which the software can be used in the article.
For other scenarios, such as where data cannot be shared, please see Add a Data Availability statement to your manuscript for details of what must be indicated in your Data Availability statement.

 Extended data
There are no figure or table limits for articles in F1000Research. Additional materials that support the key claims in the paper but are not absolutely required to follow the study design and analysis of the results, e.g. questionnaires, supporting images or tables, can be included as extended data; descriptions of the materials and methods should be in the main article. Extended data should be in a format the supports reuse under a CC0 license. Care should be taken to ensure that the publication of extended data in this instance does not preclude primary publication elsewhere.
If you have any extended data, please deposit these materials in an approved repository and include the title, the name of the repository, the DOI or accession number, and license in the manuscript under the subheading ‘Extended data’. Please also include citations to extended data in the main body of the article. For practical guidance please see Add a Data Availability statement to your manuscript. See also Prepare your Data and Select a Repository for further guidance on data presentation, formatting and deposition.
Please note, information which can be used to directly identify participants should not be included in underlying and extended datasets, unless they have provided explicit permission to share their details. Please see our data guidelines for further information. 

-->

## Author contributions

<!--
http://casrai.org/credit
-->

* Conceptualization: 
* Data Curation: 
* Formal Analysis: 
* Funding Acquisition: SSR, CAG
* Investigation: 
* Methodology: 
* Project Administration:
* Resources: CAG, SSR
* Software: SSR
* Supervision: PG
* Validation: 
* Visualization: 
* Writing – Original Draft Preparation: SSR
* Writing – Review & Editing: 

## Competing interests

## Grant Information


This work has been done as part of the BioExcel CoE ([www.bioexcel.eu](https://www.bioexcel.eu/)), a project funded by the European Union contracts [H2020-INFRAEDI-02-2018-823830](https://cordis.europa.eu/project/id/823830), [H2020-EINFRA-2015-1-675728](https://cordis.europa.eu/project/id/675728).

## References

<!-- Explicitly insert bibliography here -->
<div id="refs"></div>
