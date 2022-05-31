# Create Twitter token API --------------------------------

library(rtweet)

cuacabogor_token <- rtweet::create_token(
  app = "cuacabogor",
  consumer_key = 'ePf756VGtEJTHeHZgYzrHMlNp',
  consumer_secret = 'g2mi5REpuWi5yrMmGR7w5slVcyCjWQi01pSP7cxlUbnjcnrfeJ',
  access_token = '1489125681510248453-0locTYPSc8kDgfWbPEf6SJbxmlf3Qj',
  access_secret = 'ukAcEMBKERxwhcAys5vXGr3iOFzXkZt3tyh9oxC1kBila'
)

# Menyambungkan MongoDB Database ke R ------------------------

# This is the connection_string. You can get the exact url from your MongoDB cluster screen
library(mongolite)
connection_string = 'mongodb+srv://madaniata:tamadania17@MDS.kqfqm.mongodb.net/sample_training'
cuacajabar_collection = mongo(collection="cuacaBogor",
                              db="UAS_MDS",
                              url=connection_string)
cuacajabar_collection$insert(dataSiap)

## batas ==================================================================

#pht = getSourceEditorContext()$path
#pht = gsub("/Deploy.R", "", pht)

setwd(getwd())
source('ScrapingData.R')
source('TweetPosting.R')

Scraping_Data(con, twitter_token)
Tweet_Posting(con, twitter_token)
