# Setting the working directory to the Desitop
setwd(dir = "~/Desktop/r-novice-inflammation/")

# Read in the inflammation-01.csv file
read.csv(file = "data/inflammation-01.csv", header = FALSE)

# Define a variable called "weight_kg"
weight_kg <- 55  # Use assignment operator for variables outside of a function
# weight_kg = 55
# Multiply weight_kg by 2.2
weight_lb <- 2.2 * weight_kg

# change weight_kg: variables are not intrinsically linked by definition
weight_kg <- 100 
weight_lb <- 2.2 * weight_kg

# define a variable for inflammation_01.csv
inflammation <- read.csv(file = "data/inflammation-01.csv", header = FALSE)
# look at the first 1 row
head(inflammation, 1)
# look at the last 6 rows
tail(inflammation)

# look at the class of inflammation
class(inflammation)

# exercise for variables!
mass <- 47.5
age <- 122
# This is how we can update a variable
mass <- mass * 2.0
mass
age <- age - 20
age

# look at the dimension of inflammation
dim(inflammation)

# look at the first entry in the first row/column
inflammation[1, 1]   # [row,column]
# look at the first entry in the third column
inflammation[1,3]
# square brackets are used for indexing
head(inflammation, 1)
# first two entries of the third column
inflammation[c(1,2), 3]  # want to combine 1 and 2 together: rows 1 and 2, column 3
head(inflammation, 2)

# first two entries of the third and fifth columns
inflammation[c(1,2), c(3,5)]
inflammation[1:2, c(3,5)]

# print out sequential values
c(1,2,3,4,5)
1:5
3:12

# extracting individual columns (5th column)
inflammation[, 5] # putting in a space is good for readability
#extract the first row
inflammation[1, ]

# calculate the maximum inflammation for the first patient (first row)
max(inflammation[1, ]) # the largest value in the first row

# calculate the minimum inflammation on the 5th day across all of the patients
min(inflammation[, 5])

# calculate the average inflammation on day 7
mean(inflammation[, 7])

# calculate the median inflammation for patient 4
median(inflammation[4, ])

# class of 4th column
class(inflammation[, 4])
# class of 4th row
class(inflammation[4, ])

# force row to be numeric and calculate median
median(as.numeric(inflammation[4, ]))  # this is an issue that will come up

# compare inflammation[4,] with as.numeric(inflammation[4, ])
inflammation[4,]
as.numeric(inflammation[4, ])

# get help:  apply function
?apply

# calculate the average inflammation for each patient
# apply(dataset, row(1) or column(2), function)
apply(inflammation, 1, mean) # calculate the mean for every row

# Make sure to understand the structure and dimensions of the file

#EXERCISE 1
# calculate the mean inflammation for patient 1 to 5 for the whole 40 days
apply(inflammation[1:5,],1,mean) # take the first 5 rows of inflammation, and apply to every row the mean, and get the average
# inflammation for each row, which is each patient
apply(inflammation, 1, mean)[1:5] # this is another way of doing the same thing
apply(head(inflammation,5),1,mean)  # another way to solve this exercise

# EXERCISE 2
# calculate the mean inflammation for days 1 to 10 across all patients
apply(inflammation[, 1:10], 2, mean)  # we now subset the columns and we apply it across the... we get a value for each day

# EXERCISE 3
# calculate the mean inflammation for every second day (for all patients)
# hint: ?seq
# hint: 1:20*2
# hint seq(2,40,2)
apply(inflammation[, 1:20*2], 2, mean)
apply(inflammation[, seq(2,40,2)], 2, mean)  # we index using sequence, taking every other day; get a value of each column, so margin is 2
1:20*2
seq(2,40,2)


####### Visualization #######
# calculate average inflammation for each day
# assign to variable
avg_day_inflammation <- apply(inflammation, 2, mean)  # we want a value for each day, so a value for each column
plot(avg_day_inflammation)
# y-axis: average inflammation across all patients for each day

# check out ggplot2 -- need to install this separately
# install ggplot2
install.packages("ggplot2")  # do this once ever
library("ggplot2") # use every session
ggplot(inflammation) + geom_point(x = V1, y = V2)
head(iris)
ggplot(iris) + geom_point(aes(x= Sepal.Width, y = Petal.Length, col=Species))
?ggplot

########## Functions   ###########
# Functions are cool!
# function syntax (e.g., read.csv, mean, apply)
# function(argument1, argument2)
# writing a function that takes temperature in F and returns temp in K
fahrenheit_to_kelvin <- function(temp_F) {
  # the body of the function inside the curly brackets
  # convert temp_F to temp_K
  temp_K <- ((temp_F -32) * (5/9)) + 273.15
  return(temp_K)  # gives us output of function
}

fahrenheit_to_kelvin(212)

# function for Kelvin to Celsius
kelvin_to_celsius <- function(temp_K) {
  temp_C <- temp_K - 273.15
  return(temp_C)
}

kelvin_to_celsius(0)

# define function for fahrenheit to celsius
fahrenheit_to_celsius <- function(temp_F) {
  temp_K <- fahrenheit_to_kelvin(temp_F)
  temp_C <- kelvin_to_celsius(temp_K)
  return(temp_C)   
}

fahrenheit_to_celsius(78)

# chaining functions together: 32F in celsius
kelvin_to_celsius(fahrenheit_to_kelvin(32)) # can have argument of function to be the output of another function

