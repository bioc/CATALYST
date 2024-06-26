% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotPbExprs.R
\name{plotPbExprs}
\alias{plotPbExprs}
\title{Pseudobulk-level boxplot}
\usage{
plotPbExprs(
  x,
  k = "meta20",
  features = "state",
  assay = "exprs",
  fun = c("median", "mean", "sum"),
  facet_by = c("antigen", "cluster_id"),
  color_by = "condition",
  group_by = color_by,
  shape_by = NULL,
  size_by = FALSE,
  geom = c("both", "points", "boxes"),
  jitter = TRUE,
  ncol = NULL
)
}
\arguments{
\item{x}{a \code{\link{SingleCellExperiment}{SingleCellExperiment}}.}

\item{k}{character string specifying which clustering to use;
values values are \code{names(cluster_codes(x))}.
Ignored if \code{facet_by = "antigen"}.}

\item{features}{character vector specifying 
which features to include; valid values are 
\code{"type"/"state"} for \code{type/state_markers(x)} 
if \code{rowData(x)$marker_class} have been specified; 
a subset of \code{rownames(x)}; NULL to use all features.}

\item{assay}{character string specifying which assay data 
to use; valid values are \code{assayNames(x)}.}

\item{fun}{character string specifying the summary statistic to use.}

\item{facet_by}{\code{"antigen"} or \code{"cluster_id"}; 
the latter requires having run \code{\link{cluster}}.}

\item{color_by, group_by, shape_by}{character string specifying a non-numeric cell metadata variable 
to color, group and shape by, respectively; valid values are 
\code{names(colData(x))} and \code{names(cluster_codes(x))} 
if \code{\link{cluster}} has been run.}

\item{size_by}{logical specifying whether to scale point sizes by
the number of cells in a given sample or cluster-sample instance;
ignored when \code{geom = "boxes"}.}

\item{geom}{character string specifying whether 
to include only points, boxplots or both.}

\item{jitter}{logical specifying whether to use \code{position_jitterdodge}
in \code{geom_point} when \code{geom != "boxes"}.}

\item{ncol}{integer scalar specifying number of facet columns.}
}
\value{
a \code{ggplot} object.
}
\description{
Boxplot of aggregated marker data by sample or cluster, optionally 
colored and faceted by non-numeric cell metadata variables of interest.
}
\examples{
# construct SCE
data(PBMC_fs, PBMC_panel, PBMC_md)
sce <- prepData(PBMC_fs, PBMC_panel, PBMC_md)
sce <- cluster(sce, verbose = FALSE)

# plot median expressions by sample & condition
# ...split by marker
plotPbExprs(sce, 
  shape_by = "patient_id",
  features = sample(rownames(sce), 6))

# ...split by cluster
plotPbExprs(sce, facet_by = "cluster_id", k = "meta6")

# plot median type-marker expressions by sample & cluster
plotPbExprs(sce, feature = "type", k = "meta6", 
  facet_by = "antigen", group_by = "cluster_id", color_by = "sample_id",
  size_by = TRUE, geom = "points", jitter = FALSE, ncol = 5)
  
# plot median state-marker expressions 
# by sample & cluster, split by condition
plotPbExprs(sce, k = "meta6", facet_by = "antigen", 
  group_by = "cluster_id", color_by = "condition", ncol = 7)

}
\references{
Nowicka M, Krieg C, Crowell HL, Weber LM et al. 
CyTOF workflow: Differential discovery in 
high-throughput high-dimensional cytometry datasets.
\emph{F1000Research} 2017, 6:748 (doi: 10.12688/f1000research.11622.1)
}
\author{
Helena L Crowell \email{helena.crowell@uzh.ch}
}
