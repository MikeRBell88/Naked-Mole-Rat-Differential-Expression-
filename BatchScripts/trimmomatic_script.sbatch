#!/bin/bash
#SBATCH --job-name=Trimmomatic
#SBATCH --account=da494
#SBATCH --partition=compute
#SBATCH --cpus-per-task=20
#SBATCH --mem=8G              
#SBATCH --time=48:00:00

DIRECTORY=/storage/mrbell ### directory for location of the adapt_combined.fa file 
INPUT=/storage/mrbell/Genomes/SRAdata ### directory for input of fastq files
OUTPUT=/storage/mrbell/Trimmomatic/TrimOut ### directory for output of trimmomatic 

cd /storage/mrbell/Genomes/SRAdata ### change the directory to location of the fastq files 

module purge ### purge environment 

module load bioconda ### load bioconda 

conda activate project_env ### load project environment with trimmomatic already installed 

### takes each fastq.gz file uses name of file for outfile, performs trimmomatic and outputs trimmed fastq.gz file
for infile in *.fastq.gz
do
   outfile=${infile}_trim.fastq.gz
   trimmomatic SE -threads ${SLURM_CPUS_PER_TASK} \
   -phred33 \
   ${INPUT}/${infile} \
   ${OUTPUT}/${outfile} \
   ILLUMINACLIP:${DIRECTORY}/adapt_combined.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
