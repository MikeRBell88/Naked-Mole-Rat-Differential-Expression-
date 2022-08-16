#!/bin/sh

#SBATCH --job-name=star_genome_index
#SBATCH --partition=compute
#SBATCH --account=da494
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=8000
#SBATCH --time 12:00:00


module load bioconda ### loads bioconda module 

conda activate project_env ### activates project environment 

### performs generation of star index with the mouse genome and annotation files
STAR --runMode genomeGenerate \
--genomeDir /storage/mrbell/Genomes/Mouse/Genome/StarIndex \
--genomeFastaFiles /storage/mrbell/Genomes/Mouse/Genome/Mus_musculus.GRCm39.dna_sm.primary_assembly.fa \
--sjdbGTFfile /storage/mrbell/Genomes/Mouse/Genome/Mus_musculus.GRCm39.107.gtf

