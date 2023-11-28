library(tidyverse)

###Three parameters (longer):
###  1. The set of columns whos names are values, not variables.
###  2. The name of the variable to move the column names to
### 3. The name of the variable to move the column values to
  
###Two parameters (wider):
###  1. The column to take variable names from
###  2. The column to take values from


#  12.3.3
## 1. pivot_longer and pivot_wider are not symmetrical because of the 
##    examples we saw. For one we want to be expanding out the columns 
##    to separate the data as needed and for another we need to combine 
##    columns as needed. So a single column may become two columns or two 
##    columns may become one.

## 2. Those columns don't exist in that table. Earlier in the reading
##    we left_joined the two into a table that does not have 1999 or 2000
##    as a column to select.

## 3. It would throw an error because there is not a unique value for
##    Phillip Woods' age. We need one unique value for each "names" to widen
##    the table. I would remove the non-unique value or I would add a function
##    to identify only one unique value and ignore the rest.

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people %>%
  pivot_wider(names_from = names, values_from = values)

## 4. I made it longer because sex/gender really only needs to be one row
##    and so does the count of if that gender is pregnant or not.
##    The variables are male/female and yes/no which became sex and count.

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

preg %>% 
  pivot_longer(c(`male`, `female`), names_to = "sex", values_to = "count")

