library(plyr)
library(dplyr)

# Step 0: Import Data Sets from Files

# Directories where raw data files are stored
data_dir <- "UCI HAR Dataset"
train_dir <- file.path(data_dir, "train")
test_dir <- file.path(data_dir, "test")

# Data Frames for the raw data in the training and test files
raw_subject_train <- read.table(file.path(train_dir, "subject_train.txt"))
raw_X_train <- read.table(file.path(train_dir, "X_train.txt"))
raw_y_train <- read.table(file.path(train_dir, "y_train.txt"))
raw_subject_test <- read.table(file.path(test_dir, "subject_test.txt"))
raw_X_test <- read.table(file.path(test_dir, "X_test.txt"))
raw_y_test <- read.table(file.path(test_dir, "y_test.txt"))

# Step 1: Merge to create one data set

raw_train_data <- cbind(raw_subject_train, raw_y_train, raw_X_train)
raw_test_data <- cbind(raw_subject_test, raw_y_test, raw_X_test)
merged_data <- rbind(raw_train_data, raw_test_data)

# Step 2: Extract only the mean and standard deviation measurements

# Use features.txt to give column names to make extraction easier
measurement_names <- read.table(file.path(data_dir, "features.txt"),
                                stringsAsFactors = FALSE)
names(merged_data) <- c("Subject", "Activity", measurement_names[,2])

# Before using select, need to remove duplicated column names
duplicates_removed_data <- merged_data[!duplicated(names(merged_data))]
extracted_data <- select(duplicates_removed_data, Subject, Activity,
                         contains("mean", ignore.case = FALSE),
                         contains("std"))

# Step 3: Use descriptive activity names

activity_names <- (read.table(file.path(data_dir, "activity_labels.txt")))[, 2]
extracted_data$Activity <- activity_names[extracted_data$Activity]

# Step 4: Use descriptive variable names

# Step 5: Average each variable by subject and activity to create a 
#         new tidy data set

tidy_averages <- extracted_data %>%
                    group_by(Subject, Activity) %>%
                    summarise_each(funs(mean))
names(tidy_averages)[-(1:2)] <- paste("Avg", 
                                      names(tidy_averages)[-(1:2)],
                                      sep = ":")

# Coda: Write the tidy data set to a text file

output_file <- "Tidy Averages.txt"
write.table(tidy_averages, output_file, quote = FALSE, row.names = FALSE)
