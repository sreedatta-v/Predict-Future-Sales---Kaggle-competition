# Predict-Future-Sales---Kaggle-competition
In this competition I will work with a challenging time-series dataset consisting of daily sales data, kindly provided by one of the largest Russian software firms - 1C Company. 

## Table of Contents 

1. [Introductions](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
2. [Importing Libraries](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
3. [Loading Datasets](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
4. [Overview of Datasets](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
5. [Merging Dataframes](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
6. [Data Manipulations](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
7. [Exploratory Data Analysis](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
8. [Data Cleaning](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
9. [Model Deployment](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
10. [Model Evaluations](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)
11. [Results Submissions](https://github.com/sreedatta-v/Predict-Future-Sales---Kaggle-competition/blob/main/README.md)

## Description ( About Challange ) 
In this competition you will work with a challenging time-series dataset consisting of daily sales data, kindly provided by one of the largest Russian software firms - 1C Company.   

We are asking you to predict total sales for every product and store in the next month. By solving this competition you will be able to apply and enhance your data science skills.  

## Evaluation Metrics 
Submissions are evaluated by root mean squared error (RMSE). True target values are clipped into the [0,20] range.

### Citation: 
Alexander Guschin, Dmitry Ulyanov, inversion, Mikhail Trofimov, utility, Μαριος Μιχαηλιδης KazAnova. (2018). Predict Future Sales. [Kaggle.](https://kaggle.com/competitions/competitive-data-science-predict-future-sales)

## Dataset Description: 
You are provided with daily historical sales data. The task is to forecast the total amount of products sold in every shop for the test set. Note that the list of shops and products slightly changes every month. Creating a robust model that can handle such situations is part of the challenge.

### File descriptions
sales_train.csv - the training set. Daily historical data from January 2013 to October 2015.  
test.csv - the test set. You need to forecast the sales for these shops and products for November 2015.  
sample_submission.csv - a sample submission file in the correct format.  
items.csv - supplemental information about the items/products.  
item_categories.csv  - supplemental information about the items categories.  
shops.csv- supplemental information about the shops.  

### Data fields
ID - an ID that represents a (Shop, Item) tuple within the test set  
shop_id - unique identifier of a shop  
item_id - unique identifier of a product  
item_category_id - unique identifier of item category  
item_cnt_day - number of products sold. 
item_price - the current price of an item  
date - date in format dd/mm/yyyy  
date_block_num - a consecutive month number, used for convenience. January 2013 is 0, February 2013 is 1,..., October 2015 is 33  
item_name - name of item  
shop_name - name of shop  
item_category_name - name of item category  
This dataset can be used for any purpose, including commercial use.  

### Downloadable from Kaggle: 
```
Kaggle competitions download -c competitive-data-science-predict-future-sales
```

## Importing Libraries 

-> Utilized R packages & Libraries to perform Data cleaning, manipulation, and visualization. 

```
install.packages("readr") #Reads the Data
library(readr)

install.packages("dplyr") #Data Manipualtion
library(dplyr)

install.packages("ggplot2") #Data Visualization
library(ggplot2)
```

<b> readr </b>: 
The goal of readr is to provide a fast and friendly way to read rectangular data from delimited files, such as comma-separated values (CSV) and tab-separated values (TSV).  

<b> dplyr </b>: 
The dplyr package in R is a set of tools for manipulating data frames, which are spreadsheet-like data structures. It's a core package of the tidyverse, and is used by data scientists to transform data into a format that's better suited for analysis or visualization.

### Here are some things the dplyr package can do:  
• Select: Choose specific columns from a data set   
• Filter: Remove irrelevant data based on specified conditions  
• Arrange: Reorder rows in a data frame  
• Mutate: Add new features to a data set  
• Summarize: Collapse groups into a single-row summary  
• Join: Combine multiple data sets into one.  

<b> ggplot2 </b>: 
The ggplot2 package in R is used to create data visualizations and statistical graphics.  

## Loading Datasets 

This step involves loading all the required libraries into the Global Environment ( Workspace ). 

```
item_categories <- read.csv("competitive-data-science-predict-future-sales/item_categories.csv")
View(item_categories) #View displays the data frame that been created.

items <- read.csv("competitive-data-science-predict-future-sales/items.csv")
View(items)

sales_data <- read.csv("competitive-data-science-predict-future-sales/sales_train.csv")
View(sales_data)

sample_submission <- read.csv("competitive-data-science-predict-future-sales/sample_submission.csv")
View(sample_submission)

shops <- read.csv("competitive-data-science-predict-future-sales/shops.csv")
View(shops) 

test <- read.csv("competitive-data-science-predict-future-sales/test.csv")
View(test)
```

## Overview of Data 

--> This step involves in providing: 
1. Statistical Information of data [ Mean, Median, Quantile, Q1, Q3, Variance]
2. Missing values
3. Duplicates etc. 

This step will be crucial in understanding how data is spread across the dataset and the performance indicators one needs to focus on. 

```
str(sales_data) # it returns the datatype and a few values from that dataset.

head(sales_data) #Returns top 5 Observations from df
tail(sales_data) #Returns bottom 5 Observations from df

summary(sales_data) #Returns the statistical analysis of Data.

#Check for Null values [Data Cleaning 1]

sum(is.na(sales_data))
sum(is.na(item_categories))
sum(is.na(items))
sum(is.na(sample_submission))
sum(is.na(shops))

#Handling Missing values ( in case available: )
### na.omit() & is.na() removes missing values from the dataset. 

### To convert data types : as.numeric(), as.character()

```

Note: Mode is not included in Statistical Summary but it can be calculated separately. 

```
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

mode(sales_data$item_price)
mode(item_cnt_days)
```

### Outlier Analysis 

Outliers are values within a dataset that vary greatly from the others—they're either much larger or significantly smaller. Outliers may indicate variabilities in a measurement, experimental errors, or novelty.  

Outliers can represent:  
• Unusual, rare, or suspicious behavior   
• Items that are so far outside the norm that they need not be considered   
• Unique and singular categories or variables  
 
```
# Outlier Analysis 
Q1 <- quantile(sales_data$item_price,0.25)
Q3 <- quantile(sales_data$item_price,0.75)

IQR <- Q3 - Q1

Outliers <- sales_data[sales_data$item_price < Q1 - 1.5*IQR | sales_data$item_price > Q3 + 1.5*IQR,]

cleaned_sales_data <- sales_data[!sales_data$item_price %in% Outliers$item_price,]

Q4 <- quantile(items$item_id,0.25)
Q5 <- quantile(items$item_id,0.75)

IQR1 <- Q5 - Q4 
Outliers1 <- items[items$item_id < Q4 - 1.5*IQR1 | items$item_id > Q5 + 1.5*IQR1,]
cleaned_item_catg <- items[!items$item_id %in% Outliers1,]
```

## Data Merging

--> It involves in merging two or more dataframees into single dataframe.  

It is broadly done using Joins: 
1. Inner Join
2. Outer Join
3. Left Join
4. Right Join

<code> abs </code> : Convert all the negative values in a feature to Non-negative values. 

```
Merged_clean_Sales <- left_join(cleaned_sales_data,cleaned_item_catg,by="item_id")
Merged_clean_Sales <- left_join(Merged_clean_Sales,item_categories,by="item_category_id")
Merged_clean_Sales <- left_join(Merged_clean_Sales,shops, by = "shop_id")
View(Merged_clean_Sales)

Merged_clean_Sales$item_cnt_day <- abs(Merged_clean_Sales$item_cnt_day)

Merged_clean_Sales$date <- as.Date(Merged_clean_Sales$date,format = "%d.%m.%Y")

typeof(Merged_clean_Sales$date)

## test Set
test <- left_join(test,items,by="item_id")
test <- left_join(test,item_categories,by="item_category_id")
head(Merged_clean_Sales,5)
```
