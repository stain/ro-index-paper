---
author-meta:
- Stian Soiland-Reyes
- Paul Groth
date-meta: '2019-08-20'
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
([permalink](https://stain.github.io/ro-index-paper/v/c9bb0fbc5643289ed26e7afcdca9428a0e1716c7/))
was automatically generated
from [stain/ro-index-paper@c9bb0fb](https://github.com/stain/ro-index-paper/tree/c9bb0fbc5643289ed26e7afcdca9428a0e1716c7)
on August 20, 2019.
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

#### 2nd generation ROs

* DataCrate: <https://github.com/UTS-eResearch/datacrate/blob/master/spec/1.0/data_crate_specification_v1.0.md#examples>
* RO-Crate: <https://data.research.uts.edu.au/examples/ro-crate/0.2/>

### Manifest formats

A key characteristic of a Research Object is the presence of a _manifest_ that describes and relates the content. However, multiple potential formats and conventions have emerged for how to serialize such a format. (..)

### Proposed workflow

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

A [prototype workflow](https://github.com/stain/ro-index-paper/blob/master/code/data-gathering/workflows/zip-content-by-url.cwl) is being developed using [Common Workflow Language](https://www.commonwl.org/) [@Ppg8PzBL], figure @fig:square-image shows how the content of a ZIP file can be listed in a streaming mode.


![
**CWL workflow: List ZIP content by URL**
Visualization by CWL Viewer <https://w3id.org/cwl/view/git/cd01d30ffc9e04b8804b62df5e985ebfa6f5b276/code/data-gathering/workflows/zip-content-by-url.cwl>
](https://view.commonwl.org/graph/svg/github.com/stain/ro-index-paper/blob/master/code/data-gathering/workflows/zip-content-by-url.cwl "Workflow url to fetch to curl to headers & filenames"){#fig:square-image}




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
