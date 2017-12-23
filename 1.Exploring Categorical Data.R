# Exploring categorical data ####
url_comics <- "https://assets.datacamp.com/production/course_1796/datasets/comics.csv"
download.file(url_comics, "comics.csv")

# __ Bar chart expectations ####

# Suppose you've asked 30 people, some young, some old, what their preferred
# flavor of pie is: apple or pumpkin. That data could be summarized in a
# side-by-side barchart. Here are three possibilities for how it might look.

# Which one of the barcharts shows no relationship between age and flavor? In
# other words, which shows that pie preference is the same for both young and
# old?

# -> Plot 1






# __ Contingency table review ####
library(ggplot2)
library(tibble)
comics <- read.csv("comics.csv",)
comics <- as_tibble(comics)

# Print the first rows of the data
comics 

# Check levels of align
levels(comics$align)

# Check the levels of gender
levels(comics$gender)

# Create a 2-way contingency table
(tab <- table(comics$align, comics$gender))





# __ Dropping levels ####

# Load dplyr
library(dplyr)

# Print tab
tab

# Remove align level
comics <- comics %>%
  filter(align != "Reformed Criminals") %>%
  droplevels()






# __ Side-by-side barcharts ####

# Load ggplot2
library(ggplot2)

# Create side-by-side barchart of gender by alignment
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "dodge")

# Create side-by-side barchart of alignment by gender
ggplot(comics, aes(x = gender, fill = align)) + 
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))





# __ Bar chart interpretation ####

# - Among characters with "Neutral" alignment, males are the most common.
# - In general, there is an association between gender and alignment.
# - There are more male characters than female characters in this dataset.







# Counts vs. proportions ####

# __ Conditional proportions ####

tab <- table(comics$align, comics$gender)
options(scipen = 999, digits = 3) # Print fewer digits
prop.table(tab)     # Joint proportions
prop.table(tab, 2)  # Conditional on columns


# Approximately what proportion of all female characters are good?
# -> 51%





# __ Counts vs. proportions (2) ####

# Bar charts can tell dramatically different stories depending on whether they
# represent counts or proportions and, if proportions, what the proportions are
# conditioned on. To demonstrate this difference, you'll construct two barcharts
# in this exercise: one of counts and one of proportions.


# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "fill") +
  ylab("proportion")







# Distribution of one variable ####

# __ Marginal barchart ####

# Change the order of the levels in align
comics$align <- factor(comics$align, 
                       levels = c("Bad", "Neutral", "Good"))

# Create plot of align
ggplot(comics, aes(x = align)) + 
  geom_bar()






# __ Conditional barchart ####

# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) + 
  geom_bar() +
  facet_wrap(~ gender)






# __ Improve piechart ####

apple <- rep("apple",17)
blueberry <- rep("blueberry", 14)
boston_creme <- rep("boston creme", 15)
cherry <- rep("cherry", 13)
key_lime <- rep("key lime", 16)
pumpkin <- rep("pumpkin", 12)
strawberry <- rep("strawberry", 11)


pies <- data.frame(c(apple, blueberry, boston_creme, cherry, key_lime, pumpkin, strawberry))
colnames(pies) <- "flavor"

pies <- data.frame("flavor" = c(rep("apple",17), 
                                 rep("blueberry", 14), 
                                 rep("boston creme", 15), 
                                 rep("cherry", 13),
                                 rep("key lime", 16),
                                 rep("pumpkin", 12),
                                 rep("strawberry", 11)
                                 ))

# Put levels of flavor in decending order
lev <- c("apple", "key lime", "boston creme", "blueberry", "cherry", "pumpkin", "strawberry")
pies$flavor <- factor(pies$flavor, levels = lev)

# Create barchart of flavor
ggplot(pies, aes(x = flavor)) + 
  geom_bar(fill = "chartreuse") + 
  theme(axis.text.x = element_text(angle = 90))