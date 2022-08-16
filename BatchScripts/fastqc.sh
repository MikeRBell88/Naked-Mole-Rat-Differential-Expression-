#!/bin/sh
#
#SBATCH --job-name=FastQC
#SBATCH --account=da494
#SBATCH --partition=compute

#SBATCH --cpus-per-task=16                
#SBATCH --mem 8G
#SBATCH --time=24:00:00 

FASTQC=~/.conda/envs/project_env/bin/fastqc ### define FASTQC package directory
DIRECTORY=/storage/mrbell/FastQC ### define FASTQC output directory 
INPUT=/storage/mrbell/Genomes/SRAdata ###define FASTQ input directory 
OUTPUT=/storage/mrbell/FastQCout/NMRraw ### define FASTQC output directory 

module purge ### purge environment and start with zero modules loaded 

module load bioconda ### load bioconda 

conda deactivate   ### deactivate conda environments 

conda activate project_env   ### load project environment 

module load openjdk/jdk-17.0.2 ### load java 

${FASTQC} ${INPUT}/*.fastq.gz --outdir ${OUTPUT} ### calling FASTQC on all fastq.gz files in directory 

