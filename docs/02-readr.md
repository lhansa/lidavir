# Reading data with readr

## Excel

Unfortunately, Excel is used worldwide in a lot of sectors and along with several technologies to store and analyze data. But it has limitations in scalability, generalization, license... R is a solution for all this. If you need to analyse some data stored in Excel, you can read it from R and start working with this programming language. 

In the `data` folder you have the `iris` dataset exported as an Excel file (watch out! you also have it with a different format, but will not be used yet). You can open it with Excel or other spreadsheet software such as Numbers, LibreOffice or Google Sheets. To work with it in R, we need to load it on memory as a data frame or tibble (we are going to work with the latter). There is no way of doing this with R base, but there are a few options on different libraries. For reading, we'll use `readxl`. 


```r
library(readxl)
iris_excel <- read_excel("data/iris.xlsx")
```

The function `read_excel()` receives a path in your computer to the file you want to read. We will explain in class the concept of relative and absolute path (in the example, the path is relative, since we have read a file inside the working directory, which you can verify with `getwd()`). 

We can print `iris_excel` on the console and check that the info is an already known tibble.


```r
iris_excel
```

```
## # A tibble: 150 x 5
##    sepal_length sepal_width petal_length petal_width species
##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          4.9         3            1.4         0.2 setosa 
##  3          4.7         3.2          1.3         0.2 setosa 
##  4          4.6         3.1          1.5         0.2 setosa 
##  5          5           3.6          1.4         0.2 setosa 
##  6          5.4         3.9          1.7         0.4 setosa 
##  7          4.6         3.4          1.4         0.3 setosa 
##  8          5           3.4          1.5         0.2 setosa 
##  9          4.4         2.9          1.4         0.2 setosa 
## 10          4.9         3.1          1.5         0.1 setosa 
## # … with 140 more rows
```

</br>

You have been provided with another Excel file, `"01_ ACCIDENTES POR TIPO EN  DISTRITOS.xls"`. If you open it, you will see that there are several sheets and that the data don't begin on the first row. If you use the code above to read it into R, you will not get a data frame as you would like.


```r
datos_mal <- read_excel("data/01_ ACCIDENTES POR TIPO EN  DISTRITOS.xls")
```

```
## New names:
## * `` -> ...2
## * `` -> ...3
## * `` -> ...4
## * `` -> ...5
## * `` -> ...6
## * ...
```

```r
datos_mal
```

```
## # A tibble: 29 x 12
##    `01. ACCIDENTES … ...2  ...3  ...4  ...5  ...6  ...7  ...8  ...9  ...10 ...11
##    <chr>             <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
##  1 <NA>              <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  2 <NA>              <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  3 <NA>              <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  4 <NA>              <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  5 Indicadores       Nº A… <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  6 Año               2009  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  7 DISTRITO_ACCIDEN… COLI… COLI… CHOQ… ATRO… VUEL… CAÍD… CAÍD… CAÍD… CAÍD… OTRA…
##  8 ARGANZUELA        389   54    126   75    9     43    9     4     5     8    
##  9 BARAJAS           89    6     53    21    <NA>  12    2     1     2     2    
## 10 CARABANCHEL       375   44    171   137   8     36    13    6     9     8    
## # … with 19 more rows, and 1 more variable: ...12 <chr>
```

We need to consider two parameters in `read_excel()` function: the row number where we want to begin the reading and the sheet we want to read. 


```r
df_accis_2009 <- read_excel("data/01_ ACCIDENTES POR TIPO EN  DISTRITOS.xls", 
                            skip = 7, sheet = "2009")
