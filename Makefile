all:
	conda env list | grep -q ^ro-index-paper || conda env create --name ro-index-paper
	conda run -n ro-index-paper snakemake --directory data --restart-times 5 --use-conda -j all --snakefile=code/data-gathering/workflows/zenodo-random-samples-zip-content/Snakefile 
clean:
	rm -rf data/sample data/listing data/zip data/zenodo-records/zipfiles*tsv
