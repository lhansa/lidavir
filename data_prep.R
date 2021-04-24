library(tidyverse)
library(readxl)

fichero_in <- "data/nombres_por_edad_media.xls"
hojas <- excel_sheets(fichero_in)
names(hojas) <- hojas

df_nombres <- map_dfr(hojas, function(s){
  read_xls(fichero_in, sheet = s, skip = 5) %>% 
    janitor::clean_names()
}, .id = "sex")

write_csv(df_nombres, "data/nombres_por_edad_media.csv")