```

```
## New names:
## * `` -> ...12
```

**Exercises.** 

- Read the rest of the sheets of the Excel file. You should find some trouble with one of the years if you just copy and paste what I typed. Fix it. 
- Create one data frame for each sheet. How many rows and columns each one has? _Hint._ `nrow()`, `ncol()` and `dim()` may help. 
- What is the average number of accidents per type in 2009? And the standard deviation? _Hint._ You should use the `$` notation.
- What are the names of the columns? Do you consider them appropriate? _Hint._ `names()`.

### About the names

In R there is some freedom about the names of the columns of a data frame but it is recommeded some guidance, similar to the one of creating objects: 

- Use only letters (I only use lowercase), numbers and `_`.
- Separate each word in the name with a `_`. 
- Begin only with letters. 

There is a function that helps a lot fixing the names of columns. It is especially orientated to problems related with Excel files. The function is `clean_names()` and you can find it in the `janitor` package. 

**Exercise.**

- Install the `janitor` package and load it. _Hint._ `library()`.
- Use `clean_names()` on your data frames to fix their names. _Hint._ Bear in mind that if you just type `clean_names(mi_data_frame_guay_recien_creado)`, R will show you on the console the result, but the names won't be overwritten. You need to assign that result to the data frame with ` <- `. 


## What is a csv file

Excel is commonly used for working with tabular data. Excel files allow not only keeping data but also working with them, with formulas and plots. However, when working with too many rows or columns becomes herculean or even impossible (today, Excel doesn't even allow two million rows). When dealing with these not so large datasets, other formats will be needed for saving the data. However, while Excel has a set of tools for data analysis, these alternatives are only for saving data; for analyzing it, we need R (or other programming language and data software). 

Structure data is usually stored in a tabular format, i.e., in tables. One of the most commong tabular formats is csv (comma separated values). During the sessions we'll get into details on what a csv file looks like but, from a general point of view, what we need to know is that it is plain text: you can generate a csv file from scratch with the notepad. 

Imagine you have the already known `iris` dataset on a csv file (this file will have a name, as every file, but the extension will be `.csv`). It will look something like this: 


```r
Sepal.Length,Sepal.With,Petal.Length,Petal.Width,Species
5.1,3.5,1.4,0.2,setosa
4.9,3.0,1.4,0.2,setosa
4.7,3.2,1.3,0.2,setosa
```

Since it is not aligned, it is not intuitive realizing that we have three rows of the dataset. There are four rows but the first one is the titles of the columns. Each column is separated with a comma (this is the reason of the name of the format). For every new row, we press Enter at the end of the line.

We will now get into how to read this with R, so that such a file on our hard drive can be read onto memory (from disk to RAM, which is where R _almost always_ works).

## Reading a csv

On the `data` folder you have another file with the `iris` dataset, this time in csv format. 

There are some functions in R base for reading csv files but we won't use them. We will apply the `read_csv()`, from the `readr` package. 


```r
library(readr)
iris_csv <- read_csv("data/iris.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   sepal_length = col_double(),
##   sepal_width = col_double(),
##   petal_length = col_double(),
##   petal_width = col_double(),
##   species = col_character()
## )
```

**Exercise.**

- How many columns are there on the tibble?
- How many rows?
- What are the types of the columns? _Hint._ Use `class()`.

Depending on your computer's configuration, if you export a file from Excel to csv, the columns may be separated by commas or semicolon, and the decimal mark for numbers may be a point or a comma, respectively. 

**Exercise.** 
- Read the `iris2.csv` file with the `read_csv()` function. 
- How many columns are there? Which are their names? Does it make any sense?

## Reading other tabular data

### Another csv

Not always the character for separating columns will be a comma. In some countries, Spain for example, because of the format we usually use for numbers, instead of separating the columns of a csv file with commas, we use semicolons. Thus, we avoid issues with decimal numbers, since we use a comma for separating the integer and decimal part (in other countries, a point is used).

This file format is also called csv, but an alternative on the code must be typed:


```r
iris_csv <- read_csv2("data/iris2.csv") 
```

```
## ℹ Using "','" as decimal and "'.'" as grouping mark. Use `read_delim()` for more control.
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Sepal.Length = col_double(),
##   Sepal.Width = col_double(),
##   Petal.Length = col_double(),
##   Petal.Width = col_double(),
##   Species = col_character()
## )
```

### tsv

Another typical way of separating columns is using tab. It is not exactly a space for the computer, though our eyes may no detect many differences. The extension for these files usually is `.tsv.`.

In `readr` we can use `read_tsv()` function for this format.


```r
iris_tsv <- read_tsv("data/iris.tsv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Sepal.Length = col_double(),
##   Sepal.Width = col_double(),
##   Petal.Length = col_double(),
##   Petal.Width = col_double(),
##   Species = col_character()
## )
```

### Release your imagination

You have complete freedom when choosing a character for separating columns. A very typical one is `|`. For these alternatives, there is a general function in the `readr` package that allows you manually select the character that should be used: `read_delim()`. This function has two mandatory parameters: the path where you have the file stored and the character used for separations. 

**Remark.** For this file, the extension will usually be `.txt`, but you can invent it (e.g., `.sal`, for output in Spanish) or even nothing.


```r
iris_nuevo <- read_delim(file = "data/iris.txt", delim = "|")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Sepal.Length = col_double(),
##   Sepal.Width = col_double(),
##   Petal.Length = col_double(),
##   Petal.Width = col_double(),
##   Species = col_character()
## )
```

**Exercise.** On the `data` folder there is a file with no extension. Figure out the character used of separating the columns and read it.

## More things

Files don't have to be on your local computer always. You can also read files stored somewhere on the web.


```r
read_csv("https://github.com/tidyverse/readr/raw/master/inst/extdata/mtcars.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   mpg = col_double(),
##   cyl = col_double(),
##   disp = col_double(),
##   hp = col_double(),
##   drat = col_double(),
##   wt = col_double(),
##   qsec = col_double(),
##   vs = col_double(),
##   am = col_double(),
##   gear = col_double(),
##   carb = col_double()
## )
```

```
## # A tibble: 32 x 11
##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
##  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
##  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
##  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
##  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
##  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
##  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
##  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
##  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
## 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
## # … with 22 more rows
```

This dataset is very common in data analysis courses, such as _iris_. It contains information about a set of cars. You can read the details in the documentation: `? mtcars`.

**Exercise.** Check the classes of all the columns. 

Some columns have been considered by R as numeric but don't have decimal numbers. We should convert them to integer, since this type of object needs less space in memory than real numbers. We don't know yet how to change the columns of a data frame or tibble, but we can do these changed directly when reading the file. 

All the family of functions `read_*()` from the `readr` package guess the types of the columns (this may be explained during the sessions) but there is a way of forcing it: the `col_types` parameter.

There are a couple of ways of specifying these types. Here is an example for one. We use a character vector with one letter for each columns. The letters will represent the types: in this case, `n` for `numerical`, `i` for `integer` and `l` for `logical`.


```r
read_csv("https://github.com/tidyverse/readr/raw/master/inst/extdata/mtcars.csv", col_types = "ninnnnnilii")
```

```
## # A tibble: 32 x 11
##      mpg   cyl  disp    hp  drat    wt  qsec    vs am     gear  carb
##    <dbl> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <int> <lgl> <int> <int>
##  1  21       6  160    110  3.9   2.62  16.5     0 TRUE      4     4
##  2  21       6  160    110  3.9   2.87  17.0     0 TRUE      4     4
##  3  22.8     4  108     93  3.85  2.32  18.6     1 TRUE      4     1
##  4  21.4     6  258    110  3.08  3.22  19.4     1 FALSE     3     1
##  5  18.7     8  360    175  3.15  3.44  17.0     0 FALSE     3     2
##  6  18.1     6  225    105  2.76  3.46  20.2     1 FALSE     3     1
##  7  14.3     8  360    245  3.21  3.57  15.8     0 FALSE     3     4
##  8  24.4     4  147.    62  3.69  3.19  20       1 FALSE     4     2
##  9  22.8     4  141.    95  3.92  3.15  22.9     1 FALSE     4     2
## 10  19.2     6  168.   123  3.92  3.44  18.3     1 FALSE     4     4
## # … with 22 more rows
```
