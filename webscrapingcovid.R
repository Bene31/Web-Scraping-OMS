library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(readr)
library(xml2)

# Leitura da web page
webpage <- read_html("https://covid19.who.int/data")
webpage

# Extraindo os registros
results <- webpage %>% html_nodes("a") %>% html_attr("href")
results 

# Construindo o dataset
records <- vector("list", length = length(results))
records

for (i in seq_along(results)) {
  url <- webpage %>% html_nodes("a") %>% html_attr("href")
  
  records[[i]] <- data_frame(url = url)
}

# Dataset final
df <- bind_rows(records)

df_filtered <- distinct(df %>% filter(stringr::str_ends(url, '.csv')))

url_output <- c(df_filtered)

i <- 0
y <- 0

for(i in 1 : nrow(df_filtered) ){
  download.file(paste(df_filtered[i+y,]), 
    str_replace_all(
      paste(
        "C:/Users/Arthur/Desktop/who_data/", 
        str_replace_all(
          paste(df_filtered[i+y,]), 
          "https://covid19.who.int/", 
          ""
        ), 
        sep=""
      ), 
      "who-data/", 
      ""
    )	
  )
}

