########################################################################
#                                                                      #
#  Author :  Anderson Hitoshi Uyekita                                  #
#  Project:  Coursera - Building Data Visualization Tools              #
#  Date   :  2018-nov-24                                               #
#                                                                      #
#  To do  : Optimize the function using a loop                         #
#                                                                      #
########################################################################

#' Data Manipulation Function - Although this is not a deliverable of the course I made
#' a great effor to pratice/apply the lesson from the last Course. This function creates
#' the data frame used as of the geom_hurricane.
#'
#' @param file_path The path to reach the file "ebtrk_atlc_1988_2015.txt".
#'
#' @return The outuput of this function is a data frame with storm_id, date, latitude,
#'         longitude, wind_speed, ne, nw, se, and sw.
#'
#' @importFrom magrittr %>%
#'
#' @importFrom dplyr mutate select
#'
#' @importFrom tidyr spread unite
#'
#' @importFrom readr read_fwf fwf_widths
#'
#' @importFrom lubridate ymd_hm
#'
#' @examples
#'
#' \dontrun{data_manipulation("ebtrk_atlc_1988_2015.txt")}
#'
#' \dontrun{data_manipulation("ebtrk_atlc_1988_2017.txt")}
#'
#' @export
data_manipulation <- function(dt_import)
{
# Data Manipulation
dt_import %>%
       # Converting longitude to negatives numbers
       dplyr::mutate(longitude = -1 * .data$longitude) %>%

       # Creating storm_id variable
       tidyr::unite("storm_id",   # Name of my new variable in a column
             .data$storm_name,    # First component of my new variable
             .data$year,          # Second component of my new variable
             sep = "-",           # Use dash to compound the name
             remove = FALSE) %>%  # Do not drop varibale beacuse I will use later

       # Creating Date variable
       dplyr:: mutate(date = paste(.data$year,"-",   # Compund the date variable in a new column
                           .data$month,"-",  #
                           .data$day,"-",    # Format: Year, month, day, hour and minutes
                           .data$hour,"-00", #
                           sep = "")) %>%    #

       # Converting date column to lubridate
       dplyr::mutate(date = lubridate::ymd_hm(.data$date)) %>%

       # Subsetting the dataframe
       dplyr::select(.data$storm_id,
              .data$date,
              .data$latitude,
              .data$longitude,
              .data$storm_name,
              .data$year,
              .data$radius_34_ne,
              .data$radius_34_nw,
              .data$radius_34_se,
              .data$radius_34_sw,
              .data$radius_50_ne,
              .data$radius_50_nw,
              .data$radius_50_se,
              .data$radius_50_sw,
              .data$radius_64_ne,
              .data$radius_64_nw,
              .data$radius_64_se,
              .data$radius_64_sw) %>%

              tidyr::gather(temp,            # Creating two columns and putting all variables in it.
                            value,6:18) %>%  # All radius_* columns, storm_name and year in "variables"

              dplyr::mutate(wind_speed = stringr::str_extract(string = temp,  # Creating column with
                                                pattern = "34|50|64")) %>%    # 34, 50 or 64 values
                                                                              # (later will be used in spread)

              dplyr::mutate(temp = stringr::str_extract(string = temp,                   # Creating column with
                                                        pattern = "ne|nw|se|sw")) %>%    # ne, nw, se or sw values
                                                                                         # (later will be used in spread)

              tidyr::spread(temp,       # Based on the last two variables (temp and wind_speed)
                            value) %>%  # I am going to spread to fill those columns with radius_* values.

              dplyr::filter(!is.na(wind_speed), # Removing rows with wind_speed equal to NA
                     !is.na(ne),                # Removing NA rows
                     !is.na(nw),
                     !is.na(se),
                     !is.na(sw)) %>%

              dplyr::mutate(wind_speed = as.factor(wind_speed)) %>% # Ensure wind_speed as factor

              # Ordering the columns
              dplyr::select(.data$storm_id,
                            .data$date,
                            .data$latitude,
                            .data$longitude,
                            .data$wind_speed,
                            .data$ne,
                            .data$nw,
                            .data$se,
                            .data$sw)
}
