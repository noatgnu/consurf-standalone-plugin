#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CONSURF_CONSERVATION } from './modules/local/consurf-conservation/main'

workflow PIPELINE {
    main:
    CONSURF_CONSERVATION (
        params.query_sequence ? Channel.fromPath(params.query_sequence).collect() : Channel.of([]),
        params.fasta_database ? Channel.fromPath(params.fasta_database).collect() : Channel.of([]),
        Channel.value(params.algorithm ?: ''),
        Channel.value(params.max_homologs ?: ''),
        Channel.value(params.substitution_model ?: ''),
        Channel.value(params.max_id ?: ''),
        Channel.value(params.min_id ?: ''),
        Channel.value(params.cutoff ?: ''),
        Channel.value(params.max_iterations ?: ''),
        Channel.value(params.maximum_likelihood ?: ''),
        Channel.value(params.closest ?: ''),
        params.msa_file ? Channel.fromPath(params.msa_file).collect() : Channel.of([]),
        Channel.value(params.alignment_program ?: ''),
        params.structure_file ? Channel.fromPath(params.structure_file).collect() : Channel.of([]),
        Channel.value(params.chain ?: ''),
        Channel.value(params.query_name ?: ''),
    )
}

workflow {
    PIPELINE ()
}
