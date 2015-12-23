# Code Book

From the source research:
-  The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
-  The gyroscope units are rad/seg.

Variables in this dataset:

  The identifier of the subject

    subject_id

  The identifier of the activity type

    label_id

  The activity type name, as a string

    label_name

  Means and Standard Deviations of BODY accelleration readings from the
  accelerometer in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyAcc-mean-X-avg
    tBodyAcc-mean-Y-avg
    tBodyAcc-mean-Z-avg
    tBodyAcc-std-X-avg
    tBodyAcc-std-Y-avg
    tBodyAcc-std-Z-avg

  Means and Standard Deviations of GRAVITY accelleration readings from the
  accelerometer in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tGravityAcc-mean-X-avg
    tGravityAcc-mean-Y-avg
    tGravityAcc-mean-Z-avg
    tGravityAcc-std-X-avg
    tGravityAcc-std-Y-avg
    tGravityAcc-std-Z-avg

  Means and Standard Deviations of BODY JERK readings from the
  accelerometer in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyAccJerk-mean-X-avg
    tBodyAccJerk-mean-Y-avg
    tBodyAccJerk-mean-Z-avg
    tBodyAccJerk-std-X-avg
    tBodyAccJerk-std-Y-avg
    tBodyAccJerk-std-Z-avg

  Means and Standard Deviations of BODY readings from the
  gyroscope in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyGyro-mean-X-avg
    tBodyGyro-mean-Y-avg
    tBodyGyro-mean-Z-avg
    tBodyGyro-std-X-avg
    tBodyGyro-std-Y-avg
    tBodyGyro-std-Z-avg

  Means and Standard Deviations of BODY JERK readings from the
  gyroscope in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyGyroJerk-mean-X-avg
    tBodyGyroJerk-mean-Y-avg
    tBodyGyroJerk-mean-Z-avg
    tBodyGyroJerk-std-X-avg
    tBodyGyroJerk-std-Y-avg
    tBodyGyroJerk-std-Z-avg

  Means and Standard Deviations of CALCULATED MAGNITUDE of BODY ACCELLERATION
  in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyAccMag-mean-avg
    tBodyAccMag-std-avg

  Means and Standard Deviations of CALCULATED MAGNITUDE of GRAVITY ACCELLERATION
  in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tGravityAccMag-mean-avg
    tGravityAccMag-std-avg

  Means and Standard Deviations of CALCULATED MAGNITUDE of BODY JERK
  in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyAccJerkMag-mean-avg
    tBodyAccJerkMag-std-avg

  Means and Standard Deviations of CALCULATED MAGNITUDE of BODY GYRO READINGS
  in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyGyroMag-mean-avg
    tBodyGyroMag-std-avg

  Means and Standard Deviations of CALCULATED MAGNITUDE of BODY GYRO JERK READINGS
  in a given dimension (XYZ), averaged across all observations
  of a given activity type for a given subject.

    tBodyGyroJerkMag-mean-avg
    tBodyGyroJerkMag-std-avg

  The `f` variables correspond to the above described variables, except that
  they have had Fast Fourier Transform (FFT) applied.  These were subsequently
  averaged across all observations of a given activity type for a given subject.

    fBodyAcc-mean-X-avg
    fBodyAcc-mean-Y-avg
    fBodyAcc-mean-Z-avg
    fBodyAcc-std-X-avg
    fBodyAcc-std-Y-avg
    fBodyAcc-std-Z-avg

    fBodyAccJerk-mean-X-avg
    fBodyAccJerk-mean-Y-avg
    fBodyAccJerk-mean-Z-avg
    fBodyAccJerk-std-X-avg
    fBodyAccJerk-std-Y-avg
    fBodyAccJerk-std-Z-avg

    fBodyGyro-mean-X-avg
    fBodyGyro-mean-Y-avg
    fBodyGyro-mean-Z-avg
    fBodyGyro-std-X-avg
    fBodyGyro-std-Y-avg
    fBodyGyro-std-Z-avg

    fBodyAccMag-mean-avg
    fBodyAccMag-std-avg
    fBodyAccJerkMag-mean-avg
    fBodyAccJerkMag-std-avg
    fBodyGyroMag-mean-avg
    fBodyGyroMag-std-avg
    fBodyGyroJerkMag-mean-avg
    fBodyGyroJerkMag-std-avg
