# scRNA-seq cluster marker gene detection operator

##### Description
`scRNA-seq cluster marker gene detection` identifies the genes that are markers for previously-identified clusters in single-cell RNA-seq data.

##### Usage

Input projection| Description
---|---
`y-axis`              | numeric, logged and normalised count data, per cell 
`column names, top`   | character, cluster ID
`column names, bottom`| character, cell ID
`row names`           | character, gene ID

| Input parameters | Description                                                                                 |
| -----------------| ------------------------------------------------------------------------------------------- |
| `direction       | "any, "up" or "down", adjusted _p value_ cutoff for independent filtering (default = "any") |
| `LFC_shrinkage`  | Numeric, log-fold change threshold to be tested against (default = 0).                      |

Output relations| Description
---|---
`marker_for_cluster` | character, the cluster for which the markers were assayed
`Top`                | numeric, the minimum rank across all pairwise comparisons between the cluster assayed and all others
`FDR`                | numeric, the Benjamini-Hochberg adjusted p-value for each gene and assayed cluster

##### Details
The output relations allow the user to select marker genes for each cluster according to their preferred criteria and thresholds.

The operator uses the normalisation worklfow described in the corresponding chapter of the ["Orchestrating Single-Cell Analysis"](https://osca.bioconductor.org/normalization.html) book. For this it uses the _scran_ BioConductor package.

#### References
Amezquita, et. al. ["Orchestrating single-cell analysis with BioConductor"](https://www.nature.com/articles/s41592-019-0654-x), Nature Methods (2019)

##### See Also

#### Examples
