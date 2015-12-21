#
# run_analysis.R
#
# This file takes the data from a Human Activity Research project
# (link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
# sourced from the Coursera Data Science 'Getting and Cleaning Data' course
# (link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
#
# Descriptions of the data and methodology are present in the downloadable zip.
# Preparation of the data for analysis is contained in this file, along with
# a description of the process.  Comments noted '>' are quoted directly from
# the assignment, other comments are mine.
#
# The analysis is broken into two main parts, 
# the first preparing the main dataset, (assignment steps 1--4), and
# the second preparing the new dataset of averages.
#


# Before starting, we need to make sure we actually _have_ the data.
# the getData.R file fetches the assignment zip, preps the data dir, and
# extracts the contents if the data is not present.  If the data are already
# there, it doesn't do anything at all :).
source('getData.R')

#
#   PART I.
#   =======
#   Merging and Preparing the main dataset.
#
# > You should create one R script called run_analysis.R that does the following.
# > 1. Merges the training and the test sets to create one data set.
# > 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# > 3. Uses descriptive activity names to name the activities in the data set
# > 4. Appropriately labels the data set with descriptive variable names.
#
# The data from the zipfile are spread across several files - separate
# directories for test and train data (which we are to combine), separate files
# for subject info, activity coding, observation labels, and actual observed
# values.  For this first step, we'll combine all of them into a single file.


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# First, let's get the things we'll need for both the train and test data

# The column headers for the observation data are in `features.txt`.
# We'll read this one into a vector first.
features <- read.table('./data/UCI HAR Dataset/features.txt',
                        col.names = c('index', 'name'),
                        stringsAsFactors = FALSE)

# The label text is also stored globally, so let's grab that, too.
labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt',
                       col.names = c('label_id', 'label_name'),
                       stringsAsFactors = TRUE)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# The main data tables are BIG, and we only want part of them (mean, std columns).
# Rather than read and store a ton of data only to throw out a bunch of it,
# let's only keep the columns we want from the getgo.
# Found this little tidbit:
#  > colClasses: Possible values are ... "NULL" (when the column is skipped)"
#  in the doc for read.table (https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html)
#  h/t to this stackoverflow post: http://stackoverflow.com/questions/5788117/only-read-limited-number-of-columns-in-r
# Soo... let's produce a list of just the columns we want first.

# Per the features_info.txt provided with the dataset, the feature names are standardized -
#   we can match just the ones with `-std()` or `-mean()`
#   since our assignment specifies "", I'm taking this to mean we _don't_ want to keep the
#   "Additional vectors obtained by averaging the signals in a signal window sample"
#   (gravityMean, tBodyAccMean, tBodyAccJerkMean, etc.)

# First we look for the match in the names
features$keep <- grepl("-(std|mean)\\(\\)$", features$name)

# Then produce a vector to pass to colClasses
features$colClass <- ifelse(features$keep, 'numeric', 'NULL')

# And that gives us the tools we need to take care of
# > 2. Extracts only the measurements on the mean and standard deviation for each measurement
# and
# > 4. Appropriately labels the data set with descriptive variable names.


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Now we have all the global data, and a means of subsetting the big datasets,
# so we're ready to read in the main datafiles.
# We'll repeat the same process for both sets.

# Read in the main training dataset
train_data <- read.table('./data/UCI HAR Dataset/train/X_train.txt',
                         col.names = features$name,
                         colClass = features$colClass,
                         stringsAsFactors = FALSE)
# using our features data from above, we can check off requirements 2 and 4.

# Read in and append the subject id's for each row
train_subjects <- read.table('./data/UCI HAR Dataset/train/subject_train.txt',
                             col.names = c('subject_id'))
train_data$subject_id <- train_subjects$subject_id

# Read in and append the label id's for each row
train_labels <- read.table('./data/UCI HAR Dataset/train/y_train.txt',
                            col.names = c('label_id'))
train_data$label_id <- train_labels$label_id

# Then merge in the label strings, too.
train_data <- merge(train_data, labels, by = 'label_id')
# which takes care of
# > 3. Uses descriptive activity names to name the activities in the data set

# Let's do the same for the test data, minus the commentary
test_data <- read.table('./data/UCI HAR Dataset/test/X_test.txt',
                         col.names = features$name,
                         colClass = features$colClass,
                         stringsAsFactors = FALSE)
test_subjects <- read.table('./data/UCI HAR Dataset/test/subject_test.txt',
                             col.names = c('subject_id'))
test_data$subject_id <- test_subjects$subject_id
test_labels <- read.table('./data/UCI HAR Dataset/test/y_test.txt',
                           col.names = c('label_id'))
test_data$label_id <- test_labels$label_id
test_data <- merge(test_data, labels, by = 'label_id')

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
