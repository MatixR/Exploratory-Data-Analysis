# Exploring numerical data ####
# url_cars <- "https://assets.datacamp.com/production/course_1796/datasets/cars04.csv"
# download.file(url_cars, "cars.csv")
cars <- read.csv("cars.csv")
str(cars)


# __ Faceted histogram ####
# Load package
library(ggplot2)

# Learn data structure
str(cars)

# Create faceted histogram
ggplot(cars, aes(x = city_mpg)) +
  geom_histogram() +
  facet_wrap(~ suv)




# __ Boxplots and density plots ####

# Filter cars with 4, 6, 8 cylinders
common_cyl <- filter(cars, ncyl %in% c(4,6,8))

# Create box plots of city mpg by ncyl
ggplot(common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) +
  geom_boxplot()

# Create overlaid density plots for same data
ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) +
  geom_density(alpha = .3)






# __ Compare distribution via plots ####

# Which of the following interpretations of the plot is not valid?

# * The highest mileage cars have 4 cylinders.
# * Most of the 4 cylinder cars get better mileage than even the most efficient 8 cylinder cars.
# * The typical 4 cylinder car gets better mileage than the typical 6 cylinder car, which gets better mileage than the typical 8 cylinder car.
# * The variability in mileage of 8 cylinder cars seem much smaller than that of 4 cylinder cars.







# Distribution of one variable ####

# __ Marginal and conditional histograms ####

# Create hist of horsepwr
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram() +
  ggtitle("Horsepower Distribution")

# Create hist of horsepwr for affordable cars
cars %>% 
  filter(msrp < 25000) %>%
  ggplot(aes(horsepwr)) +
  geom_histogram() +
  xlim(c(90, 550)) +
  ggtitle("Horsepower Distribution for cheap cars")





# __ Marginal and conditional histograms interpretation ####

# * The highest horsepower car in the less expensive range has just under 250 horsepower.
# * Cars with around 200 horsepower are more common than cars with around 300 horsepower.
# * Most cars under $25,000 vary from roughly 100 horsepower to roughly 250 horsepower.





# __ Three binwidths ####

# Create hist of horsepwr with binwidth of 3
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 3) +
  ggtitle("Bindwidth of 3")

# Create hist of horsepwr with binwidth of 30
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 30) +
  ggtitle("Bindwidth of 30")

# Create hist of horsepwr with binwidth of 60
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 60) +
  ggtitle("Bindwidth of 60")




# __ Three binwidths interpretation ####
# What feature is present in Plot A that's not found in B or C?
# * There is a tendency for cars to have horsepower right at 200 or 300 horsepower.






# Box plots ####

# __ Box plots for outliers ####
# Construct box plot of msrp
cars %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()

# Exclude outliers from data
cars_no_out <- cars %>%
  filter(msrp < 100000)

# Construct box plot of msrp using the reduced dataset
cars_no_out %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()






# __ Plot selection #####
# Create plot of city_mpg
cars %>%
  ggplot(aes(x = 1, y = city_mpg)) +
  geom_boxplot()

# Create plot of width
cars %>% 
  ggplot(aes(x = width)) +
  geom_density()

# Because the ```city_mpg``` variable has a much wider range with its outliers,
# it's best to display its distribution as a box plot.






# Visualization in higher dimensions ####

# __ 3 variable plot ####
# Facet hists using hwy mileage and ncyl
common_cyl %>%
  ggplot(aes(x = hwy_mpg)) +
  geom_histogram() +
  facet_grid(ncyl ~ suv) +
  ggtitle("ncyl vs suv")





# __ Interpret 3 var plot ####

# Which of the following interpretations of the plot is valid?

