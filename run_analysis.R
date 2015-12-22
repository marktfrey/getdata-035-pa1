source('get_data.R')

# Prepare vars for both train and test data
features <- read.table('./data/UCI HAR Dataset/features.txt',
                        col.names = c('index', 'name'),
                        stringsAsFactors = FALSE)

labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt',
                       col.names = c('label_id', 'label_name'),
                       stringsAsFactors = TRUE)

# Prep features to decide which vars to keep
features$keep <- grepl("-(std|mean)\\(\\)", features$name)
features$colClass <- ifelse(features$keep, 'numeric', 'NULL')

# Read in training data
train_data <- read.table('./data/UCI HAR Dataset/train/X_train.txt',
                         col.names = features$name,
                         colClass = features$colClass,
                         check.names = FALSE,
                         stringsAsFactors = FALSE)
train_subjects <- read.table('./data/UCI HAR Dataset/train/subject_train.txt',
                             col.names = c('subject_id'))
train_data$subject_id <- train_subjects$subject_id
train_labels <- read.table('./data/UCI HAR Dataset/train/y_train.txt',
                            col.names = c('label_id'))
train_data$label_id <- train_labels$label_id
train_data <- merge(train_data, labels, by = 'label_id')

# Read in test data
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

# Combine train and test data
allData <- rbind(train_data, test_data)

# Produce aggregated mean for each var by subject + activity
aggregateData <- aggregate(allData[ , features[features$keep, ]$name],
                           by = list(subject_id=allData$subject_id,
                                     label_id=allData$label_id,
                                     label_name=allData$label_name),
                           mean)

# Clean up column names for the new data
tidyColumnNames <- sapply(names(aggregateData), function(name){ 
  name <- gsub("BodyBody", "Body", name) 
  name <- gsub("\\(\\)", "", name)
  name <- ifelse ((grepl("-(mean|std)(-[XYZ])?$", name)), paste(name, "-avg", sep=""), name)
  name
})

colnames(aggregateData) <- tidyColumnNames

# Write the data out to a new file
write.table(aggregateData, file="./tidy_data.txt", row.names = FALSE)
