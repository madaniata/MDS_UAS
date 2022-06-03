library(dplyr)
library(rtweet)
library(rvest)
library(mongolite)

# Create Twitter token API --------------------------------

cuacabogor_token <- rtweet::create_token(
  app = "cuacabogor",
  consumer_key = 'ePf756VGtEJTHeHZgYzrHMlNp',
  consumer_secret = 'g2mi5REpuWi5yrMmGR7w5slVcyCjWQi01pSP7cxlUbnjcnrfeJ',
  access_token = '1489125681510248453-0locTYPSc8kDgfWbPEf6SJbxmlf3Qj',
  access_secret = 'ukAcEMBKERxwhcAys5vXGr3iOFzXkZt3tyh9oxC1kBila'
)

## batas ==================================================================

tabelbogor <- read_html("https://www.bmkg.go.id/cuaca/prakiraan-cuaca-indonesia.bmkg?Prov=10&NamaProv=Jawa%20Barat")
databogor <- html_table(tabelbogor)
databogor <- datajabar[-2,]
databogor <- datajabar[-2,]

dataSiap <- databogor[16, ]
# Menyambungkan MongoDB Database ke R ------------------------

# This is the connection_string. You can get the exact url from your MongoDB cluster screen
connection_string = 'mongodb+srv://madaniata:tamadania17@MDS.kqfqm.mongodb.net/sample_training'
cuacajabar_collection = mongo(collection="cuacaBogor",
                              db="UAS_MDS",
                              url=connection_string)
cuacajabar_collection$insert(databogor)

# Hashtag
hashtag <- "CuacaBogor"

# Build the status message
status_details <- paste0("Prediksi cuaca Bogor esok hari",
                         "\n",
                         "Pagi: ", dataSiap[8],
                         "\n",
                         "Siang: ", dataSiap[9],
                         "\n",
                         "Malam: ", dataSiap[10],
                         "\n",
                         "Dini hari: ", dataSiap[11],
                         " #",hashtag)

## Post the image to Twitter
rtweet::post_tweet(
  status = status_details,
  token = cuacajabar_token
  )
}
