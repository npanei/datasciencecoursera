# npanei - getting and cleaning data - course project

# note: working directory should be the "UCI HAR Dataset" folder

# read feature names, select only mean and standard deviation features
# remove invalid characters; convert to R syntactically valid names

features <- read.table("features.txt")
featurelist <- sapply(features[2],as.character)
fcols <- sort(union(grep("mean()",featurelist,fixed=TRUE),
                    grep("std()",featurelist,fixed=TRUE)))
featurelist <- sapply(featurelist,gsub,pattern="()",replacement="",fixed=TRUE)
featurelist <- sapply(featurelist,gsub,pattern="-",replacement="_",fixed=TRUE)

# read main data set from training and test files, apply feature labels, merge

test <- read.table("test/X_test.txt",col.names = featurelist)
train <- read.table("train/X_train.txt",col.names = featurelist)

test <- test[,fcols]
train <- train[,fcols]
test[2948:10299,] <- train

# add activity and subject data, name activities appropriately

ytest <- read.table("test/y_test.txt")
ytrain <- read.table("train/y_train.txt")
ytest[2948:10299,] <- ytrain

ytest <- sapply(ytest,gsub,pattern=1,replacement="WALKING")
ytest <- sapply(ytest,gsub,pattern=2,replacement="WALKING_UPSTAIRS")
ytest <- sapply(ytest,gsub,pattern=3,replacement="WALKING_DOWNSTAIRS")
ytest <- sapply(ytest,gsub,pattern=4,replacement="SITTING")
ytest <- sapply(ytest,gsub,pattern=5,replacement="STANDING")
ytest <- sapply(ytest,gsub,pattern=6,replacement="LAYING")
test[,67] <- ytest

stest <- read.table("test/subject_test.txt")
strain <- read.table("train/subject_train.txt")
stest[2948:10299,] <- strain
test[,68] <- stest

names(test)[67:68] <- c("activity","subject")

# create data frame of averages of the 66 variables above
# across 30 subjects and 6 activities

avg_table <- data.frame()

for (s in 1:30) {
    avg_table[s,1] <- paste("subject",s,"_avg",sep="")
}
avg_table[31:36,1] <- c("WALKING_avg","WALKING_UPSTAIRS_avg","WALKING_DOWNSTAIRS_avg",
                        "SITTING_avg","STANDING_avg","LAYING_avg")

for (x in 1:66) {
    for (s in 1:30) {
        avg_table[s,x+1] <- mean(test[test$subject==s,x])
    }
    
    r <- 31
    for (a in c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                "SITTING","STANDING","LAYING")) {
        avg_table[r,x+1] <- mean(test[test$activity==a,x])
        r <- r + 1
    }
}

names(avg_table) <- c("basis",featurelist[fcols])
avg_table