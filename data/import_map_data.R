# INIT =========================================================================
pacman::p_load(curl)

zip_url <- "https://www2.census.gov/geo/tiger/TIGER2022/STATE/tl_2022_us_state.zip"
zip_local <- "data/tl_2022_us_state.zip"
shapefile_local <- "data/tl_2022_us_state.shp"



# IMPORT =======================================================================

# Download the ZIP file of information and unzip it locally.
curl_download(url = zip_url, destfile = zip_local)
unzip(zip_local, exdir = "data")
unlink(zip_local)