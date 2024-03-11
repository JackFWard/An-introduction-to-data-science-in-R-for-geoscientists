# "An introduction to data science in R for geoscientists"

Welcome! This GitHub repository contains copies of the workshop data file ("R_Workshop_Data.csv") and script ("R_Workshop_Code_2024.R"). I have also included R and RStudio installation instructions below. Please contact me at jack.ward1@uqconnect.edu.au if you have any questions or comments.

# R and RStudio installation instructions

## Step 1: Install R

We will use R version 4.3.3 for the workshop. It can be installed via the following links:

### MacOS
https://cloud.r-project.org/bin/macosx/ – click “R-4.3.3-x86_64.pkg” (highlighted below in red) if you have an Intel Mac or “R-4.3.3-arm64.pkg” (highlighted below in blue) if you have an M-series Mac. 
 
![MacOS_Installation](https://github.com/JackFWard/An-introduction-to-data-science-in-R-for-geoscientists/assets/63625965/f8c1c5ab-7365-46a3-af4d-7abaa4f67990)

### Windows
https://cran.r-project.org/bin/windows/base/ – click the link highlighted below. 

![Windows_Installation](https://github.com/JackFWard/An-introduction-to-data-science-in-R-for-geoscientists/assets/63625965/efe183d3-cd82-4f18-87fc-bd304d822777)

## Step 1.2: Windows Only – Install RTools

RTools allows you to build packages that use Fortran, C, and C++ code. It isn’t essential for our tutorial, but, if you don’t install it, you will get an annoying message in your console asking you to do so. Installing RTools is a bit more complicated than installing R and RStudio, but this video clearly walks you through the installation process. 

RTools download: https://cran.r-project.org/bin/windows/Rtools/ ***Note: use RTools4.3***

Installation tutorial: https://www.youtube.com/watch?v=hBTObNFFkhs&t=0s 


## Step 2: Install RStudio

As we will see in the workshop (or if you installed RTools), the default R interface isn’t particularly user-friendly. To make our lives easier, we will use an integrated development environment (IDE) to run R. In this workshop, we will use RStudio (download: https://www.rstudio.com/products/rstudio/download/#download). I have modified my panel layout in the screenshot below, but, overall, RStudio should look similar to this when you open it:

![RStudio_Layout](https://github.com/JackFWard/An-introduction-to-data-science-in-R-for-geoscientists/assets/63625965/4bf06a07-5749-43aa-b445-972810e03514)

### Note: “Loading required package: raster” and “Loading required package: sp” won’t appear in your console, nor will you have any data files in your environment or code open in the editor.

## Step 3: Install the ‘tidyverse’ packages

R is noteworthy for containing several extremely powerful packages. Those included in the ‘tidyverse’ family are especially useful for working with geoscience datasets. Packages can be installed by typing install.packages(“PackageName”) into the console. Normally, you would write this for each package or use a vector [e.g., install.packages(c(“Package1Name”, “Package2Name”, “Package3Name”)] to install multiple packages at once. By typing install.packages(“tidyverse”) in the console and pressing enter/return to run the code, however, R will download and install the ‘ggplot2’, ‘tibble’, ‘tidyr’, ‘readr’, ‘purr’, ‘dplyr’, ‘stringr’, and ‘forcats’ packages. We will install other packages during the workshop, but I wanted the tidyverse packages to be installed before the session because they can sometimes take a few minutes to download. I have attached a screenshot of what you need to do below. If you receive the “Do you want to install from sources the packages which need compilation? (Yes/no/cancel)” message, type “no” and press enter/return. Allow the code to run for a minute or so. You will receive a message when the packages are installed.

![Tidyverse](https://github.com/JackFWard/An-introduction-to-data-science-in-R-for-geoscientists/assets/63625965/a5071f1d-e8ca-4a5b-9168-0534a169c4ec)

## Create a working directory
The final thing I would like you to do before the workshop is to create a folder called "RCodingWorkshop" in your Documents folder and save the data file ("R_Workshop_Data.csv') there. I would like you to do this to avoid any potential issues with working directories during the workshop. Depending on your operating system, your file path should look like either:

MacOS: "/Users/jackward/Documents/RCodingWorkshop"; or

Windows: “C:\\Users\\Jack\\Documents\\RCodingWorkshop"


 
