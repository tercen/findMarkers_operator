suppressPackageStartupMessages(expr = {
  library(tercen)
  library(dplyr)
  library(scran) 
})

ctx <- tercenCtx()

direction <- as.character(ctx$op.value('direction'))
log_fold_change_threshold <- as.numeric(ctx$op.value('log_fold_change_threshold'))
comparison_to_make <- as.character(ctx$op.value('comparison_to_make'))

logged_count_matrix <- ctx$as.matrix()

clusters <- ctx$cselect()[[1]]

markers_detected <- findMarkers(
  logged_count_matrix,
  clusters,
  direction = direction,
  lfc = log_fold_change_threshold,
  pval.type = comparison_to_make
)

output_frame <- lapply(
  names(markers_detected), function(x) {
    
     to_return <- markers_detected[[x]] %>%
       as_tibble(rownames = ".ri") %>%
       mutate(cluster = x,
              .ri = as.integer(.ri) - 1)
     
     if (comparison_to_make == "any") {
       
       to_return <- to_return %>%
         select(marker_for_cluster = cluster, .ri, Top, FDR)
       
     } else if (comparison_to_make == "all") {
       
       to_return <- to_return %>%
         select(marker_for_cluster = cluster, .ri, FDR)
       
     }
     
     return(to_return)
     
}) %>%
  bind_rows()


ctx$addNamespace(output_frame) %>%
  ctx$save()