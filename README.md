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
single merged data set that is stored in the data frame **merged_data**.

### Step 2: Extracting Mean and Standard Deviation Measurements

This is done in the following steps, corresponding to each uncommented
line in the R script:
* The file features.txt contains the feature names (for the columns
originally in the "X" files) in its second column. To be able to
perform string operations (like checking for inclusion of "mean"), we
read in the file as a dataframe **measurement_names** without the
strings (in the second column) being converted into factors.
* We use the names "Subject" and "Activity" for the first two columns
(corresponding to the "subject" and "y" data respectively) and the
remaining column names (corresponding to the "X" data) given by the
second column of **measurement_names**
* The file features.txt contains a number of duplicated names which
prevents the *select* function (from *dplyr* package) from being
used. However, these duplicate names do not include the columns of
interest (related to mean and standard deviation) and can therefore be
first safely removed (using the inbuilt R function *duplicated*).
* We extract the first two columns and the remaining columns related
to mean and standard deviation. For mean, I have chosen to extract the
mean values (given by names of the form mean()) and mean frequencies
(given by names of the form meanFreq()) - the project instructions
seemed ambiguous on whether mean frequencies should be included or
not. I do not, however, want to include the averaged signals used in
the angle() variables - these include the word Mean with an uppercase
"M". The columns of interest related to mean are therefore identified
as those containing the substring "mean" without ignoring case. The
standard deviation columns are those that include the substring
"std". 

### Step 3: Descriptive Activity Names

### Step 4: Adding Descriptive Variable Names

### Step 5: Data Set with Average of each Variable

