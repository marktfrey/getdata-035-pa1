# Check for data dir
if (!file.exists("data")) {
  dir.create("data")
}

# Check for data source file, download if needed.
if (!file.exists("data/raw.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data/raw.zip", method="curl")
}

# If the zipfile exists but hasn't been extracted, extract it.
if (!file.exists("data/UCI HAR Dataset")) {
  unzip("data/raw.zip", exdir="data", overwrite=FALSE)
}