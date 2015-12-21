    library('knitr')
    opts_chunk$set(echo=TRUE, results="asis")

About this file
---------------

This document describes the analysis conducted on data from a Human
Activity Research project as part of the Coursera Data Science course
'Getting and Cleaning Data'.

Scripts are provided that fetch the source dataset, process it, and
produce the "tidy" dataset `tidy_data.txt`.

This README describes the acquisition and manipulation of the source
data. Descriptions of the data contained in tidy\_data.txt are found in
`CODEBOOK.txt`.

------------------------------------------------------------------------

Sourcing the data
-----------------

The source data are available from a Human Activity Research project
(link:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>)

For the purposes of this analysis, we are using the zipfile of these
research data sourced from the Coursera Data Science 'Getting and
Cleaning Data' course (link:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>)

To download and extract the source data, excecute `get_data.R` locally,
or source it from within another file. The main `run_analysis.R` file
sources the `get_data.R` file, so you needn't execute this separately
unless you want to fetch and examine the data without also producing the
`tidy_data.txt` file.

To conduct the full analyisis locally, execute `run_analysis.R`. This
will fetch and extract the data if necessary, and prepare the tidy data
per the described steps below.

------------------------------------------------------------------------

Tidying the data
----------------

Descriptions of the data and methodology are present in the downloadable
zip. Preparation of the data for analysis is described here. Quoted
comments (indicated by `>` blockquotes) are directly from the Coursera
course assignment.

This section is a step-by-step analysis of the code that is also
contained in `run_analysis.R`.

The preparation of these data is broken into two main parts, the first
preparing the main dataset, (assignment steps 1--4), and the second
preparing the new dataset of averages.

Before starting, we need to make sure we actually *have* the data. the
`get_data.R` file fetches the assignment zip, preps the data dir, and
extracts the contents if the data is not present. If the data are
already there, it doesn't do anything at all :).

    source('get_data.R')

### PART I: Merging and Preparing the main dataset.

> You should create one R script called run\_analysis.R that does the
> following.
>
> 1.  Merges the training and the test sets to create one data set.
> 2.  Extracts only the measurements on the mean and standard deviation
>     for each measurement.
> 3.  Uses descriptive activity names to name the activities in the data
>     set
> 4.  Appropriately labels the data set with descriptive variable names.

The data from the source zipfile are spread across several files -
separate directories for test and train data (which we are to combine),
separate files for subject info, activity coding, observation labels,
and actual observed values. For this first step, we'll combine all of
them into a single file.

The assignment suggests combining the train and test datasets first, but
The main data tables are BIG, and we only want part of them (mean, std
columns). Rather than read and store a ton of data only to throw out a
bunch of it, let's only keep the columns we want from the getgo. As a
bonus, we'll also get descriptive variable names from the source data
rather than having to add them back in later.

#### Getting globally applicable information

Let's begin by grabbing the information we'll need to apply to both the
train and test datasets.

The column headers for the observation data are in `features.txt`. We'll
read this one into a dataframe first.

    features <- read.table('./data/UCI HAR Dataset/features.txt',
                            col.names = c('index', 'name'),
                            stringsAsFactors = FALSE)

The label text is also stored globally, so let's grab that, too. For
this file, we actually *want* the names to be factors.

    labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt',
                           col.names = c('label_id', 'label_name'),
                           stringsAsFactors = TRUE)

#### Prepareing to read the source data with only the columns we actually want

Per the `features_info.txt` provided with the dataset, the feature names
are standardized - we can match just the ones with `-std()` or
`-mean()`. Since our assignment specifies "measurements on the mean and
standard deviation for each measurement", I'm taking this to mean we
*don't* want to keep the other variables, described in the source as
"Additional vectors obtained by averaging the signals in a signal window
sample" (gravityMean, tBodyAccMean, tBodyAccJerkMean, etc.)

Found this little tidbit:

> colClasses: Possible values are ... "NULL" (when the column is
> skipped)"

in the doc for read.table
(<https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html>)

h/t to this stackoverflow post:
<http://stackoverflow.com/questions/5788117/only-read-limited-number-of-columns-in-r>

So, First we look for the match in the names and add some
metainformation about these to the features dataframe

    features$keep <- grepl("-(std|mean)\\(\\)$", features$name)

Then we produce a vector formatted to pass to `colClasses`, with `NULL`s
for the columns we don't actually want.

    features$colClass <- ifelse(features$keep, 'numeric', 'NULL')

And that gives us the tools we need to take care of

> 1.  Extracts only the measurements on the mean and standard deviation
>     for each measurement

and

> 1.  Appropriately labels the data set with descriptive variable names.

#### Actually reading the source data

Now we have all the global data, and a means of subsetting the big
datasets, so we're ready to read in the main datafiles.

We'll repeat the same process for both sets.

Read in the main training dataset

    train_data <- read.table('./data/UCI HAR Dataset/train/X_train.txt',
                             col.names = features$name,
                             colClass = features$colClass,
                             check.names = FALSE,
                             stringsAsFactors = FALSE)

using our features data from above, we can check off requirements 2 and
4.

Read in and append the subject id's for each row

    train_subjects <- read.table('./data/UCI HAR Dataset/train/subject_train.txt',
                                 col.names = c('subject_id'))
    train_data$subject_id <- train_subjects$subject_id

Read in and append the label id's for each row

    train_labels <- read.table('./data/UCI HAR Dataset/train/y_train.txt',
                                col.names = c('label_id'))
    train_data$label_id <- train_labels$label_id

Then merge in the label strings, too.

    train_data <- merge(train_data, labels, by = 'label_id')

which takes care of \> 3. Uses descriptive activity names to name the
activities in the data set

We can repeat the exact same process for the test data.

    test_data <- read.table('./data/UCI HAR Dataset/test/X_test.txt',
                             col.names = features$name,
                             colClass = features$colClass,
                             check.names = FALSE,
                             stringsAsFactors = FALSE)
    test_subjects <- read.table('./data/UCI HAR Dataset/test/subject_test.txt',
                                 col.names = c('subject_id'))
    test_data$subject_id <- test_subjects$subject_id
    test_labels <- read.table('./data/UCI HAR Dataset/test/y_test.txt',
                               col.names = c('label_id'))
    test_data$label_id <- test_labels$label_id
    test_data <- merge(test_data, labels, by = 'label_id')

### Combining the training and test data

This is pretty simple, now that everything is in place.

    allData <- rbind(train_data, test_data)

And that takes care of

> 1.  Merges the training and the test sets to create one data set.
