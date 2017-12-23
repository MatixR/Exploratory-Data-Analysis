# Introducing the data ####
# __ Spam and num_char####
# Load packages
library(ggplot2)
library(dplyr)
library(openintro)

# Compute summary statistics
email %>%
  group_by(spam) %>%
  summarize(median(num_char), IQR(num_char))

# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()





# __ Spam and num_char interpretation #####

# * The median length of not-spam emails is greater than that of spam emails.





# __ Spam and !!! ####

# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarize(median(exclaim_mess), IQR(exclaim_mess))


# Create plot for spam and exclaim_mess
ggplot(email, aes(x = log(exclaim_mess + 0.01))) + 
  geom_histogram() +
  facet_wrap(~ spam)


   


# __ Spam and !!! interpretation ####

# * The most common value of ```exclaim_mess`` in both classes of email is zero
# (a ```log(exclaim_mess)`` of -4.6 after adding .01).

#* Even after a transformation, the distribution of exclaim_mess in both classes
#of email is right-skewed.

# * The typical number of exclamations in the not-spam group appears to be
# slightly higher than in the spam group.

# * here are more cases of not-spam in this dataset than spam.







# Check-in 1 ####

# __ Collapsing levels ####
# get a sense of its distribution
email$spam <- as.factor(email$spam)
table(email$image)

# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image > 0) %>%
  ggplot(aes(x = has_image, fill = spam)) +
  geom_bar(position = "fill")






# __ Image and spam interpretation ####
# An email without an image is more likely to be not-spam than spam.




# __ Data Integrity ####
 
# Design a simple test to determine if images count as attached files

# Test if images count as attachments
sum(email$image > email$attach)





# __ Answering questions with chains ####

# "Within non-spam emails, is the typical length of emails shorter for those
# that were sent to multiple people?"

email %>%
  filter(spam == 0) %>%
  group_by(to_multiple) %>%
  summarize(median(num_char))

# Question 1
email %>%
  filter(dollar > 0) %>%
  group_by(spam) %>%
  summarize(median(dollar))

# Question 2
email %>%
  filter(dollar > 10) %>%
  ggplot(aes(x = spam)) +
  geom_bar()





# Check-in 2 ####

# __ What's in a number? ####
 
# Reorder levels
email$number <- factor(email$number, levels = c("none", "small", "big"))

# Construct plot of number
ggplot(email, aes(x =  number)) + 
  geom_bar() + 
  facet_wrap(~ spam)




# __ What's in a number interpretation ####

# - Given that an email contains a small number, it is more likely to be not-spam.
# - Given that an email contains a big number, it is more likely to be not-spam.
# - Within both spam and not-spam, the most common number is a small one.