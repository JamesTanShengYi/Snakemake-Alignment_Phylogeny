rule GeneAlignmentClustal:
    input:
        "{gene}G.fasta"
    output:
        "GenesAlignments/{gene}Gclus.aln"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "source /dcsrsoft/spack/bin/setup_dcsrsoft;"
        "module load gcc/8.3.0;"
        "module load mafft/7.453;"
        "mafft --maxiterate 100 --globalpair --clustalout {input} > GenesAlignments/{wildcards.gene}Gclus.aln;"

rule GeneAlignmentFasta:
    input:
        "{gene}G.fasta"
    output:
        "GenesAlignments/{gene}Gfas.aln"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "source /dcsrsoft/spack/bin/setup_dcsrsoft;"
        "module load gcc/8.3.0;"
        "module load mafft/7.453;"
        "mafft --maxiterate 100 --globalpair {input} > GenesAlignments/{wildcards.gene}Gfas.aln;"

rule GeneAlignmentTrimmed:
    input:
        "GenesAlignments/{gene}Gfas.aln"
    output:
        "GenesAlignmentsTrimmed/{gene}Gtrimmedfas.aln",
        "GenesAlignmentsTrimmed/{gene}Gtrimmedfas.html"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "module load Bioinformatics/Software/vital-it;"
        "module add SequenceAnalysis/Filtering/trimAl/1.4.1;"
        "module load SequenceAnalysis/Filtering/trimAl/1.4.1;"
        "trimal -in {input} -out {wildcards.gene}Gtrimmedfas.aln -htmlout {wildcards.gene}Gtrimmedfas.html -automated1;"
        "mv *trimmed* /users/jtan/scratch/jtan/1ststep/dsx/GenesAlignmentsTrimmed/;"
        "cd ..;"

rule GeneTree:
    input:
        "GenesAlignmentsTrimmed/{gene}Gtrimmedfas.aln"
    output:
        "GenesTrees/{gene}GTree/RAxML_bestTree.{gene}GTree",
        "GenesTrees/{gene}GTree/RAxML_bipartitions.{gene}GTree",
        "GenesTrees/{gene}GTree/RAxML_bipartitionsBranchLabels.{gene}GTree",
        "GenesTrees/{gene}GTree/RAxML_bootstrap.{gene}GTree",
        "GenesTrees/{gene}GTree/RAxML_info.{gene}GTree"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "module load Bioinformatics/Software/vital-it;"
        "module add Phylogeny/raxml/8.2.12;"
        "module load Phylogeny/raxml/8.2.12;"
        "cd GenesAlignmentsTrimmed;"
        "rm -r /users/jtan/scratch/jtan/1ststep/dsx/GenesTrees/{wildcards.gene}GTree/;"
        "mkdir /users/jtan/scratch/jtan/1ststep/dsx/GenesTrees/{wildcards.gene}GTree/;"
        "raxmlHPC -d -s {wildcards.gene}Gtrimmedfas.aln -n {wildcards.gene}GTree -m GTRGAMMA -x 10 -p 10 -# autoMR -f a -o Dmel_Female -w /users/jtan/scratch/jtan/1ststep/dsx/GenesTrees/{wildcards.gene}GTree/"

rule ProteinAlignmentClustal:
    input:
        "{gene}P.fasta"
    output:
        "ProteinsAlignments/{gene}Pclus.aln"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "source /dcsrsoft/spack/bin/setup_dcsrsoft;"
        "module load gcc/8.3.0;"
        "module load mafft/7.453;"
        "mafft --maxiterate 100 --globalpair --clustalout {input} > GenesAlignments/{wildcards.gene}Pclus.aln;"

rule ProteinAlignmentFasta:
    input:
        "{gene}P.fasta"
        "ProteinsAlignments/{gene}Pfas.aln"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "source /dcsrsoft/spack/bin/setup_dcsrsoft;"
        "module load gcc/8.3.0;"
        "module load mafft/7.453;"
        "mafft --maxiterate 100 --globalpair {input} > GenesAlignments/{wildcards.gene}Pclus.aln;"

rule ProteinAlignmentTrimmed:
    input:
        "ProteinsAlignments/{gene}Pfas.aln"
    output:
        "ProteinsAlignmentsTrimmed/{gene}Ptrimmedfas.aln",
        "ProteinsAlignmentsTrimmed/{gene}Ptrimmedfas.html"
    threads: 8
    resources:
        runtime_s = 3600,
        mem_mb = 6000
    shell:
        "module load Bioinformatics/Software/vital-it;"
        "module add SequenceAnalysis/Filtering/trimAl/1.4.1;"
        "module load SequenceAnalysis/Filtering/trimAl/1.4.1;"
        "trimal -in {input} -out {wildcards.gene}Ptrimmedfas.aln -htmlout {wildcards.gene}Ptrimmedfas.html -automated1;"
        "mv *trimmed* /users/jtan/scratch/jtan/1ststep/dsx/ProteinsAlignmentsTrimmed/;"
        "cd ..;"

rule ProteinTree:
    input:
        "ProteinsAlignmentsTrimmed/{gene}Ptrimmedfas.aln"
    output:
        "ProteinsTrees/{gene}PTree/RAxML_bestTree.{gene}PTree",
        "ProteinsTrees/{gene}PTree/RAxML_bipartitions.{gene}PTree",
        "ProteinsTrees/{gene}PTree/RAxML_bipartitionsBranchLabels.{gene}PTree",
        "ProteinsTrees/{gene}PTree/RAxML_bootstrap.{gene}PTree",
        "ProteinsTrees/{gene}PTree/RAxML_info.{gene}PTree"
    threads: 8
    resources:
        runtime_s = 36000,
        mem_mb = 12000
    shell:
        "cd ProteinsAlignmentsTrimmed;"
        "module load Bioinformatics/Software/vital-it;"
        "module add Phylogeny/raxml/8.2.12;"
        "module load Phylogeny/raxml/8.2.12;"
        "rm -r /users/jtan/scratch/jtan/1ststep/dsx/ProteinsTrees/{wildcards.gene}PTree/;"
        "mkdir /users/jtan/scratch/jtan/1ststep/dsx/ProteinsTrees/{wildcards.gene}PTree/;"
        "raxmlHPC -d -s {wildcards.gene}Ptrimmedfas.aln -n {wildcards.gene}PTree -m PROTGAMMAJTTF -x 10 -p 10 -# autoMR -f a -o Dmel_Female -w /users/jtan/scratch/jtan/1ststep/dsx/ProteinsTrees/{wildcards.gene}PTree/;"