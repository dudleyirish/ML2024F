%%
%% A script that takes the path of training data and test data files
%% and runs SVM_CleanData on them saving the result to svmtrain.mat
%% and svmtest.mat.

SVM_CleanData("~/CS/CS6350/project/train_final.csv", "svmtrain.mat", 1);
SVM_CleanData("~/CS/CS6350/project/test_final.csv", "svmtest.mat", 0);
