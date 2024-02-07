# Police Shootings
# Imports Police Shootings data from GitHub


# INIT =========================================================================
pacman::p_load(rio, tidyverse)


# IMPORT =======================================================================
police_shootings <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")



# MUNGE ========================================================================
police_shootings <-
  police_shootings |>
  mutate(
    year = year(date),
    month = month(date),
    day_of_week = wday(date, label = TRUE),
    # Added this to make race easier to handle
    race = case_when(race == "A"~"Asian",
                     race == "B"~"Black",
                     race == "H"~"Hispanic",
                     race == "N"~"Native American",
                     race == "W"~"White",
                     str_detect(race, ";") ~ "Multiracial"
                     )
  ) |>
  select(
    id,
    date,
    year,
    month,
    day_of_week,
    threat_type,
    flee_status,
    armed_with,
    city,
    county,
    state,
    latitude,
    longitude,
    location_precision,
    name,
    age,
    gender,
    race,
    race_source,
    was_mental_illness_related,
    body_camera,
    agency_ids
    )



# EXPORT =======================================================================
write_csv(police_shootings, "data/police_shootings.csv")
