library(tercen)
library(dplyr)
library(scran)

ctx <- tercenCtx()

direction <- as.character(ctx$op.value('direction'))
log_fold_change_threshold <- as.numeric(ctx$op.value('log_fold_change_threshold'))

logged_count_matrix <- ctx$as.matrix()

clusters <- ctx$cselect()[[1]]

markers_detected <- findMarkers(logged_count_matrix,
                                clusters,
                                direction = direction,
                                lfc = log_fold_change_threshold)

output_frame <- lapply(names(markers_detected),
                       function(x) markers_detected[[x]] %>%
                         as_tibble(rownames = ".ri") %>%
                         mutate(cluster = x,
                                .ri = as.integer(.ri) - 1) %>%
                         select(marker_for_cluster = cluster, .ri, Top, FDR)) %>%
  bind_rows()

ctx$addNamespace(output_frame) %>%
  ctx$save()

