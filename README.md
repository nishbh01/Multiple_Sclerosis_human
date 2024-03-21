# Multiple_Sclerosis_human

This repository will create a pipeline for quality control of progressive vs normal-appearing multiple sclerosis lesions. It will first trim the low quality reads then map the read to reference transcriptome (human, grch38) then annotate and count the features. Finally, it will save the the gene count matrix for differential gene expression analysis.

Tools used: Fastqc, Trimmomatic, Salmon (HISAT, just for fun), SAM and BAMtools, FeatureCounts, and DESeq.
