all:
	conda env list | grep -q ^ro-index-paper || conda env create --name ro-index-paper
	conda run -n ro-index-paper snakemake --directory data --use-conda -j --snakefile=code/data-gathering/workflows/zenodo-random-samples-zip-content/Snakefile 
