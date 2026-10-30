#!/bin/bash

# --- Cache Directory ---
export NXF_APPTAINER_CACHEDIR=/data/rubem/jenny/apptainer_cache
export NXF_SINGULARITY_CACHEDIR=/data/rubem/jenny/apptainer_cache

# --- Bind Mount ---
export NXF_APPTAINER_BINDPATH=/data
export NXF_SINGULARITY_BINDPATH=/data

# --- Pull Timeout ---
export NXF_APPTAINER_PULL_TIMEOUT=120m
export NXF_SINGULARITY_PULL_TIMEOUT=120m

mkdir -p /data/rubem/jenny/apptainer_cache

nextflow run \
    nf-core/circrna -r dev \
    --input HUJBB_117_samplesheet.csv \
    --outdir results \
    --fasta /data/jenny/reference/GRCh38.primary_assembly.genome.fa \
    --gtf /data/jenny/reference/gencode.v49.annotation.gtf \
    --save_reference \
    --tools 'ciri,circexplorer2' \
    --bsj_reads 2 \
    --min_tools 2 \
    --consider_strand \
    --min_samples 5 \
    --max_shift 1 \
    --exons_only \
    --quantification_tools 'psirc' \
    --bootstrap_samples 30 \
    --sjdboverhang 74 \
    --chimJunctionOverhangMin 10 \
    --alignSJDBoverhangMin 10 \
    --chimSegmentMin 10 \
    --min_intron 20 \
    --max_intron 1000000 \
    -profile singularity \
    -c avx_fix.config \
    -resume
