Tweet_Posting <- function(con, twitter_token) {
# Hashtag
hashtag <- "CuacaBogor"

# Build the status message
status_details <- paste0("Prediksi cuaca Bogor esok hari ",
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
