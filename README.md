## Inspiration
What are the best restaurants in the summer? What is the most popular food for a rainy day?  WeatherEats allows one to easily find the best restaurants based on their chosen weather conditions. 

The solution came from a medium post by Samantha Bickell. Reading her post gave us the inspiration to use an integration of weather data with yelp reviews, which ultimately is what WeatherEats is built upon. 

Samantha Bickell's post on medium. https://medium.com/@yelpmontreal/yackathon-spotlight-samantha-bickell-2015-yackathon-winner-bce3549e48a3#.8lsic2qxb


## What it does

WeatherEats is a native iOS app that displays all the top-rated restaurants in the area based on a weather filter chosen by users. The map also displays the users current location, in addition to all the top restaurants they are around. This feature makes it convenient for users to choose a top restaurant destination to their liking. 

## How we built it
First we used a python script to obtain past weather history for every day from 2005-2016. We calculated the average weather everyday and saved it in a list. There are four different types of weather that we saved. (Clear ,Cloudy ,Rainy, Snowy). We then extracted all the 4 and 5 star reviews, and mapped the reviews to the weather history. We created a new data set by mapping every business with the weather that showed up the most in the reviews. We created an iOS app made in Swift to visualize this data in the form of a map. 

## Challenges we ran into
The challenges we faced was that it was very difficult to merge the weather data with yelp's data set. At first, we tried using Yelp's API, but we soon realized that we were limited to only one review per business, as the API offers. We needed to analyze all the reviews of a business so we decide to used Yelp's data set instead. However, the magnitude of Yelp's data set was too big to read in as a whole file. Therefore, we made a python script to analyze all the reviews line by line and made a new data set with weather.

## Accomplishments that I'm proud of
We take pride that we completed  a fully functional iOS app and displays the data in a beautiful visualization for the user in the span of a hackathon. In addition, we are proud of how we handled the magnitude of Yelp's data set, and our idea of utilizing a Python script to organize the results.

Lastly, we are also pleased with our idea to incorporate a correlation with weather and restaurant data. We believe this information can greatly benefit local businesses, users, and Yelp. Hopefully our data can provide a new perspective for local businesses to track their progress. 

## What I learned
I learned how to use MKMapView to create custom annotations to visualize the data. 

## What's next for WeatherEats
Hopefully, we can have a backend database to store all the data later on.
