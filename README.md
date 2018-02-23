Exercise #3: RSS

Create an application, in any programming language, that is capable of reading from any web news feed.
For example of some locations to stream from, look at http://www.cnn.com/services/rss/ for a list of
CNN's rss feeds.
  1. Stream headlines and brief descriptions about each headline. Extract these into your preferred
  format or location (SAS dataset, Excel format, JSON, SQL database, or other), with no HTML tags.
  2. This process should run every 10 minutes.
  3. The next time the application runs, it should append new information to the existing data.
  4. Split the description information into multiple columns of length no greater than 100 characters.
  Do not truncate in the middle of a word.
  5. Allow surfacing of these results in a basic webpage front end.
