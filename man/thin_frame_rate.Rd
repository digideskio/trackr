% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/non-dplyr_verbs.R
\name{thin_frame_rate}
\alias{thin_frame_rate}
\title{Thin the stored frame rate of a tracks object}
\usage{
thin_frame_rate(tracks, n = NULL, new_frame_rate = NULL, drop = FALSE)
}
\arguments{
\item{tracks}{Tracks object.}

\item{n}{Thinning interval, every n frames is dropped.}

\item{new_frame_rate}{New frame rate.}

\item{drop}{When FALSE, an error will produced if data is found that was
aggregated over frames. If TRUE, that data will be dropped.}
}
\value{
Tracks object.
}
\description{
This function reduces the effective frame rate by dropping every n frame,
recoding the frame variable in $tr, $soc and $group and adjusts the
frame_rate parameter. Useful for reducing the size of a tracks object. Supply
either n or new_frame_rate.
}

