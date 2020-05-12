#' Default breakpoints (Based on bootstrap specification)
defaultMediaRules <- list(
  xs = list(max = 575),
  sm = list(min = 576, max = 767),
  md = list(min = 768, max = 991),
  lg = list(min = 992, max = 1199),
  xl = list(min = 1200)
)
#' Currently usable breakpoints
activeMediaRules <- defaultMediaRules

#' Removes a media rule from the active list.
#'
#' @param name The identifier name for the rule
#'
#' @family MediaRules
#' @seealso [registerMediaRule()]
#'
#' @param name Name of the media rule to remove#'
#'
#' @export
unregisterMediaRule <- function(name) {
  activeMediaRules[[name]] = NULL
}

#' Adds a media rule from the active list. Used to create cusotm breakpoints
#'
#' @param name The identifier name for the rule
#' @param min The minium width of the media rule (in pixels)
#' @param max The maximum width of the media rule (in pixels)
#'
#' @family MediaRules
#' @seealso [unregisterMediaRule()]
#'
#' @param name Name of the media rule to remove
#'
#' @export
registerMediaRule <- function(name, min = NULL, max = NULL) {
  activeMediaRules[[name]] = list(
    min = min,
    max = max
  )
}
