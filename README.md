## Running the R script

Before running the script **run\_analysis.R**, please ensure the following:

1. You have extracted the dataset to a folder called "UCI HAR
Dataset" (that has files "features.txt" and "activity_labels.txt", and
subfolders "test" and "train").   
2. The run\_analysis.R file resides at the same level as the folder
"UCI HAR Dataset", i.e., both the run\_analysis.R file and the folder
UCI HAR Dataset belong to the same folder (the run\_analysis.R file
should not be inside the UCI HAR Dataset folder, for example). 
3. On your R console, you have set the working directory (e.g., using
setwd()) to the one where both the R script and the UCI HAR Dataset
folder reside. 

## Understanding the R script

A description of the script in the file **run\_analysis.R**, organized
by the steps in the project description.

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
to mean and standard deviation. For mean, the project instructions may
be ambiguous and the justification for my choice is as follows. I have
chosen to only extract the mean values of measurements that, based on
the description in the file "features_info.txt", are given by names of
the form mean() . I agonized long over this, but I decided not to
extract mean frequencies (given by names of the form meanFreq())
because following the description in "features_info.txt", they do not
directly correspond to means of other measurements in the data, but
rather a weighted means of components extracted from the signal
measurements. We can unambigously exclude the averaged signals used in
the angle() variables since these are angle (and not mean)
measurements. The columns of interest related to mean are therefore
identified as those containing the substring "mean()" and similarly
for standard deviation.  

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

### Step 5: Tidy Data Set with Average of each Variable

I have chosen to create the tidy data set in the *wide* form, where
the all measurements (more precisely, their average values) appear in
a single row for each subject, activity combination. This satisfies
the tidy data requirements since each row contains a single
observation (for the combination of subject and activity) and each
variable represents a different measurement. This section of the
R-script is fairly self-explanatory - main noteworthy uses of the
*dplyr* package are as follows:

* Chaining (%>%) to compose functions
* Using the function *summarise_each*, rather than *summarise*, to
take the mean of all columns (other than those that are grouped-by)
without having to explicitly list them all as would have been required
if we had used *summarise*.  

Finally, since the values are now averages per group, we update the
variable names in the data frame **tidy_averages** to more accurately
reflect their values (as befitting a "tidy" data set). This is done by
prepending the string "Avg:" to all column names other than the first
two (corresponding to Subject and Activity) which do not need to be
changed. 

### Coda: Writing the tidy data set to a text file

1. Following the course project instructions, we output the tidy data
frame to a text file by using write.table with parameter row.name =
FALSE. The output file name has been chosen to be "Tidy
Averages.txt". I prefer the look of the text file where strings don't
appear within double quotes and therefore have used the parameter
quote = FALSE.

2. Note that the text file may not be so easy to read directly. You
could use the following sequence of commands, e.g., to read in the
file into R and view it as a nicely formatted data frame (assuming you
store the output text file as "Tidy Averages.txt"):   
      ```R
      Tidy.Averages <- read.table("Tidy Averages.txt", header = TRUE, check.names = FALSE)
      View(Tidy.Averages)
      ```
Note especially the fact that you should use the parameters header =
TRUE (to read the first line as column names) and check.names = FALSE
(to prevent R from changing the column names).

3. The more verbose and comprehensive descriptions of the variable
names are in the codebook. The codebook is the file "Codebook.txt" in
this GIT repository. 

