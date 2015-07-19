A description of the script in the file **run\_analysis.R**, organized
by the 5 steps in the Course Project description.

### Step 0: Import Data Sets from Files

Before we can start with any of the steps, we need to first import the
raw data in the training and test files into R objects. The project
data was extracted to a folder called "UCI HAR Dataset" that resides
in the same folder as the R script. The path names to the training and
test files are then constructed in a platform-independent way by using 
the *file.path* function.

### Step 1: Merging the Training and Test Data

This is done in two steps:
* Combine the columns for subject information (subject), activity label (y), and
feature set (X) for training and test data into the data frames
raw_train_data and raw_test_data respectively. 
* Combine the rows from raw_train_data and raw_test_data to create the
required merged data, stored into merged_data.

### Step 2: Extracting Mean and Standard Deviation Measurements

### Step 3: Descriptive Activity Names

### Step 4: Adding Descriptive Variable Names

### Step 5: Data Set with Average of each Variable

