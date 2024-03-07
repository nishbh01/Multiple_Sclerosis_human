#!/bin/bash

# indexing transcriptome

salmon index -t ./gencode.v45.transcripts.fa.gz -i transcriptome_index --gencode
# Path to the indexed transcriptome directory
transcriptome_index="./transcriptome_index"


for file in *fastq; do
    sample_name=$(basename "${file%.*}")

    echo "Processing sample ${sample_name}"

    salmon quant -i "${transcriptome_index}" \
                 -l U \
                 -r "${file}" \
                 -p 8 \
                 --validateMappings \
                 -o "quant_results_${sample_name}"
done