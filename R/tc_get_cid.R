#' Get traffic calming data from the Cycling Infrastructure Database (CID)
#'
#' This function gets data from the CID.
#' See  for more info.
#'
#'
#' @param type What type of CID data?
#' Options include "advanced_stop_line", "crossing", "cycle_lane_track" and
# "restricted_route"
#' @param tc_type What type of traffic calming intervention to get?
#' Options are `NULL` (the default, meaning all traffic calming interventions)
#' or "TRF_RAISED", "TRF_ENTRY", "TRF_CUSHI", "TRF_HUMP", "TRF_SINUSO",
# "TRF_BARIER", "TRF_NAROW" or "TRF_CALM" to get a specific type.
#' @param borough Which borough of London is of interest?
#' `NULL` (all boroughs) is the default.
#'
#' @return An sf object representing traffic calming interventions
#' @export
#' @examples
#' # cid_traffic_calming = tc_get_cid()
#' # summary(cid_traffic_calming)
#' #   FEATURE_ID            SVDATE           TRF_RAISED      TRF_ENTRY       TRF_CUSHI
#' # Length:58565       Min.   :2017-01-06   Mode :logical   Mode :logical   Mode :logical
#' # Class :character   1st Qu.:2017-08-13   FALSE:55793     FALSE:50984     FALSE:45939
#' # Mode  :character   Median :2017-10-19   TRUE :2772      TRUE :7581      TRUE :12626
#' # Mean   :2017-10-14
#' # 3rd Qu.:2017-12-15
#' # Max.   :2018-08-21
#' # TRF_HUMP       TRF_SINUSO      TRF_BARIER      TRF_NAROW        TRF_CALM
#' # Mode :logical   Mode :logical   Mode :logical   Mode :logical   Mode :logical
#' # FALSE:25294     FALSE:51845     FALSE:57630     FALSE:57903     FALSE:57844
#' # TRUE :33271     TRUE :6720      TRUE :935       TRUE :662       TRUE :721
#' #
#' #
#' #
#' # BOROUGH           PHOTO1_URL         PHOTO2_URL                 geometry
#' # Length:58565       Length:58565       Length:58565       POINT        :58565
#' # Class :character   Class :character   Class :character   epsg:4326    :    0
#' # Mode  :character   Mode  :character   Mode  :character   +proj=long...:    0
#' # cid_barriers = tc_get_cid(tc_type = "TRF_BARIER")
#' # summary(cid_barriers)
tc_get_cid = function(type = "traffic_calming", tc_type = NULL, borough = NULL) {
  # download CID traffic calming data using the Cycle Infra Lnd package

  base_url = "https://cycling.data.tfl.gov.uk/CyclingInfrastructure/data/points/"
  cid_url = paste0(base_url, type, ".json")
  traffic_calming = sf::read_sf(cid_url)

  # convert certain columns to factors for analysis
  # NB BOROUGH needs doing separately as it has some NAs in, CLT_ACCESS not converted as 721 different values
  # f_variables = c("TRF_RAISED", "TRF_ENTRY", "TRF_CUSHI", "TRF_HUMP", "TRF_SINUSO",
                  # "TRF_BARIER", "TRF_NAROW", "TRF_CALM")

  # f_traffic_calming = traffic_calming %>%
  #   # mutate_at(f_variables, as.factor)
  # f_traffic_calming$BOROUGH = factor(traffic_calming$BOROUGH, exclude = NULL)
  #
  # glimpse(f_traffic_calming) # check converted ok
  # levels(f_traffic_calming$BOROUGH) # have 33 and no NA value
  #
  # # select traffic calming measures

  traffic_calming[3:10] = lapply(sf::st_drop_geometry(traffic_calming[3:10]), as.logical)
  if(!is.null(borough)) {
    traffic_calming = traffic_calming[traffic_calming[["BOROUGH"]] == borough, ]
  }

  # select traffic calming barriers
  if(!is.null(type)) {
    traffic_calming = traffic_calming[traffic_calming[[tc_type]], ]
  }
  traffic_calming
}

# code from: https://github.com/PublicHealthDataGeek/CycleInfraLnd/blob/master/R/get_cid.R
#
# get_cid_lines(type = "advanced_stop_line")
# get_cid_lines(type = "crossing")
# get_cid_lines(type = "cycle_lane_track")
# get_cid_lines(type = "restricted_route")
# get_cid_lines = function(type) {
#   base_url = "https://cycling.data.tfl.gov.uk/CyclingInfrastructure/data/lines/"
#   cid_url = paste0(base_url, type, ".json")
#   sf::read_sf(cid_url)
# }

# get_cid_points(type = "signal")
# get_cid_points(type = "cycle_parking")
# get_cid_points(type = "restricted_point")
# get_cid_points(type = "signage")
# get_cid_points(type = "traffic_calming")
# get_cid_points = function(type) {
#   base_url = "https://cycling.data.tfl.gov.uk/CyclingInfrastructure/data/points/"
#   cid_url = paste0(base_url, type, ".json")
#   sf::read_sf(cid_url)
# }
