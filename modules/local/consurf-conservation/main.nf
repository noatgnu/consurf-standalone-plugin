process CONSURF_CONSERVATION {
    label 'process_medium'

    container "${ workflow.containerEngine == 'singularity' ?
        'docker://noatgnu/consurf-alone:0.0.2' :
        'noatgnu/consurf-alone:0.0.2' }"

    input:
    path query_sequence
    path fasta_database
    val algorithm
    val max_homologs
    val substitution_model
    val max_id
    val min_id
    val cutoff
    val max_iterations
    val maximum_likelihood
    val closest
    path msa_file
    val alignment_program
    path structure_file
    val chain
    val query_name

    output:
    
    path "Consurf_Outputs.zip", emit: consurf_outputs, optional: true
    path "*_consurf_grades.txt", emit: conservation_grades, optional: true
    path "msa_aa_variety_percentage.csv", emit: msa_variety, optional: true
    path "query.fasta", emit: query_copy, optional: true
    path "versions.yml", emit: versions

    script:
    def args = task.ext.args ?: ''
    """
    # Build arguments dynamically to match CauldronGO PluginExecutor logic
    ARG_LIST=()

    
    # Mapping for cutoff
    VAL="$cutoff"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--cutoff" "\$VAL")
    fi
    
    # Mapping for query_name
    VAL="$query_name"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--query" "\$VAL")
    fi
    
    # Mapping for structure_file
    VAL="$structure_file"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--structure" "\$VAL")
    fi
    
    # Mapping for algorithm
    VAL="$algorithm"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--algorithm" "\$VAL")
    fi
    
    # Mapping for min_id
    VAL="$min_id"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--MIN_ID" "\$VAL")
    fi
    
    # Mapping for closest
    VAL="$closest"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        if [ "\$VAL" = "true" ]; then
            ARG_LIST+=("--closest")
        fi
    fi
    
    # Mapping for query_sequence
    VAL="$query_sequence"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--seq" "\$VAL")
    fi
    
    # Mapping for fasta_database
    VAL="$fasta_database"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--DB" "\$VAL")
    fi
    
    # Mapping for max_id
    VAL="$max_id"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--MAX_ID" "\$VAL")
    fi
    
    # Mapping for msa_file
    VAL="$msa_file"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--msa" "\$VAL")
    fi
    
    # Mapping for max_homologs
    VAL="$max_homologs"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--MAX_HOMOLOGS" "\$VAL")
    fi
    
    # Mapping for substitution_model
    VAL="$substitution_model"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--model" "\$VAL")
    fi
    
    # Mapping for max_iterations
    VAL="$max_iterations"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--iterations" "\$VAL")
    fi
    
    # Mapping for maximum_likelihood
    VAL="$maximum_likelihood"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        if [ "\$VAL" = "true" ]; then
            ARG_LIST+=("--Maximum_Likelihood")
        fi
    fi
    
    # Mapping for alignment_program
    VAL="$alignment_program"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--align" "\$VAL")
    fi
    
    # Mapping for chain
    VAL="$chain"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--chain" "\$VAL")
    fi
    
    /opt/miniconda/bin/conda run -n consurf_env --no-capture-output python /workspace/stand_alone_consurf/stand_alone_consurf.py \
        "\${ARG_LIST[@]}" \
        --dir . \
        \${args:-}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        ConSurf Conservation Analysis: 1.0.0
    END_VERSIONS
    """
}
