# This script grabs a string of comma separated page urls and then performs a lighthouse
# test on each page url. The result of the test is output as an HMTL file.

# Set config variables below
URL=https://myfirstjobinfilm.com
MAIN_DIR=./MFJIF
OUTPUT_TYPE=html
DELIMITER=,

# Read first line from pages file
read -r PAGE_URIS < page_uris.txt

# Set the progress variables. Count = item count, Progress = Progress count
COUNT=$(echo $PAGE_URIS| tr -cd $DELIMITER | wc -c)
PROGRESS=1

# Set field seperater (comma is default)
IFS=$DELIMITER
# Loop through each item in the page urls string
for PAGE_URI in $PAGE_URIS
do

    # Print progress to CLI
    echo "Starting page $PROGRESS out of " $(($COUNT+1))

    # Get the folder path to the current page
    PAGE_DIR_PATH=$(dirname $PAGE_URI)

    # Combine the main folder path with the page folder path
    FULL_DIR_PATH="$MAIN_DIR/$PAGE_DIR_PATH"

    # Create the storage directory
    mkdir -p $FULL_DIR_PATH

    # Replace / in page url with -- to make valid for file names
    FILE_NAME=$(basename $PAGE_URI)

    # Create output file path
    OUTPUT_PATH=$(echo $FULL_DIR_PATH/$FILE_NAME.$OUTPUT_TYPE | sed 's,/./,/,g')

    # Run lighthouse script
    # First param is page url
    # --quiet removes the CLI messages from the lighthouse command
    # --throttling.cpuSlowdownMultiplier to mimic mobile devices
    # --output specifies the type
    # --output-path specifies the output path set above.
    lighthouse $URL/$PAGE_URI --quiet --throttling.cpuSlowdownMulitplier=6 --output=$OUTPUT_TYPE --output-path=$OUTPUT_PATH
    
    # Visit: https://github.com/GoogleChrome/lighthouse#using-the-node-cli for more options of the lighthouse command

    # Print progress to CLI
    echo "Completed page $PROGRESS out of " $(($COUNT+1))

    # Increment progress count
    PROGRESS=$((PROGRESS+1))

done
