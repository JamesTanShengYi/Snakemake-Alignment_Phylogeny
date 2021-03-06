# Snakemake-Alignment_Phylogeny

## Snakemake file
This snakemake file contains a workflow allowing the creation of MAFFT alignments and RAxML phylogenies. Inputs can either be a set of amino acid or nucleotide sequences.
It is coded for use with a [snakemake configuration by RomainFeron](https://github.com/RomainFeron/snakemake-slurm), so that it works with a computing cluster managed by SLURM. Note that the outgroups in the ProteinTree and GeneTree rules need to be changed to accomodate your dataset.


## Dataset
Contains the amino acid and CDS sequences of the sex determination gene _doublesex_ in _Aedes aegypti, Drosophila melanogaster_ and 13 _Anopheles_ species. Male and female transcripts are present within each. This was the original dataset the workflow was tested on when I made it.
