#!/bin/bash

SECONDS=0

# change working directory
cd /Users/nischal/Downloads/Multiple_Sclerosis_human/



# STEP 1: Run fastqc
fastqc .data/SRR23319405.fastq -o ./data/


# run trimmomatic to trim reads with poor quality

/Users/nischal/Downloads/Bioinformatics/Trimmomatic-0.39
java -jar /Users/nischal/Downloads/Bioinformatics/Trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 4 ./data/SRR23319405.fastq ./data/SRR23319405_trimmed.fastq TRAILING:10 -phred33
echo "Trimmomatic finished running!"

fastqc ./data/SRR23319405_trimmed.fastq -o ./data/


# STEP 2: Run HISAT2
# mkdir HISAT2
# get the genome indices
# wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz


# alignment to reference genome grch38
echo "running alignment with HISAT2" 
/Users/nischal/Downloads/Bioinformatics/hisat2/hisat2 -q --rna-strandness R -x /Users/nischal/Downloads/Bioinformatics/grch38/genome -U ./results/SRR23319405_trimmed.fastq | samtools sort -o ./data/SRR23319405_trimmed.bam
echo "HISAT2 finished running!"

# gene annotation

# STEP 3: Run featureCounts - Quantification



# get gtf
# wget http://ftp.ensembl.org/pub/release-106/gtf/homo_sapiens/Homo_sapiens.GRCh38.106.gtf.gz
echo "starting feature counts"
/Users/nischal/Downloads/Bioinformatics/subread-2.0.5-macOS-x86_64/bin/featureCounts -S 2 -a /Users/nischal/Downloads/Bioinformatics/Homo_sapiens.GRCh38.106.gtf -o ./results/SRR23319405_featurecounts.txt ./data/SRR23319405_trimmed.bam
echo "featureCounts finished running!"

cut -f1,7 ./data/SRR23319405_featurecounts.txt > ./data/gene_count_matrix.txt

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."