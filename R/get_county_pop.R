get_county_pop <- function(fips = FALSE){
  ny_fips <- read_csv("data/ny_fips.csv")
  url <- "https://www.health.ny.gov/statistics/vital_statistics/2018/table02.htm"
  doh_page <- read_html(url) 
  doh_page_body <- doh_page %>% html_nodes('body')
  
  county_pop <-
    bind_cols(
      county = doh_page_body %>% 
        xml_find_all("//table[contains(@class, 'widetable')]/tbody/tr/td[1]") %>% 
        html_text() %>%
        str_trim(),
      pop_estimate_2018 = as.numeric(
        gsub(",","",
             doh_page_body %>% 
               xml_find_all("//table[contains(@class, 'widetable')]/tbody/tr/td[2]") %>% 
               html_text()
        )
      ),
      pop_density_2018 = as.numeric(
        gsub(",","",
        doh_page_body %>% 
          xml_find_all("//table[contains(@class, 'widetable')]/tbody/tr/td[5]") %>% 
          html_text()
        )
      )
    )
  
  if (fips){
    county_pop %>%
      left_join(ny_fips, by = "county") %>%
      filter(!county %in% c("New York State", "Rest of State")) %>%
      select(fips, pop_estimate_2018, pop_density_2018)
  } else county_pop %>% filter(!county %in% c("New York State", "Rest of State"))
  
}