# RO-Index: A survey of Research Object usage

<!-- usage note: edit the H1 title above to personalize the manuscript -->

[![HTML Manuscript](https://img.shields.io/badge/manuscript-HTML-blue.svg)](https://stain.github.io/ro-index-paper/)
[![PDF Manuscript](https://img.shields.io/badge/manuscript-PDF-blue.svg)](https://stain.github.io/ro-index-paper/manuscript.pdf)
[![Build Status](https://travis-ci.com/stain/ro-index-paper.svg?branch=master)](https://travis-ci.com/stain/ro-index-paper)

## Manuscript description

<!-- usage note: edit this section. -->

This is the automated scholarly manuscript [RO-Index: A survey of Research Object usage](https://stain.github.io/ro-index-paper/) and related analytical [source code](code).

> For this study we aim to build **RO-Index**, a broad and comprehensive corpus 
> of [Research Objects](http://www.researchobject.org/) found "in the wild". 
> The proposed methodology follows multiple strands to find the 
> "breeding grounds" of research objects and describes how 
> Research Objects are selected for inclusion in the corpus.

This manuscript is **work in progress** and (for now) follows the style of a [Study Protocol](https://f1000research.com/for-authors/article-guidelines/study-protocols) for [F1000Research Registered Reports](https://f1000research.com/for-authors/article-guidelines/registered-reports) - although it may be 

## Contributing feedback

Please [raise an issue](https://github.com/stain/ro-index-paper/issues) or a [pull request](https://github.com/stain/ro-index-paper/pulls) using GitHub for any suggestions, comments, additions and corrections. Any non-trivial contributions will be recognized as authorship, so it is preferable if you include your [ORCID](https://orcid.org/) in the issue description.

Any received contributions are assumed to be covered by the [manuscript and/or code license](#license).

## Manubot

<!-- usage note: do not edit this section -->

Manubot is a system for writing scholarly manuscripts via GitHub.
Manubot automates citations and references, versions manuscripts using git, and enables collaborative writing via GitHub.
An [overview manuscript](https://greenelab.github.io/meta-review/ "Open collaborative writing with Manubot") presents the benefits of collaborative writing with Manubot and its unique features.
The [rootstock repository](https://git.io/fhQH1) is a general purpose template for creating new Manubot instances, as detailed in [`SETUP.md`](SETUP.md).
See [`USAGE.md`](USAGE.md) for documentation how to write a manuscript.

Please open [an issue](https://git.io/fhQHM) for questions related to Manubot usage, bug reports, or general inquiries.

### Repository directories & files

The directories are as follows:

+ [`content`](content) contains the manuscript source, which includes markdown files as well as inputs for citations and references.
  See [`USAGE.md`](USAGE.md) for more information.
+ [`output`](output) contains the outputs (generated files) from Manubot including the resulting manuscripts.
  You should not edit these files manually, because they will get overwritten.
+ [`webpage`](webpage) is a directory meant to be rendered as a static webpage for viewing the HTML manuscript.
+ [`build`](build) contains commands and tools for building the manuscript.
+ [`ci`](ci) contains files necessary for deployment via continuous integration.
  For the CI configuration, see [`.travis.yml`](.travis.yml).
+ [`code`](code) contains scripts/workflow for data gathering and analytics.

### Local execution

The easiest way to run Manubot is to use [continuous integration](#continuous-integration) to rebuild the manuscript when the content changes.
If you want to build a Manubot manuscript locally, install the [conda](https://conda.io) environment as described in [`build`](build).
Then, you can build the manuscript on POSIX systems by running the following commands from this root directory.

```sh
# Activate the manubot conda environment (assumes conda version >= 4.4)
conda activate manubot

# Build the manuscript, saving outputs to the output directory
bash build/build.sh

# At this point, the HTML & PDF outputs will have been created. The remaining
# commands are for serving the webpage to view the HTML manuscript locally.
# This is required to view local images in the HTML output.

# Configure the webpage directory
python build/webpage.py

# You can now open the manuscript webpage/index.html in a web browser.
# Alternatively, open a local webserver at http://localhost:8000/ with the
# following commands.
cd webpage
python -m http.server
```

Sometimes it's helpful to monitor the content directory and automatically rebuild the manuscript when a change is detected.
The following command, while running, will trigger both the `build.sh` and `webpage.py` scripts upon content changes:

```sh
bash build/autobuild.sh
```

### Continuous Integration

[![Build Status](https://travis-ci.com/stain/ro-index-paper.svg?branch=master)](https://travis-ci.com/stain/ro-index-paper)

Whenever a pull request is opened, Travis CI will test whether the changes break the build process to generate a formatted manuscript.
The build process aims to detect common errors, such as invalid citations.
If your pull request build fails, see the Travis CI logs for the cause of failure and revise your pull request accordingly.

When a commit to the `master` branch occurs (for example, when a pull request is merged), Travis CI builds the manuscript and writes the results to the [`gh-pages`](https://github.com/stain/ro-index-paper/tree/gh-pages) and [`output`](https://github.com/stain/ro-index-paper/tree/output) branches.
The `gh-pages` branch uses [GitHub Pages](https://pages.github.com/) to host the following URLs:

+ **HTML manuscript** at https://stain.github.io/ro-index-paper/
+ **PDF manuscript** at https://stain.github.io/ro-index-paper/manuscript.pdf

For continuous integration configuration details, see [`.travis.yml`](.travis.yml).

## License

<!--
usage note: edit this section to change the license of your manuscript or source code changes to this repository.
We encourage users to openly license their manuscripts, which is the default as specified below.
-->

[![License: CC BY 4.0](https://img.shields.io/badge/License%20All-CC%20BY%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by/4.0/)
[![License: LICENSE-Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue)](https://www.apache.org/licenses/LICENSE-2.0)

The manuscript-part of this repository is licensed under a CC BY 4.0 License ([`LICENSE.md`](LICENSE.md)), which allows reuse with attribution.
Please attribute by linking to <https://github.com/stain/ro-index-paper> and <https://orcid.org/0000-0001-9842-9718>.

* Copyright (c) 2019 The University of Manchester, UK
* Copyright (c) 2019 University of Amsterdam, The Netherlands

Since CC BY is not ideal for code and data, certain repository components are also released under the [Apache Software License, version 2.0](https://www.apache.org/licenses/LICENSE-2.). ([`LICENSE-Apache-2.0.md`](LICENSE-Apache-2.0.md)).
All files matched by the following glob patterns are dual licensed under CC BY 4.0 and Apache-2.0:

+ `code/*`
+ `*.sh`
+ `*.py`
+ `*.cwl`
+ `*.yml` / `*.yaml`
+ `*.json`
+ `*.bib`
+ `*.tsv`
+ `.gitignore`

All other manuscript files are only available under CC BY 4.0, including:

+ `*.md`
+ `*.html`
+ `*.pdf`
+ `*.docx`
+ `*.svg`
+ `*.png`


Please open [an issue](https://github.com/stain/ro-index-paper/issues) for any question related to licensing.
