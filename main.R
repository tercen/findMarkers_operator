library(tercen)
library(dplyr)
library(scran)

ctx <- tercenCtx()

cluster_to_evaluate <- as.integer(ctx$op.value('cluster_to_evaluate'))
top_genes <- as.integer(ctx$op.value('top_genes'))

logged_count_matrix <- ctx$as.matrix()
rownames(logged_count_matrix) <- ctx$rselect()[[1]]

clusters <- ctx$cselect()[[1]]

markers_detected <- findMarkers(logged_count_matrix, clusters)

genes_to_select <- markers_detected[[cluster_to_evaluate]] %>%
  as_tibble(rownames = "gene_id") %>%
  dplyr::filter(Top <= top_genes)

heatmap(genes_to_select %>%
          select(starts_with("log")) %>%
          as.matrix())

ctx$addNamespace() %>%
  ctx$save()