# Lighthouse-Automation
Automatically loop through all provided web pages and generate lighthouse reports for each.

## Set up
Run `npm i -g lighthouse` to install the command line tool

Add your page URIs to the page_uris.txt file. **Do not encase fields**. **Currently set up to handle comma delimiters**, change the `DELIMITER` variable to what you need, if you're not using a standard CSV. **All values on a single line**.

## Running
Open a terminal in the route of this project and run the following:

**Git Bash:** `./lighthouse.sh`

**Windows Command Line:** `bash ./lighthouse.sh` or `bash -x ./lighthouse.sh` to debug any issues.

