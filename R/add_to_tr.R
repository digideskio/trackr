#' Conveniently add common new variables to the \code{tr} table.
#'
#' These functions are designed for use within \code{summarise_}, and will
#' compute common derived parameters for tracks. By default, these functions
#' will use the expected variable names, as are default in \code{tracks}
#' objects, but they can be overridden.
#'
#' @param x X-coordinate.
#' @param y Y-coordinate.
#' @param n Offset for change. See \code{\link[dplyr]{lag}}.
#' @param order_by This parameter controls the ordering of \code{dplyr::lag} and
#'   \code{dplyr::lead} and it is strongly advised to leave it at it's default
#'   (\code{frame}).
#' @param frame_rate All variables with a time dimension, will be calculated
#'   based on seconds (not frames). By default this is read from the tracks
#'   object.
#'
#' @name mutate_tr
#' @seealso mutate_soc mutate_.tracks
NULL

#' @rdname mutate_tr
#' @export
change <- function(x, order_by = frame,
                   frame_rate = tracks$params$frame_rate, n = 1) {
  ifelse(order_by - dplyr::lag(order_by, n = n, order_by = order_by) == n,
         x - dplyr::lag(x, n = n, order_by = order_by),
         NA)
}

#' @rdname mutate_tr
#' @export
speed <- function(x = X, y = Y, order_by = frame,
                  frame_rate = tracks$params$frame_rate) {
  sqrt(change(x, order_by, frame_rate) ^ 2 + change(y, order_by, frame_rate) ^ 2)
}

#' @rdname mutate_tr
#' @export
acceleration <- function(x = X, y = Y, order_by = frame,
                         frame_rate = tracks$params$frame_rate) {
  change(speed(y, x, order_by, frame_rate), order_by, frame_rate)
}

#' @rdname mutate_tr
#' @export
heading <- function(x = X, y = Y, order_by = frame) {
  ifelse(
    order_by - dplyr::lag(order_by, order_by = order_by) == 1,
    angle(dplyr::lag(x, order_by = order_by),
          dplyr::lag(y, order_by = order_by),
          x,
          y),
    NA)
}

#' @rdname mutate_tr
#' @export
angular_velocity <- function(x = X, y = Y, order_by = frame,
                             frame_rate = tracks$params$frame_rate) {
  change(heading(x, y, order_by), order_by) / frame_rate
}
