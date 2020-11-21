library(tercen)
library(dplyr)
library(scran)

ctx <- tercenCtx()

logged_count_matrix <- ctx$as.matrix()

clusters <- ctx$cselect()[[1]]

markers_detected <- findMarkers(logged_count_matrix, clusters)

output_frame <- lapply(names(markers_detected),
                       function(x) markers_detected[[x]] %>%
                         as_tibble(rownames = ".ri") %>%
                         mutate(cluster = x,
                                .ri = as.integer(.ri) - 1) %>%
                         select(cluster, .ri, FDR)) %>%
  bind_rows()

ctx$addNamespace(output_frame) %>%
  ctx$save()

