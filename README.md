# ConSurf Conservation Analysis


## Installation

**[⬇️ Click here to install in Cauldron](http://localhost:50060/install?repo=https%3A%2F%2Fgithub.com%2Fnoatgnu%2Fconsurf-standalone-plugin)** _(requires Cauldron to be running)_

> **Repository**: `https://github.com/noatgnu/consurf-standalone-plugin`

**Manual installation:**

1. Open Cauldron
2. Go to **Plugins** → **Install from Repository**
3. Paste: `https://github.com/noatgnu/consurf-standalone-plugin`
4. Click **Install**

**ID**: `consurf-conservation`  
**Version**: 1.0.0  
**Category**: analysis  
**Author**: Toan Phung

## Description

Protein sequence conservation analysis using ConSurf standalone. Identifies conserved and variable regions in protein sequences based on homology search and multiple sequence alignment.

## Runtime

- **Environments**: `docker`

- **Entrypoint**: `/opt/miniconda/bin/conda run -n consurf_env --no-capture-output python /workspace/stand_alone_consurf/stand_alone_consurf.py`

## Inputs

| Name | Label | Type | Required | Default | Visibility |
|------|-------|------|----------|---------|------------|
| `query_sequence` | Query Protein Sequence | file | Yes | - | Always visible |
| `fasta_database` | Protein FASTA Database | file | Yes | - | Always visible |
| `algorithm` | Homolog Search Algorithm | select (HMMER, BLAST) | Yes | HMMER | Always visible |
| `max_homologs` | Maximum Homologs | number (min: 10, max: 500, step: 10) | Yes | 150 | Always visible |
| `substitution_model` | Substitution Model | select (BEST, JTT, LG, WAG, cpREV, mtREV, Dayhoff) | Yes | BEST | Always visible |
| `max_id` | Maximum Sequence Identity (%) | number (min: 50, max: 100, step: 5) | Yes | 95 | Always visible |
| `min_id` | Minimum Sequence Identity (%) | number (min: 1, max: 50, step: 5) | Yes | 35 | Always visible |
| `cutoff` | E-value Cutoff | number (min: 0, max: 1, step: 0) | Yes | 0.0001 | Always visible |
| `max_iterations` | Maximum Iterations | number (min: 1, max: 5, step: 1) | Yes | 1 | Always visible |
| `maximum_likelihood` | Use Maximum Likelihood | boolean | No | false | Always visible |
| `closest` | Use Closest Homologs Only | boolean | No | false | Always visible |
| `msa_file` | Multiple Sequence Alignment (Optional) | file | No | - | Always visible |
| `alignment_program` | Alignment Program | select (MAFFT, MUSCLE, CLUSTALW) | No | - | Always visible |
| `structure_file` | PDB Structure File (Optional) | file | No | - | Always visible |
| `chain` | PDB Chain ID | text | No | - | Always visible |
| `query_name` | Query Sequence Name | text | No | - | Always visible |

### Input Details

#### Query Protein Sequence (`query_sequence`)

Protein sequence in FASTA format for conservation analysis


#### Protein FASTA Database (`fasta_database`)

Database of protein sequences for homolog search (e.g., UniRef90, UniProt)


#### Homolog Search Algorithm (`algorithm`)

Algorithm for searching homologous sequences

- **Options**: `HMMER`, `BLAST`

#### Maximum Homologs (`max_homologs`)

Maximum number of homologous sequences to include in MSA


#### Substitution Model (`substitution_model`)

Amino acid substitution model for conservation calculation

- **Options**: `BEST`, `JTT`, `LG`, `WAG`, `cpREV`, `mtREV`, `Dayhoff`

#### Maximum Sequence Identity (%) (`max_id`)

Maximum sequence identity threshold for homolog filtering


#### Minimum Sequence Identity (%) (`min_id`)

Minimum sequence identity threshold for homolog filtering


#### E-value Cutoff (`cutoff`)

E-value threshold for homolog search significance


#### Maximum Iterations (`max_iterations`)

Number of PSI-BLAST iterations (if BLAST selected)


#### Use Maximum Likelihood (`maximum_likelihood`)

Use maximum likelihood method for rate calculation (slower but more accurate)


#### Use Closest Homologs Only (`closest`)

Select only the closest homologs based on similarity


#### Multiple Sequence Alignment (Optional) (`msa_file`)

Pre-computed MSA file. If provided, skips homolog search and alignment steps


#### Alignment Program (`alignment_program`)

Program for multiple sequence alignment (used if MSA not provided)

- **Options**: `MAFFT`, `MUSCLE`, `CLUSTALW`

#### PDB Structure File (Optional) (`structure_file`)

Protein structure file for mapping conservation to 3D structure


#### PDB Chain ID (`chain`)

Chain identifier in PDB file (e.g., A, B, C)

- **Placeholder**: `A`

#### Query Sequence Name (`query_name`)

Custom name for the query sequence in outputs

- **Placeholder**: `MyProtein`

## Outputs

| Name | File | Type | Format | Description |
|------|------|------|--------|-------------|
| `consurf_outputs` | `Consurf_Outputs.zip` | data | zip | Complete ConSurf analysis results archive |
| `conservation_grades` | `*_consurf_grades.txt` | data | txt | Per-residue conservation grades and scores |
| `msa_variety` | `msa_aa_variety_percentage.csv` | data | csv | Amino acid variation percentage at each position in MSA |
| `query_copy` | `query.fasta` | data | fasta | Copy of input query sequence |

## Requirements

- **Python Version**: >=3.8

## Example Data

This plugin includes example data for testing:

```yaml
  fasta_database: example/small_database.fasta
  max_homologs: 50
  substitution_model: BEST
  max_id: 95
  min_id: 35
  cutoff: 0.0001
  maximum_likelihood: false
  query_sequence: example/query.fasta
  algorithm: HMMER
  max_iterations: 1
```

Load example data by clicking the **Load Example** button in the UI.

## Usage

### Via UI

1. Navigate to **analysis** → **ConSurf Conservation Analysis**
2. Fill in the required inputs
3. Click **Run Analysis**

### Via Plugin System

```typescript
const jobId = await pluginService.executePlugin('consurf-conservation', {
  // Add parameters here
});
```
