This directory contains the scripts to prepare the data for
processing.

Project_CleanData.m -- A function that takes an input file, a save
file and a flag indicating whether the file is a training set or a
test set.  Converts the category fields into vectors of {0,1} flags.
The "income>50k" field is converted to {-1, 1} and the ID field is
moved to the last column.

attributes.txt -- The attribute values from the Kaggle website.

prep.m -- A wrapper function that takes the path of training data and
test data files and run Project_CleanData on them saving the result to
train.mat and test.mat.

SVM_prep.m -- A wrapper function that takes the path of training data and
test data files and runs SVM_CleanData on them saving the result to
svmtrain.mat and svmtest.mat.


