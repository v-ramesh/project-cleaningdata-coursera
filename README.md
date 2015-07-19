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
(given by names of the form meanFreq()). Mean frequencies are means of
some measurements and I have therefore chosen to extract them although
the project instructions seem ambiguous on this front. I do not,
however, want to include the averaged signals used in the angle()
variables since these are angle (and not mean) measurements. These
average signals are distinguished by containing the word Mean with an
uppercase "M". The columns of interest related to mean are therefore
identified as those containing the substring "mean" without ignoring
case. The standard deviation columns are those that contain the
substring "std" (case doesn't matter here).   

### Step 3: Descriptive Activity Names

We will take the descriptive activity names to be those given in the
file "activity_labels.txt". The two lines in this section of the R
script can then be understood as follows: 
* We read in the file "activity_labels.txt" as a data frame and use
its second column to create the vector **activity_names**. Note that
it so happens that in the file "activity_labels.txt" the sequence of 
values in the first column (activity labels) are 1, 2, ... and
therefore the activity name for any label can be found by simply
indexing into the vector **activity_names**. In other words, for any
activity label l (with l ranging from 1 to 6) the corresponding
activity name can be obtained as **activity_names[l]**. 
* Based on the argument just given, the Activity column of the data
frame is mapped to its corresponding descriptive name by simply
indexing into the vector **activity_names**. 

### Step 4: Adding Descriptive Variable Names

Here, there is a judgement call as to what are suitable variable
names. Because of what we did in Step 2, the data frame
**extracted_data** has variable names and these are of the form
*tBodyAcc-mean()-X*, for example. We could chose to rename this to the
more verbose possibility *"Mean of the Body Acceleration Signal along
X-axis"* as the descriptive variable name. However, I felt that more
succinct names work better as variable names since they appear as
column headings and the more verbose description should be deferred to
the code book which has a linear presentation. Therefore, given that
the variable names I created as part of Step 2 seemed appropriately
descriptive to me, I did nothing in this step.

### Step 5: Data Set with Average of each Variable

