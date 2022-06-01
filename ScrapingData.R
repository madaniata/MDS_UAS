Scraping_Data <- function(con, twitter_token) {
library(rvest)
urlbogor <- "https://www.bmkg.go.id/cuaca/prakiraan-cuaca-indonesia.bmkg?Prov=10&NamaProv=Jawa%20Barat"
tabelbogor <- read_html(urljabar)
databogor <- html_table(tabeljabar)
databogor <- as.data.frame(datajabar)
databogor <- datajabar[-2,]
databogor <- datajabar[-2,]

library(dplyr)
dataSiap <- databogor[16, ]

# Menyambungkan MongoDB Database ke R ------------------------

# This is the connection_string. You can get the exact url from your MongoDB cluster screen
library(mongolite)
connection_string = 'mongodb+srv://madaniata:tamadania17@MDS.kqfqm.mongodb.net/sample_training'
cuacajabar_collection = mongo(collection="cuacaBogor",
                              db="UAS_MDS",
                              url=connection_string)
cuacajabar_collection$insert(databogor)
}


