# BoostNews
A flutter project for news (using https://newsapi.org/)

# Getting Started
First enter the app folder as follow:

cd boost_news

Run the flutter app:

flutter run

## Possible error:
Due to this app using public API in case that app doesent show the news list then change the API KEYS for folders: api_headlines.dart, api_everything.dart and api_search.dart

Here is what error looks like when you try to GET the API request in browser:

{"status":"error","code":"rateLimited","message":"You have made too many requests recently. Developer accounts are limited to 100 requests over a 24 hour period (50 requests available every 12 hours). Please upgrade to a paid plan if you need more requests."}

###### If you have any questions feel free to contact me
#A few resources to get you started if this is your first Flutter project:
- Lab: Write your first Flutter app
- Cookbook: Useful Flutter samples
- For help getting started with Flutter, view our online documentation, which offers tutorials, samples, guidance on mobile development, and a full API reference.
