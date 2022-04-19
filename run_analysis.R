# check if I've already downloaded the data
if (!file.exists("./data")) {
    dir.create("./data")
    file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    file_name <- "Dataset.zip"
    download.file(file_url, destfile = file_name, method = "curl")
    unzip(zipfile = file_name, unzipdir = "./")
    file.rename(from = "UCI HAR Dataset", to = "data")
}

# load the data
df_features_train <- read.csv(file = file.path("data", "train", "X_train.txt"),
    header = FALSE, sep = "")
df_activity_train <- read.csv(file = file.path("data", "train", "y_train.txt"),
    header = FALSE, sep = "")
df_subject_train <- read.csv(file = file.path("data", "train", "subject_train.txt"),
    header = FALSE, sep = "")

df_features_test <- read.csv(file = file.path("data", "test", "X_test.txt"),
    header = FALSE, sep = "")
df_activity_test <- read.csv(file = file.path("data", "test", "y_test.txt"),
    header = FALSE, sep = "")
df_subject_test <- read.csv(file = file.path("data", "test", "subject_test.txt"),
    header = FALSE, sep = "")

features <- read.csv("./data/features.txt", header = FALSE, sep = "")
# second column is the feature
features <- features[, 2]
activities <- read.csv("./data/activity_labels.txt", header = FALSE, sep = "")
# second column is the activity
activities <- activities[, 2]

# rename the column names
colnames(df_features_train) <- features
colnames(df_features_test) <- features

colnames(df_subject_train) <- "Subject"
colnames(df_subject_test) <- "Subject"

colnames(df_activity_train) <- "Activity"
colnames(df_activity_test) <- "Activity"

# merge the dataframes
df <- rbind(df_features_train, df_features_test)
df$activity <- factor(rbind(df_activity_train, df_activity_test)$Activity)
df$subject <- factor(rbind(df_subject_train, df_subject_test)$Subject)

levels(df$activity) <- activities