# crawler
A) We would like you to write a service that scrape the nhsChoice website (http://www.nhs.uk/Conditions/Pages/hub.aspx) and cache the condition pages and their subpages content in a json file (contain at least url, page content and title).

# instructions
This is a simple ruby application that crawles the required web. I am limiting how many subpages I crawl from the web not to bombard inoccent web with requests. The limit can be removed by getting rid the only [0..1] range.

The projects produces json file in working directory, the name is hardcoded and example file is submited in the solution.
