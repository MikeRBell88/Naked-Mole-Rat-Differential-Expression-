#!/bin/sh

#SBATCH --job-name=star_alignment
#SBATCH --partition=compute
#SBATCH --account=da494
#SBATCH --cpus-per-task=20
#SBATCH --time 72:00:00

INPUT=/storage/mrbell/Trimmomatic/TrimOut
OUTPUT=/storage/mrbell/aligned_BAMs/MultiSample

module purge

module load bioconda
###AT load the conda environment with STAR installed.
conda activate project_env

###NOTE - for --outFileNamePrefix the directory "aligned_BAMs" must exist before you run the script.

### star alignment producing a bam file for each fastq file. 
for fastq in ${INPUT}/*_trim.fastq
do 
   echo $fastq
   OUT=$(basename $fastq _trim.fastq)
   STAR --runThreadN ${SLURM_CPUS_PER_TASK} \
   --genomeDir /storage/mrbell/Genomes/Mouse/Genome/StarIndex \
   --readFilesIn ${INPUT}/${OUT}_trim.fastq \
   --outFileNamePrefix ${OUTPUT}/${OUT}_ \
   --outSAMtype BAM SortedByCoordinate
done

