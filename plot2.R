##########################################################################################################
## Coursera Course Project 2 for Exploratory Data Analysis
## José Manuel Teles Louro da Silva 
## JoseLouro@gmail.com

### plot2.R File Description:

### The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
### Dataset: Data for Peer Assessment [29Mb]
### Description: The data for this assignment are available from the course web site as a single zip file:
### The zip file contains two files:
### PM2.5 Emissions Data (summarySCC_PM25.rds): 
### This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.
### 
### Source Classification Code Table (Source_Classification_Code.rds): 
### This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful.
### 
### You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
### 
### Question 2:
### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
### 
### Answer:
### Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.
###
##########################################################################################################
### Set working directory to the location where the Electric power consumption Dataset was unzipped.
# setwd("H:/My Documents/Personal Stuff/Career Docs/2. Data Science Specialization/4. Exploratory Data Analysis/3. Quizzes/ExData-Project2")


# Check for Data File Archive
fileName <- "exdata-data-NEI_data.zip"
if(! file.exists(fileName)) {
	 message("Downloading the data set archive...")
	 fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
	 download.file(url=fileURL,destfile=fileName,method="curl")
}
# Extract Data File
if(!file.exists("summarySCC_PM25.rds") && !file.exists("Source_Classification_Code.rds")) {
	 message("Extracting the data set files from the archive...")
	 unzip(zipfile = fileName)
}

# Read the NEI & SCC data sets.
message("Reading the data set files...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data by Baltimore's fip.
message("Subset data by Baltimore's fip...")
BaltimoreNEI <- NEI[NEI$fips=="24510",]


# Aggregate using sum the Baltimore emissions data by year
message("Aggregate the Baltimore emissions data by year...")
aggTotalBaltimore <- aggregate(Emissions ~ year, BaltimoreNEI,sum)

# Plot the Data!
message("Plotting the data...")

png("plot2.png",width=480,height=480,units="px",bg="transparent")
barplot(
  aggTotalBaltimore$Emissions,
  names.arg=aggTotalBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources"
)

message("Saving the plot...")
dev.off() # Close the PNG device!
