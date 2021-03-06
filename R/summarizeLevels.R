#' @title Summarizes factors of a data.frame by tabling them.
#'
#' @description
#' Characters and logicals will be treated as factors.
#'
#' @template arg_taskdf
#' @param cols [\code{character}]\cr
#'   Restrict result to columns in \code{cols}.
#'   Default is all factor, character and logical columns of \code{obj}.
#' @return [\code{list}]. Named list of tables.
#' @export
#' @family eda_and_preprocess
#' summarizeLevels(iris)
summarizeLevels = function(obj, cols = NULL) {
  UseMethod("summarizeLevels")
}

#' @export
summarizeLevels.Task = function(obj, cols = NULL) {
  summarizeLevels.data.frame(obj$env$data, cols = cols)
}

#' @export
summarizeLevels.data.frame = function(obj, cols = NULL) {
  pred = function(x) is.factor(x) || is.logical(x) || is.character(x)
  cns = colnames(obj)[vlapply(obj, pred)]
  if (!is.null(cols)) {
    assertSubset(cols, cns)
    cns = intersect(cns, cols)
  }
  lapply(obj[cns], function(x) table(as.factor(x)))
}
