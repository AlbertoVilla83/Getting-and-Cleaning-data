# Getting-and-Cleaning-data

---
title: "Readme"
author: "Alberto Villa"
date: "01 agosto 2017"
output: html_document
---

==================================================================
# Human Activity Recognition Key Parameters (means and standard  deviation) Using Smartphones Dataset
### Version 1.0
==================================================================
Alberto Villa
alberto.villa01@gmail.com
==================================================================

## Data Description 

Disclaimer: data in this experiment have been obtained by manipulating the original data set [1].

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, 
LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. 


The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters 
and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated 
using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is 
assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

From all fetures, the mean and standard deviation were extracted and their average value computed (for a total of
180 values, 6 tasks per 30 subjects).
See 'codebook.txt' for more details. 

### For each record it is provided:


* The activity performed
* An identifier of the subject who carried out the experiment.
* A 79-feature vector including means and standard deviation average values with time and frequency domain variables.  


### The dataset includes the following files:
=========================================

* 'README.txt' : This file

* 'codebook.txt': Shows information about the variables used on the feature vector.

* 'tidy_data.csv': The process data set.

* 'runAnalysis.r': The R script used to process the original data set and obtain the data.


### Notes: 
======
* Original features from [1] were normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

For more information about the processed dataset contact: alberto.villa01@gmail.com
For more information about the original dataset contact: activityrecognition@smartlab.ws

### License:
========
Use of the original dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
