suppressPackageStartupMessages(expr = {
  library(Seurat)
  library(tidyr)
  library(dplyr)
  library(tercen)
})

source("./utils.R")

ctx = tercenCtx()

obj <- as_Seurat(ctx)
col_factor <- ctx$colors[[1]]
col_map <- ctx$select(c(".ci", ".colorLevels", col_factor)) %>% unique
obj@meta.data <- obj@meta.data %>% bind_cols(col_map)

method <- ctx$op.value("method", as.character, "wilcox")
logfc.threshold <- ctx$op.value("log_fold_change_threshold", as.double, 0)

df_markers <- lapply(unique(col_map[[col_factor]]), function(col) {
  df <- FindMarkers(
    obj,
    ident.1 = col,
    group.by = col_factor,
    test.use = method,
    logfc.threshold = logfc.threshold,
    min.cells.group = 0,
    verbose = FALSE
  )
  df$focal_group <- col
  df$.ri <- rownames(df)
  df
}) %>%
  do.call(rbind, .) %>%
  mutate(.ri = as.integer(.ri)) %>%
  ctx$addNamespace() %>%
  ctx$save()
