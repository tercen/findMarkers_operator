library(tercen)
library(dplyr)
library(tidyr)
library(scran)

options("tercen.workflowId" = "f6d7883d26d906b1a8c4a3800d0616d4")
options("tercen.stepId"     = "851a7d4e-dc7d-4bbb-8d28-6615d23ec1d2")

getOption("tercen.workflowId")
getOption("tercen.stepId")

cluster_to_evaluate <- 5
top_genes <- 20

ctx <- tercenCtx()

#cluster_to_evaluate <- as.integer(ctx$op.value('cluster_to_evaluate'))
#top_genes <- as.integer(ctx$op.value('top_genes'))

logged_count_matrix <- ctx$as.matrix()
rownames(logged_count_matrix) <- ctx$rselect()[[1]]

clusters <- ctx$cselect()[[1]]

markers_detected <- findMarkers(logged_count_matrix, clusters)

genes_to_select <- markers_detected[[cluster_to_evaluate]] %>%
  as_tibble(rownames = "gene_id") %>%
  dplyr::filter(Top <= top_genes)

output_frame <- genes_to_select %>%
  pivot_longer(c(starts_with("logFC")),
               names_to = "comparison",
               values_to = "logFC") %>%
  select(-Top, -p.value, -FDR)

ctx$addNamespace() %>%
  ctx$save()