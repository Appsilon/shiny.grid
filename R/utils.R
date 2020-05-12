#' Generates a simple one attribute css rule for a given ID.
#' Mostly used to generate css grid rules.
#'
#' @param id CSS rule target id
#' @param attribute Attribute to change
#' @param value Value of the attribute
#'
#' @return A valid CSS string.
generateRule <- function(id, attribute, value) {
  paste0(
    "#", id, "{",
    attribute, ": ", value, ";",
    "}"
  )
}

#' Used to generate css row and column value strings.
#' Used mostly to fill in css attributes when no argument is defined.
#'
#' @param options the number of elements in the grid attribute
#'
#' @return A valid CSS string.
repeatRule<- function(options) {
  paste0("repeat(", length(options), ", 1fr)")
}

#' Extracts the unique values of a area type argument.
#'
#' @param options The list of elements to scan
#'
#' @importFrom stringi stri_remove_empty
#' @return A character vector.
uniqueCols <- function(options) {
  stri_remove_empty(
    unlist(strsplit(options[1], split=" "))
  )
}

#' Compiles a CSS media rule template according to the given options.
#' Mostly used to generate media queries for diferent breakpoints.
#'
#' @param options The list of media rule options
#'
#' @return A valid CSS media rule template string.
getRuleWrapper <- function(options) {
  if (is.null(options$min) && is.null(options$max))
    return ("{rules}")

  wrapper <- "@media all "

  if( !is.null(options$min))
    wrapper <- paste0(wrapper, "and (min-width:", options$min, "px) ")

  if( !is.null(options$max))
    wrapper <- paste0(wrapper, "and (max-width:", options$max, "px) ")

  return (paste0(wrapper, "{{", " {rules} ", "}} "))
}
