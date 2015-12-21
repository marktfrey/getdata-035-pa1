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

To download and extract the source data, excecute `getData.R` locally,
or source it from within another file. The main `run_analysis.R` file
sources the `getData.R` file, so you needn't execute this separately
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
`getData.R` file fetches the assignment zip, preps the data dir, and
extracts the contents if the data is not present. If the data are
already there, it doesn't do anything at all :).

    source('getData.R')

### PART I: Merging and Preparing the main dataset.

> You should create one R script called run\_analysis.R that does the
> following. 1. Merges the training and the test sets to create one data
> set. 2. Extracts only the measurements on the mean and standard
> deviation for each measurement. 3. Uses descriptive activity names to
> name the activities in the data set 4. Appropriately labels the data
> set with descriptive variable names.

The data from the source zipfile are spread across several files -
separate directories for test and train data (which we are to combine),
separate files for subject info, activity coding, observation labels,
and actual observed values. For this first step, we'll combine all of
them into a single file.

The assignment suggests combining the train and test datasets first, but
The main data tables are BIG, and we only want part of them (mean, std
columns).

Rather than read and store a ton of data only to throw out a bunch of
it, let's only keep the columns we want from the getgo.

Found this little tidbit:

> colClasses: Possible values are ... "NULL" (when the column is
> skipped)"

in the doc for read.table
(<https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html>)

h/t to this stackoverflow post:
<http://stackoverflow.com/questions/5788117/only-read-limited-number-of-columns-in-r>

Soo... let's produce a list of just the columns we want first.
