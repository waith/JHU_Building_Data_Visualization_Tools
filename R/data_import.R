#' asjdoiasdjaoisdjaij osaijdoias jdoiajsodijsaoi
#'
#' @param file_name The path to reach the file "ebtrk_atlc_1988_2015.txt".
#'
#' @return The outuput of this function is a data frame with storm_id, date, latitude,
#'         longitude, wind_speed, ne, nw, se, and sw.
#'
#' @importFrom readr read_fwf fwf_widths
#'
#'
#'
#' @export
data_import <- function(file_name = "ebtrk_atlc_1988_2017.txt",
                        path = "~")
       {
       # Given Code to Importing
       ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                              4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)

       ext_tracks_colnames <- c("storm_id",
                                "storm_name",
                                "month",
                                "day",
                                "hour",
                                "year",
                                "latitude",
                                "longitude",
                                "max_wind",
                                "min_pressure",
                                "rad_max_wind",
                                "eye_diameter",
                                "pressure_1",
                                "pressure_2",
                                paste("radius_34",c("ne",
                                                     "se",
                                                     "sw",
                                                     "nw"),
                                      sep = "_"),
                                paste("radius_50", c("ne",
                                                     "se",
                                                     "sw",
                                                     "nw"),
                                      sep = "_"),
                                paste("radius_64", c("ne",
                                                     "se",
                                                     "sw",
                                                     "nw"),
                                      sep = "_"),
                                "storm_type",
                                "distance_to_land",
                                "final")

       ext_tracks <- readr::read_fwf(file.path(path,file_name),
                                     readr::fwf_widths(ext_tracks_widths,
                                                       ext_tracks_colnames),
                                     na = "-99")
       }
