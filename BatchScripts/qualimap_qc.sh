#!/bin/sh

#SBATCH --job-name=qualimap
#SBATCH --partition=highmem
#SBATCH --account=da494
#SBATCH --cpus-per-task=20
#SBATCH --time 72:00:00


module load bioconda ### load bioconda 

conda activate project_env ### Load conda environment with qualimap installed!

###NOTE -this directory must exist first.

cd /storage/mrbell/qc_qualimap/MultiSample

export _JAVA_OPTIONS="-Djava.io.tmpdir=./tmp -Xmx6G"

for bam in /storage/mrbell/aligned_BAMs/MultiSample/*_Aligned.sortedByCoord.out.bam
do
   echo $bam
   OUT=$(basename $bam .bam)
   if [ ! -d "${OUT}" ]
   then
      mkdir "${OUT}"
   fi
   qualimap rnaseq -bam /storage/mrbell/aligned_BAMs/MultiSample/${OUT}.bam \
   -gtf /storage/mrbell/Genomes/Mouse/Genome/Mus_musculus.GRCm39.107.gtf \
   -outdir /storage/mrbell/qc_qualimap/MultiSample/${OUT} \
   -p non-strand-specific \
   --java-mem-size=80G \
   -a proportional 
done
