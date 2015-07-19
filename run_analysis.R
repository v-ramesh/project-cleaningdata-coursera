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

