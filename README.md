# scRNA-seq - Find Markers

##### Description

`scRNA-seq - Find Markers` identifies genes that are differentialy expressed among clusters
in single cell RNA-seq data.

##### Usage

Input projection| Description
---|---
`y-axis`  | numeric, logged and normalised count data, per cell 
`colors`  | character, cluster ID
`columns` | character, cell ID
`rows`    | character, gene ID


##### Details

The operator uses the `Seurat` R package and the preprocessing workflow described in the ["package website"](https://satijalab.org/seurat/).

##### References

> Hao, Y., Hao, S., Andersen-Nissen, E., Mauck, W. M., Zheng, S., Butler, A., ... & Satija, R. (2021). Integrated analysis of multimodal single-cell data. Cell, 184(13), 3573-3587.

[Link to Seurat reference](https://doi.org/10.1016/j.cell.2021.04.048)
