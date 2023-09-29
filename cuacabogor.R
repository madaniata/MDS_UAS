library(dplyr)
library(rtweet)
library(rvest)

# Create Twitter token API --------------------------------

cuacabogor_token <- rtweet::create_token(
  app = "madaniata17",
  consumer_key = Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

## ==================================================================
url <- "https://www.bmkg.go.id/cuaca/prakiraan-cuaca-indonesia.bmkg?Prov=10&NamaProv=Jawa%20Barat"
tabelbogor <- read_html(url)
databogor <- html_table(tabelbogor)
databogor <- as.data.frame(databogor)
databogor <- databogor[-2,]
databogor <- databogor[-2,]
rownames(databogor) <- databogor$X1

dataSiap <- databogor["Kota Bogor", ]

# Hashtag
hashtag <- "CuacaBogor"

# Build the status message
status_details <- paste0("Prediksi cuaca Bogor tanggal ",
                         format(Sys.Date()+1, format="%d %B %Y"),
                         "\n",
                         "Dini hari: ", dataSiap[2],
                         "\n",
                         "Pagi: ", dataSiap[6],
                         "\n",
                         "Siang: ", dataSiap[7],
                         "\n",
                         "Malam: ", dataSiap[8],
                         " #",hashtag)

## Post the image to Twitter
rtweet::post_tweet(
  status = status_details,
  token = cuacabogor_token
)
