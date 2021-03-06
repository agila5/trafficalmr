% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osm_cleaning_functions.R
\name{line_segment_sf}
\alias{line_segment_sf}
\title{Break a line into segments}
\usage{
line_segment_sf(l, n_segments, segment_length = NA)
}
\arguments{
\item{l}{line}

\item{n_segments}{number of segments}

\item{segment_length}{segment length}
}
\value{
list
}
\description{
Break a line into segments
}
\details{
see stplanr::line_segment note: does not make perfect breaks
}
\seealso{
Other OSM: 
\code{\link{cluster_junction}()},
\code{\link{nn_line}()},
\code{\link{nn_point}()},
\code{\link{osm_consolidate}()},
\code{\link{osm_get_junctions}()},
\code{\link{osm_main_roads}()}
}
\concept{OSM}