# EXERCISE
# define a function that takes two numbers as an input and returns the sum of those two numbers
my_sum <- function(num_1,num_2){
  # add num_1 and num_2 together
  # Args:
  #   num_1: a number
  #   num_2: a number
  # Returns:
  #   a number corresponding to the sum of num_1 and num_2
  # Example:
  #  my_sum(1, 3)
  num_sum <- num_1 + num_2
  return(num_sum)
}
my_sum(3,4)

# EXERCISE
# Define a function (rescale) that takes a vector and returns a scaled version 
# in the range 0 to 1
rescale <- function(vec){
  # A function that scales the vector to be in the range 0 to 1.
  # Args:
  #   vec: a vector of numbers
  # Returns:
  #  a vector of numbers that are scaled to be in the range 0 to 1
  # Example:
  #    rescale(c(5,2,7,9))
  scaled_vec <- (vec - min(vec)) / (max(vec)-min(vec))
  return(scaled_vec)
}

# example:
vec_example <- c(5,2,7,9)
min(vec_example)
max(vec_example)
(vec_example - 2) / 7
(vec_example - min(vec_example)) / (max(vec_example) - min(vec_example))

rescale(c(5,2,7,9))

# copy and paste my_sum again here:

my_sum <- function(num_1 = 5, num_2 = 4){   # we now have defined defaults
  # add num_1 and num_2 together
  # Args:
  #   num_1: a number
  #   num_2: a number
  # Returns:
  #   a number corresponding to the sum of num_1 and num_2
  # Example:
  #  my_sum(1, 3)
  num_sum <- num_1 + num_2
  return(num_sum)
}

my_sum()  # now we won't get an error message here: default value here is now 5 + 4
my_sum(9)
my_sum(num_2 = 16)

# check out the tidyverse!!

# write a function for analyzing inflammation data file
analyze_inflammation <- function(filename)  {
  # plot the average inflammation over time
  # Args:
  #    filename: character string that specifies the path to the csv file
  # Returns:
  #   a plot of average inflammation over time
  # Example:
  #    analyze_inflammation("data/inflammation-01.csv")
  
  # read in the data
  inflammation <- read.csv(filename)
  # calculate average inflammation for each day
  avg_day_inflammation <- apply(inflammation, 2, mean)
  # plot the aerage inflammation
  # save the plot
  # png(paste0(filename, "_plot.png"))
  plot(avg_day_inflammation)
  # dev.off()  # optional
}

analyze_inflammation("data/inflammation-10.csv")

# for loop
#for (variable in collection) {
#  do things
#}

# define variable consisting of filenames
filenames <- list.files(path = "data", pattern = "inflammation", full.names = TRUE)

filenames

for (file in filenames) {
  print(file)
  
  analyze_inflammation(file)
}

#########

analyze <- function(filename) {
  # Plots the average, min, and max inflammation over time.
  # Input is character string of a csv file.
  inflammation <- read.csv(file=filename, header = FALSE)
  avg_day_inflammation <- apply(inflammation, 2, mean)
  plot(avg_day_inflammation)
  max_day_inflammation <- apply(inflammation, 2, max)
  plot(max_day_inflammation)
  min_day_inflammation <-apply(inflammation, 2, min)
  plot(min(avg_day_inflammation))
}

analyze_all <- function(pattern){
  # Runs the function analyze for each file in the current working directory than contains the given pattern
  filenames <- list.files(path="data", pattern = pattern, full.names = TRUE)
    for (f in filenames) {
      analyze(f)
    }

}


# Conditionals

num <- 37

if (num > 100){
  print("greater than 100")
} else {
  print("not greater than 100")
}
print("done")

# chain several if-else statements together
sign <- function(num){
  if (is.numeric(num)){
  if (num > 0){
    return(1)
  } else if (num == 0){
    return(0)
  } else{
    return(-1)
  }
}
}


# >=  this means greater than equal
# <=  this means less than equal
# !=   this means not equal to

# & means "AND"
# | means "OR"

# Example of chaining things together

if (1 > 3 & 3 > 2){
  print("both parts are true")
} else {
  print("at least one part is false")
}
if (1 > 3 | 3 > 2){
  print("at least one part is true")
} else {
  print("both parts are false")
}

# Write plot_dist() function such that we can run 
plot_dist <- function(myvector, threshold){
# your input variable names are myvector and threshold  
# write a statement that checks if the length of myvector is greater than the value of threshold
# HINT: IF
  
  if (length(myvector) > threshold){
 boxplot(vector)
  }
}
plot_dist(inflammation[,10],threshold=10)
myvector <- c(1,3,5,9)
plot_dist(myvector,threshold=10)

# Find the file containing the patient with the highest inflammation score
# what file is it
# what row is this score in (patient #)
# read in all the names of the inflammation files
filenames = list.files(path="data", pattern="inflammation", full.names = TRUE)
# set variables that we can update as we loop through the files
filename_max <- "" # if we find a file that has a maximum greater than what we've seen, keep a record
inflammation_all_max <- 0 # if we find a file that has a maximum greater than what we've seen, record the max
pattern_max <- 0

for (f in filenames){ # iterate over files we want
  inflammation <-read.csv(file = f, header = FALSE)
  # read files
  inflammation_patient <- apply(inflammation, 1, mean)
  # calculate mean inflammation for each patient
  inflammation_max <- max(inflammation_patient) # find the max of all patients
  
  inflammation_all_max <- c(inflammation_all_max, inflammation_max)
  
  # compare against what we've seen so far
  if (inflammation_max > inflammation_all_max) {
    inflammation_all_max <- inflammation_max
    filename_max <- f
  }
}