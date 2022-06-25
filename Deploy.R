library(dplyr)
library(rtweet)
library(rvest)
library(mongolite)

# Create Twitter token API --------------------------------

cuacabogor_token <- rtweet::create_token(
  app = "cuacabogor",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
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
connection_string = 'mongodb+srv://madaniata:tamadania17@mds.kqfqm.mongodb.net/?retryWrites=true&w=majority'
cuacabogor_collection = mongo(collection="cuacaBogor",
                              db="UAS_MDS",
                              url=connection_string)
cuacabogor_collection$insert(databogor)


# Hashtag
hashtag <- "CuacaBogor"

# Build the status message
status_details <- paste0("Prediksi cuaca Bogor esok hari",
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
