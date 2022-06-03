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
url <- "https://www.bmkg.go.id/cuaca/prakiraan-cuaca-indonesia.bmkg?Prov=10&NamaProv=Jawa%20Barat"
tabelbogor <- read_html(url)
databogor <- html_table(tabelbogor)
databogor <- as.data.frame(databogor)
databogor <- databogor[-2,]
databogor <- databogor[-2,]

dataSiap <- databogor[16, ]
# Menyambungkan MongoDB Database ke R ------------------------

# This is the connection_string. You can get the exact url from your MongoDB cluster screen
connection_string = 'mongodb+srv://madaniata:tamadania17@MDS.kqfqm.mongodb.net/sample_training'
cuacabogor_collection = mongo(collection="cuacaBogor",
                              db="UAS_MDS",
                              url=connection_string)
cuacabogor_collection$insert(databogor)


# Hashtag
hashtag <- "CuacaBogor"

# Build the status message
status_details <- paste0("Prediksi cuaca Bogor esok harii",
                         "\n",
                         "Pagi: ", dataSiap[6],
                         "\n",
                         "Siang: ", dataSiap[7],
                         "\n",
                         "Malam: ", dataSiap[8],
                         "\n",
                         "Dini hari: ", dataSiap[9],
                         " #",hashtag)

## Post the image to Twitter
rtweet::post_tweet(
  status = status_details,
  token = cuacabogor_token
)
