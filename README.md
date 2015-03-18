##########################################################################################################
## Exploratory Data Analysis - Course Project 2
#### José Manuel Teles Louro da Silva 
#### JoseLouro@gmail.com
#### Repository for the submission of the course project for the Johns Hopkins Exploratory Data Analysis course.
## Introduction
##### Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National <a href="http://www.epa.gov/ttn/chief/eiinformation.html">Emissions Inventory web site</a>.

##### For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

## Data
##### The data for this assignment are available from the course web site as a single zip file:
<ul>
<li><a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip">Data for Peer Assessment </a>[29Mb]</li>
</ul>

####The zip file contains two files:
#####PM2.5 Emissions Data (<code>summarySCC_PM25.rds</code>): 
###### This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.

<pre><code>
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
</code></pre>

<ul>
<li><code>fips</code>: A five-digit number (represented as a string) indicating the U.S. county</li>
<li><code>SCC</code>: The name of the source as indicated by a digit string (see source code classification table)</li>
<li><code>Pollutant</code>: A string indicating the pollutant</li>
<li><code>Emissions</code>: Amount of PM2.5 emitted, in tons</li>
<li><code>type</code>: The type of source (point, non-point, on-road, or non-road)</li>
<li><code>year</code>: The year of emissions recorded</li>
</ul>

##### Source Classification Code Table (<code>Source_Classification_Code.rds</code>): 
###### This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

##### You can read each of the two files using the <code>readRDS()</code> function in R. For example, reading in each file can be done with the following code:
<pre><code>
## This first line will likely take a few seconds. Be patient!
NEI &lt;- readRDS("summarySCC_PM25.rds")
SCC &lt;- readRDS("Source_Classification_Code.rds")
</code></pre>
##### as long as each of those files is in your current working directory (check by calling <code>dir()</code> and see if those files are in the listing).

## Assignment
##### The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

### Making and Submitting Plots
##### For each plot you should
<ul>
<li>Construct the plot and save it to a PNG file.</li>
<li>Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)</li>
<li>Upload the PNG file on the Assignment submission page</li>
<li>Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.</li>
</ul>

##### In preparation we first ensure the data sets archive is downloaded and extracted.
##### We now load the NEI and SCC data frames from the .rds files.
<pre><code>
NEI &lt;- readRDS("summarySCC_PM25.rds")
SCC &lt;- readRDS("Source_Classification_Code.rds")
</code></pre>

## Questions
##### You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1
##### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

##### First lets aggregate the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
<pre><code>
aggTotalYear &lt;- aggregate(Emissions ~ year,NEI, sum)
</code></pre>

##### Using the base plotting system, now we plot the total PM2.5 Emission from all sources,
<pre><code>
barplot(
  (aggTotalYear$Emissions)/10^6,
  names.arg=aggTotalYear$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)
</code></pre>

#### My Plot 1
![My plot1.png](plot1.png) 

#### Answer
##### As we can see from the plot, total emissions have decreased in the US from 1999 to 2008.





### Question 2
##### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland <code>(fips == "24510")</code> from 1999 to 2008?

##### First lets subset the data by Baltimore's fip
<pre><code>
BaltimoreNEI &lt;- NEI[NEI$fips=="24510",]
</code></pre>

##### Now, lets aggregate the Baltimore emissions data by year 1999, 2002, 2005, and 2008.
<pre><code>
aggTotalBaltimore &lt;- aggregate(Emissions ~ year,BaltimoreNEI, sum)
</code></pre>

##### Using the base plotting system, now we plot the total PM2.5 Emission from all sources,
<pre><code>
barplot(
  aggTotalBaltimore$Emissions,
  names.arg=aggTotalBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources"
)
</code></pre>

#### My Plot 2
![My plot2.png](plot2.png)

#### Answer
##### Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.





### Question 3
##### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##### Which have seen increases in emissions from 1999–2008?

##### First lets subset the data by Baltimore's fip
<pre><code>
BaltimoreNEI &lt;- NEI[NEI$fips=="24510",]
</code></pre>

##### Using the ggplot2 plotting system, 
<pre><code>
ggp &lt;- ggplot(BaltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)
</code></pre>

#### My Plot 3
![My plot3.png](plot3.png)

#### Answer
##### The non-road, nonpoint, on-road source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.
##### The point source saw a slight increase overall from 1999-2008. 
##### Also note that the point source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values. 





## Question 4
##### Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008 ?

##### First lets subset the coal combustion related NEI data
<pre><code>
combustionRelated 	&lt;- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated 		&lt;- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion 		&lt;- (combustionRelated & coalRelated)
combustionSCC 		&lt;- SCC[coalCombustion,]$SCC
combustionNEI 		&lt;- NEI[NEI$SCC %in% combustionSCC,]
</code></pre>

##### Using the ggplot2 plotting system, 
<pre><code>
ggp &lt;- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)
</code></pre>

#### My Plot 4
![My plot4.png](plot4.png)

#### Answer
##### Emissions from coal combustion related sources have decreased from 600,000 Tons to below 400,000 Tons from 1999-2008.





## Question 5
##### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##### First lets subset data which corresponds to vehicles
<pre><code>
vehicles 	&lt;- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC &lt;- SCC[vehicles,]$SCC
vehiclesNEI &lt;- NEI[NEI$SCC %in% vehiclesSCC,]
</code></pre>

##### Then we have to subset the data by Baltimore's fip
<pre><code>
baltimoreVehiclesNEI &lt;- vehiclesNEI[vehiclesNEI$fips=="24510",]
</code></pre>

##### Using the ggplot2 plotting system, 
<pre><code>
ggp &lt;- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)
</code></pre>

#### My Plot 5
![My plot5.png](plot5.png)

#### Answer
##### Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!





## Question 6
##### Comparing emissions from motor vehicle sources in Baltimore City <code>(fips == "24510")</code> with emissions from motor vehicle sources in Los Angeles County, California <code>(fips == "06037")</code>, which city has seen greater changes over time in motor vehicle emissions?

##### First lets subset data which corresponds to vehicles
<pre><code>
vehicles 	&lt;- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC &lt;- SCC[vehicles,]$SCC
vehiclesNEI &lt;- NEI[NEI$SCC %in% vehiclesSCC,]
</code></pre>

##### Then we have to subset the data by Baltimore's fip
<pre><code>
vehiclesBaltimoreNEI 		&lt;- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city 	&lt;- "Baltimore City"
</code></pre>

##### Then we have to subset the data by by LA's County fip
<pre><code>
vehiclesLANEI 		&lt;- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city 	&lt;- "Los Angeles County"
</code></pre>

##### Now, lets combine the two subsets
<pre><code>
bothNEI &lt;- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)
</code></pre>

##### Using the ggplot2 plotting system, 
<pre><code>
ggp &lt;- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
 geom_bar(aes(fill=year),stat="identity") +
 facet_grid(scales="free", space="free", .~city) +
 guides(fill=FALSE) + theme_bw() +
 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
 labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
 
print(ggp)
</code></pre>

#### My Plot 6
![My plot6.png](plot6.png)

#### Answer
##### Los Angeles County has seen the greatest changes over time in motor vehicle emissions
