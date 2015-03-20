##########################################################################################################
## Coursera Course Project 2 for Exploratory Data Analysis
## José Manuel Teles Louro da Silva 

### plot5.R File Description:

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
### Question 5:
### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
### 
### Answer:
### Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!
###
##########################################################################################################
### Set working directory to the location where the Electric power consumption Dataset was unzipped.
# setwd("H:/My Documents/Personal Stuff/Career Docs/2. Data Science Specialization/4. Exploratory Data Analysis/3. Quizzes/ExData_Project2")


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


# Gather the subset of the NEI data which corresponds to vehicles
message("Subset data which corresponds to vehicles...")
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
message("Subset vehicles data by Baltimore's fip...")
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

png("plot5.png",width=640,height=640,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

message("Saving the plot...")
dev.off() # Close the PNG device!

