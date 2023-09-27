# *****************************************************************************
# Lab 2.b.: Exploratory Data Analysis for Qualitative Data ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi_at_strathmore_dot_edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************

# **[OPTIONAL] Initialization: Install and use renv ----
# The R Environment ("renv") package helps you create reproducible environments
# for your R projects. This is helpful when working in teams because it makes
# your R projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# "renv" It can be installed as follows:
# if (!is.element("renv", installed.packages()[, 1])) {
# install.packages("renv", dependencies = TRUE,
repos = "https://cloud.r-project.org") # nolint
# }
# require("renv") # nolint

# Once installed, you can then use renv::init() to initialize renv in a new
# project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
# renv::init() # nolint

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open the project.

# Consider a library as the location where packages are stored.
# Execute the following command to list all the libraries available in your
# computer:
.libPaths()

# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., "BBT4206-R.Rproj" in the case of this project. Then
# navigate to the "Environments" tab and select "Use renv with this project".

# As you continue to work on your project, you can install and upgrade
# packages, using either:
# install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# [OPTIONAL]
# Execute the following code to reinstall the specific package versions
# recorded in the lockfile (restart R after executing the command):
# renv::restore() # nolint

# [OPTIONAL]
# If you get several errors setting up renv and you prefer not to use it, then
# you can deactivate it using the following command (restart R after executing
# the command):
# renv::deactivate() # nolint

# If renv::restore() did not install the "languageserver" package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE,
  repos = "https://cloud.r-project.org")
}
require("languageserver")

# Methods used for sentiment analysis include:
# (i) Training a known dataset
# (ii) Creating your own classifiers with rules
# (iii) Using predefined lexical dictionaries (lexicons); a lexicon approach

# Levels of sentiment analysis include:
# (i) Document
# (ii) Sentence
# (iii) Word


# STEP 1. Install and Load the Required Packages ----
# The following packages can be installed and loaded before proceeding to the
# subsequent steps.

## dplyr - For data manipulation ----
if (!is.element("dplyr", installed.packages()[, 1])) {
  install.packages("dplyr", dependencies = TRUE,
  repos = "https://cloud.r-project.org")
}
require("dplyr")

## ggplot2 - For data visualizations using the Grammar for Graphics package ----
if (!is.element("ggplot2", installed.packages()[, 1])) {
install.packages("ggplot2", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("ggplot2")

## ggrepel - Additional options for the Grammar for Graphics package ----
if (!is.element("ggrepel", installed.packages()[, 1])) {
install.packages("ggrepel", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("ggrepel")

## ggraph - Additional options for the Grammar for Graphics package ----
if (!is.element("ggraph", installed.packages()[, 1])) {
install.packages("ggraph", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("ggraph")

## tidytext - For text mining ----
if (!is.element("tidytext", installed.packages()[, 1])) {
install.packages("tidytext", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("tidytext")

## tidyr - To tidy messy data ----
if (!is.element("tidyr", installed.packages()[, 1])) {
install.packages("tidyr", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("tidyr")

## widyr - To widen, process, and re-tidy a dataset ----
if (!is.element("widyr", installed.packages()[, 1])) {
install.packages("widyr", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("widyr")

## gridExtra - to arrange multiple grid-based plots on a page ----
if (!is.element("gridExtra", installed.packages()[, 1])) {
install.packages("gridExtra", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("gridExtra")

## knitr - for dynamic report generation ----
if (!is.element("knitr", installed.packages()[, 1])) {
install.packages("knitr", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("knitr")

## kableExtra - for nicely formatted output tables ----
if (!is.element("kableExtra", installed.packages()[, 1])) {
install.packages("kableExtra", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("kableExtra")

## formattable -  To create a formattable object ----
# A formattable object is an object to which a formatting function and related
# attributes are attached.
if (!is.element("formattable", installed.packages()[, 1])) {
install.packages("formattable", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("formattable")

## circlize - To create a cord diagram or visualization ----
# by Gu et al. (2014)
if (!is.element("circlize", installed.packages()[, 1])) {
install.packages("circlize", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("circlize")

## memery - For creating data analysis related memes ----
# The memery package generates internet memes that optionally include a
# superimposed inset plot and other atypical features, combining the visual
# impact of an attention-grabbing meme with graphic results of data analysis.
if (!is.element("memery", installed.packages()[, 1])) {
install.packages("memery", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("memery")

## magick - For image processing in R ----
if (!is.element("magick", installed.packages()[, 1])) {
install.packages("magick", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("magick")

## yarrr - To create a pirate plot ----
if (!is.element("yarrr", installed.packages()[, 1])) {
install.packages("yarrr", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("yarrr")

## radarchart - To create interactive radar charts using ChartJS ----
if (!is.element("radarchart", installed.packages()[, 1])) {
install.packages("radarchart", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("radarchart")

## igraph - To create ngram network diagrams ----
if (!is.element("igraph", installed.packages()[, 1])) {
install.packages("igraph", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("igraph")

## wordcloud2 - For creating wordcloud by using 'wordcloud2.JS ----
if (!is.element("wordcloud2", installed.packages()[, 1])) {
install.packages("wordcloud2", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("wordcloud2")

## readr - Load datasets from CSV files ----
if (!is.element("readr", installed.packages()[, 1])) {
install.packages("readr", dependencies = TRUE,
repos = "https://cloud.r-project.org")
}
require("readr")

# STEP 2. Customize the Visualizations, Tables, and Colour Scheme ----
# The following defines a blue-grey colour scheme for the visualizations:
## shades of blue and shades of grey
blue_grey_colours_11 <- c("#27408E", "#304FAF", "#536CB5", "#6981c7", "#8da0db",
                          "#dde5ec", "#c8c9ca", "#B9BCC2", "#A7AAAF", "#888A8E",
                          "#636569")

blue_grey_colours_6 <- c("#27408E", "#304FAF", "#536CB5",
                         "#B9BCC2", "#A7AAAF", "#888A8E")

blue_grey_colours_4 <- c("#27408E", "#536CB5",
                         "#B9BCC2", "#888A8E")

blue_grey_colours_3 <- c("#6981c7", "#304FAF", "#888A8E")

blue_grey_colours_2 <- c("#27408E",
                         "#888A8E")

blue_grey_colours_1 <- c("#6981c7")

# Custom theme for visualizations
blue_grey_theme <- function() {
  theme(
    axis.ticks = element_line(
                              linewidth = 1, linetype = "dashed",
                              lineend = NULL, color = "#dfdede",
                              arrow = NULL, inherit.blank = FALSE),
    axis.text = element_text(
                             face = "bold", color = "#3f3f41",
                             size = 12, hjust = 0.5),
    axis.title = element_text(face = "bold", color = "#3f3f41",
                              size = 14, hjust = 0.5),
    plot.title = element_text(face = "bold", color = "#3f3f41",
                              size = 16, hjust = 0.5),
    panel.grid = element_line(
                              linewidth = 0.1, linetype = "dashed",
                              lineend = NULL, color = "#dfdede",
                              arrow = NULL, inherit.blank = FALSE),
    panel.background = element_rect(fill = "#f3eeee"),
    legend.title = element_text(face = "plain", color = "#3f3f41",
                                size = 12, hjust = 0),
    legend.position = "right"
  )
}

# Customize the text tables for consistency using HTML formatting
kable_theme <- function(dat, caption) {
  kable(dat, "html", escape = FALSE, caption = caption) %>%
    kable_styling(bootstrap_options = c("striped", "condensed", "bordered"),
                  full_width = FALSE)
}

# STEP 3. Load the Dataset ----
student_performance_dataset <-
  readr::read_csv(
                  "data/20230412-20230719-BI1-BBIT4-1-StudentPerformanceDataset.CSV", # nolint
                  col_types =
                  readr::cols(
                              class_group =
                              readr::col_factor(levels = c("A", "B", "C")),
                              gender = readr::col_factor(levels = c("1", "0")),
                              YOB = readr::col_date(format = "%Y"),
                              regret_choosing_bi =
                              readr::col_factor(levels = c("1", "0")),
                              drop_bi_now =
                              readr::col_factor(levels = c("1", "0")),
                              motivator =
                              readr::col_factor(levels = c("1", "0")),
                              read_content_before_lecture =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              anticipate_test_questions =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              answer_rhetorical_questions =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              find_terms_I_do_not_know =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              copy_new_terms_in_reading_notebook =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              take_quizzes_and_use_results =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              reorganise_course_outline =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              write_down_important_points =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              space_out_revision =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              studying_in_study_group =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              schedule_appointments =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              goal_oriented =
                              readr::col_factor(levels =
                                                c("1", "0")),
                              spaced_repetition =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              testing_and_active_recall =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              interleaving =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              categorizing =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              retrospective_timetable =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              cornell_notes =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4")),
                              sq3r = readr::col_factor(levels =
                                                       c("1", "2", "3", "4")),
                              commute = readr::col_factor(levels =
                                                          c("1", "2",
                                                            "3", "4")),
                              study_time = readr::col_factor(levels =
                                                             c("1", "2",
                                                               "3", "4")),
                              repeats_since_Y1 = readr::col_integer(),
                              paid_tuition = readr::col_factor(levels =
                                                               c("0", "1")),
                              free_tuition = readr::col_factor(levels =
                                                               c("0", "1")),
                              extra_curricular = readr::col_factor(levels =
                                                                   c("0", "1")),
                              sports_extra_curricular =
                              readr::col_factor(levels = c("0", "1")),
                              exercise_per_week = readr::col_factor(levels =
                                                                    c("0", "1",
                                                                      "2",
                                                                      "3")),
                              meditate = readr::col_factor(levels =
                                                           c("0", "1",
                                                             "2", "3")),
                              pray = readr::col_factor(levels =
                                                       c("0", "1",
                                                         "2", "3")),
                              internet = readr::col_factor(levels =
                                                           c("0", "1")),
                              laptop = readr::col_factor(levels = c("0", "1")),
                              family_relationships =
                              readr::col_factor(levels =
                                                c("1", "2", "3", "4", "5")),
                              friendships = readr::col_factor(levels =
                                                              c("1", "2", "3",
                                                                "4", "5")),
                              romantic_relationships =
                              readr::col_factor(levels =
                                                c("0", "1", "2", "3", "4")),
                              spiritual_wellnes =
                              readr::col_factor(levels = c("1", "2", "3",
                                                           "4", "5")),
                              financial_wellness =
                              readr::col_factor(levels = c("1", "2", "3",
                                                           "4", "5")),
                              health = readr::col_factor(levels = c("1", "2",
                                                                    "3", "4",
                                                                    "5")),
                              day_out = readr::col_factor(levels = c("0", "1",
                                                                     "2", "3")),
                              night_out = readr::col_factor(levels = c("0",
                                                                       "1", "2",
                                                                       "3")),
                              alcohol_or_narcotics =
                              readr::col_factor(levels = c("0", "1", "2", "3")),
                              mentor = readr::col_factor(levels = c("0", "1")),
                              mentor_meetings = readr::col_factor(levels =
                                                                  c("0", "1",
                                                                    "2", "3")),
                              `Attendance Waiver Granted: 1 = Yes, 0 = No` =
                              readr::col_factor(levels = c("0", "1")),
                              GRADE = readr::col_factor(levels =
                                                        c("A", "B", "C", "D",
                                                          "E"))),
                  locale = readr::locale())

View(student_performance_dataset)

# Dimensions
dim(student_performance_dataset)

# Data Types
sapply(student_performance_dataset, class)
glimpse(student_performance_dataset)

# Summary of each variable
summary(student_performance_dataset)

# STEP 4. Create a subset of the data using the "dplyr" package ----
## The "dplyr" Package ----
# We will also require the "dplyr" package

# "dplyr" is a grammar of *data manipulation*, providing a consistent set of
# verbs that help you solve the most common data manipulation challenges:
#   mutate() adds new variables that are functions of existing variables
#   select() picks variables based on their names.
#   group_by() groups the data into categories
#   filter() picks cases based on their values.
#   summarise() reduces multiple values down to a single summary.
#   arrange() changes the ordering of the rows.

# Documentation of "dplyr":
#   https://cran.r-project.org/package=dplyr or
#   https://github.com/tidyverse/dplyr

## The Pipe Operator in the "dplyr" Package ----
# In R, the %>% symbol represents the pipe operator.
# The pipe operator is used for chaining or piping operations together in a
# way that enhances the readability and maintainability of code. It is
# useful when working with data manipulation and data transformation tasks.

# The %>% operator takes the result of the expression on its left and passes it
# as the first argument to the function on its right. This allows you to chain
# together a sequence of operations on a dataset or object.

# For example:
# Example 1:
# library(dplyr) # Load the dplyr package (which uses %>%) # nolint

# result <- df %>%
#   filter(age > 30) %>%   # Filter rows where age is greater than 30
#   group_by(gender) %>%  # Group the data by gender
#   summarise(mean_salary = mean(salary))  # Calculate the mean salary for each group # nolint

# # 'result' now contains the result of these operations

# Example 2:
# nhanes_dataset <- nhanes_dataset %>%
#   mutate(MAP = BPDiaAve + (1 / 3) * (BPSysAve - BPDiaAve)) # nolint

evaluation_per_group_per_gender <- student_performance_dataset %>% # nolint
  mutate(`Student's Gender` =
           ifelse(gender == 1, "Male", "Female")) %>%
  select(class_group, gender,
         `Student's Gender`, `Average Course Evaluation Rating`) %>%
  filter(!is.na(`Average Course Evaluation Rating`)) %>%
  group_by(class_group, `Student's Gender`) %>%
  summarise(average_evaluation_rating =
              mean(`Average Course Evaluation Rating`)) %>%
  arrange(desc(average_evaluation_rating), .by_group = TRUE)

# Plain tabular output
View(evaluation_per_group_per_gender)

# Decorated tabular output
evaluation_per_group_per_gender %>%
  rename(`Class Group` = class_group) %>%
  rename(`Average Course Evaluation Rating` = average_evaluation_rating) %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`) %>%
  mutate(`Average Course Evaluation Rating` =
           color_tile("#B9BCC2", "#536CB5")
           (`Average Course Evaluation Rating`)) %>%
  kable("html", escape = FALSE, align = "c",
        caption = "Course Evaluation Rating per Group and per Gender") %>%
  kable_styling(bootstrap_options =
                  c("striped", "condensed", "bordered"),
                full_width = FALSE)

# Decorated visual bar chart
evaluation_per_group_per_gender %>%
  ggplot() +
  geom_bar(aes(x = class_group, y = average_evaluation_rating,
               fill = `Student's Gender`),
           stat = "identity", position = "dodge") +
  expand_limits(y = 0) +
  blue_grey_theme() +
  scale_fill_manual(values = blue_grey_colours_2) +
  ggtitle("Course Evaluation Rating per Group and per Gender") +
  labs(x = "Class Group", y = "Average Rating")

# STEP 5. Data Cleansing for Qualitative Data ----
## Contractions ----

# Contractions in the English language are shortened forms of words or phrases
# created by combining two words and replacing one or more letters with an
# apostrophe ('), often for the purpose of making speech or writing more
# concise and informal. Contractions are often used in informal speech and
# writing but are generally avoided in formal writing, such as academic papers
# or business reports.

# A function to expand contractions in an English-language source (assuming
# that the students did not respond in sheng or Kiswahili).
expand_contractions <- function(doc) {
  doc <- gsub("I'm", "I am", doc, ignore.case = TRUE)
  doc <- gsub("you're", "you are", doc, ignore.case = TRUE)
  doc <- gsub("he's", "he is", doc, ignore.case = TRUE)
  doc <- gsub("she's", "she is", doc, ignore.case = TRUE)
  doc <- gsub("it's", "it is", doc, ignore.case = TRUE)
  doc <- gsub("we're", "we are", doc, ignore.case = TRUE)
  doc <- gsub("they're", "they are", doc, ignore.case = TRUE)
  doc <- gsub("I'll", "I will", doc, ignore.case = TRUE)
  doc <- gsub("you'll", "you will", doc, ignore.case = TRUE)
  doc <- gsub("he'll", "he will", doc, ignore.case = TRUE)
  doc <- gsub("she'll", "she will", doc, ignore.case = TRUE)
  doc <- gsub("it'll", "it will", doc, ignore.case = TRUE)
  doc <- gsub("we'll", "we will", doc, ignore.case = TRUE)
  doc <- gsub("they'll", "they will", doc, ignore.case = TRUE)
  doc <- gsub("won't", "will not", doc, ignore.case = TRUE)
  doc <- gsub("can't", "cannot", doc, ignore.case = TRUE)
  doc <- gsub("n't", " not", doc, ignore.case = TRUE)
  return(doc)
}

# Evaluation likes and wishes
evaluation_likes_and_wishes <- student_performance_dataset %>%
  mutate(`Student's Gender` =
           ifelse(gender == 1, "Male", "Female")) %>%
  rename(`Class Group` = class_group) %>%
  rename(Likes = `D - 1. \nWrite two things you like about the teaching and learning in this unit so far.`) %>% # nolint
  rename(Wishes = `D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)`) %>% # nolint
  select(`Class Group`,
         `Student's Gender`, `Average Course Evaluation Rating`,
         Likes, Wishes) %>%
  filter(!is.na(`Average Course Evaluation Rating`)) %>%
  arrange(`Class Group`)

# Before expanding contractions (See row number 4)
View(evaluation_likes_and_wishes)

evaluation_likes_and_wishes$Likes <- sapply(evaluation_likes_and_wishes$Likes, expand_contractions) # nolint
evaluation_likes_and_wishes$Wishes <- sapply(evaluation_likes_and_wishes$Wishes, expand_contractions) # nolint

# After expanding contractions
View(evaluation_likes_and_wishes)

## Special Characters and Lower Case ----
# NOTE: The special characters should be removed *after* expanding the
# contractions

# A function to remove special characters
# Remember the use of regular expressions in the
# BBT3104: Advanced Database Systems course

# A tutorial on regular expressions: https://regexone.com/
# To test your regular expression: https://regexr.com/

remove_special_characters <- function(doc) {
  gsub("[^a-zA-Z0-9 ]", "", doc, ignore.case = TRUE)
}

# Before removing special characters (See row number 11)
View(evaluation_likes_and_wishes)

evaluation_likes_and_wishes$Likes <- sapply(evaluation_likes_and_wishes$Likes, remove_special_characters) # nolint
evaluation_likes_and_wishes$Wishes <- sapply(evaluation_likes_and_wishes$Wishes, remove_special_characters) # nolint

# Convert everything to lower case (to standardize the text)
evaluation_likes_and_wishes$Likes <- sapply(evaluation_likes_and_wishes$Likes, tolower) # nolint
evaluation_likes_and_wishes$Wishes <- sapply(evaluation_likes_and_wishes$Wishes, tolower) # nolint

# After removing special characters and converting everything to lower case
View(evaluation_likes_and_wishes)

# [OPTIONAL] You can save the file as a CSV at this point
write.csv(evaluation_likes_and_wishes,
          file = "data/evaluation_likes_and_wishes.csv",
          row.names = FALSE)

## Stemming/Lemmatization ----
# Stemming is a text processing technique used to reduce words to their base or
# root form, known as the "stem."
# The goal of stemming is to simplify words to their common linguistic root,
# which can help improve text analysis and Information Retrieval by treating
# different inflections or variations of a word as the same word.

# Stemming groups together words with the same meaning but different
# grammatical forms. For example, stemming can convert words like "jumping,"
# "jumps," and "jumped" to the common stem "jump."

# [CAUTION] Stemming is a simple and heuristic-based approach and may not always
# produce accurate results. In some cases, it may produce stems that are not
# actual words or may result in ambiguity. For this reason, more advanced
# techniques like *lemmatization*, which considers the context and grammatical
# structure of words, are often preferred for certain Natural Language
# Processing (NLP) tasks.

# Summary:
#  (i) Stemming: generally refers to removing suffixes from words to get the
#      common origin
#  (ii) Lemmatization: reducing inflected (or sometimes derived) words to their
#       word stem, base or root form
#  (iii) Word replacement: replace words with more frequently used synonyms

## Tokenization ----
# The goal of text mining is to discover relevant information that is possibly
# unknown or hidden. Natural Language Processing (NLP) is one methodology used
# in text mining. It attempts to decipher the ambiguities in written language
# by:
#   (i) tokenization
#   (ii) clustering
#   (iii) extracting entity and word relationships
#   (iv) using algorithms to identify themes and quantify subjective
#        information.

# Tokenization is the process of breaking out text into smaller meaningful
# units called tokens.

# In addition to expanding (removing) contractions, removing special
# characters, converting all text to lower case, and stemming/lemmatization,
# tokenization can also be performed as part of data cleansing for qualitative
# data.

# Tokenization is a crucial step in NLP because it allows text data to be
# represented in a format that can be used for further analysis and machine
# learning tasks. It forms the basis for many text processing techniques and is
# essential for understanding and working with textual data in computational
# applications.

## Stopword Removal, Short Word Removal, and Censorship ----

# A stopword is a commonly used word that is usually filtered out during text
# mining to improve the efficiency and focus of text analysis.
# Stopwords are words that are considered to be of little value in many text
# analysis tasks because they are frequently used in the language and do not
# carry significant meaning on their own.
# Examples of stopwords in English include:
# "the," "and," "is," "in," "it," "of," "to," "for," and "with."

# Additional examples can be seen here:
head(sample(stop_words$word, 20), 20)

# You can also create a list of words that you would like to censor
undesirable_words <- c("wow", "lol", "none", "na")

evaluation_likes_filtered <- evaluation_likes_and_wishes %>% # nolint
  # We start by tokenization (un-nesting words). This is from the variable
  # "Like" into the variable "word".
  unnest_tokens(word, Likes) %>%
  # Then we remove stopwords using an anti-join (remember this from the
  # BBT3104: Advanced Database Systems course)
  # Anti-join: do not join where the word is in the list of stopwords
  anti_join(stop_words, by = c("word")) %>%
  distinct() %>%
  # Censor or filter out unwanted words
  filter(!word %in% undesirable_words) %>%
  # Include only words that are more than 3 characters long (assuming that
  # these are the words that are meaningful)
  filter(nchar(word) > 3) %>%
  # We then rename the variable "word" for ease of use.
  rename(`Likes (tokenized)` = word) %>%
  # We focus only on the likes in this data frame
  select(-Wishes)

# Lastly, we save the created data frame as a CSV file:
write.csv(evaluation_likes_filtered,
          file = "data/evaluation_likes_filtered.csv",
          row.names = FALSE)

# The same is done to create a data frame for the "wishes" only
evaluation_wishes_filtered <- evaluation_likes_and_wishes %>% # nolint
  unnest_tokens(word, Wishes) %>%
  anti_join(stop_words, by = c("word")) %>%
  distinct() %>%
  filter(!word %in% undesirable_words) %>%
  filter(nchar(word) > 3) %>%
  rename(`Wishes (tokenized)` = word) %>%
  select(-Likes)

write.csv(evaluation_wishes_filtered,
          file = "data/evaluation_wishes_filtered.csv",
          row.names = FALSE)

# STEP 6. Word Count ----
## Evaluation Likes ----
### Word count per gender ----
word_count_per_gender_likes <- evaluation_likes_filtered %>%
  group_by(`Student's Gender`) %>%
  summarise(num_words = n()) %>%
  arrange(desc(num_words))

word_count_per_gender_likes %>%
  mutate(num_words = color_bar("lightblue")(num_words)) %>%
  rename(`Number of Words` = num_words) %>%
  kable("html", escape = FALSE, align = "c",
        caption = "Number of Significant Words in Evaluation Likes 
                   per Gender: Minus contractions, special characters, 
                   stopwords, short words, and censored words.") %>%
  kable_styling(bootstrap_options =
                  c("striped", "condensed", "bordered"),
                full_width = FALSE)

### Word count per group ----
word_count_per_group <- evaluation_likes_filtered %>%
  group_by(`Class Group`) %>%
  summarise(num_words = n()) %>%
  arrange(desc(num_words))

word_count_per_group %>%
  mutate(num_words = color_bar("lightblue")(num_words)) %>%
  rename(`Number of Words` = num_words) %>%
  kable("html", escape = FALSE, align = "c",
        caption = "Number of Significant Words in Evaluation Likes 
                   per Group: Minus contractions, special characters, 
                   stopwords, short words, and censored words.") %>%
  kable_styling(bootstrap_options =
                  c("striped", "condensed", "bordered"),
                full_width = FALSE)

## Evaluation Wishes ----
### Word count per gender ----
word_count_per_gender_wishes <- evaluation_wishes_filtered %>%
  group_by(`Student's Gender`) %>%
  summarise(num_words = n()) %>%
  arrange(desc(num_words))

word_count_per_gender_wishes %>%
  mutate(num_words = color_bar("lightblue")(num_words)) %>%
  rename(`Number of Words` = num_words) %>%
  kable("html", escape = FALSE, align = "c",
        caption = "Number of Significant Words in Evaluation Wishes 
                   per Gender: Minus contractions, special characters, 
                   stopwords, short words, and censored words.") %>%
  kable_styling(bootstrap_options =
                  c("striped", "condensed", "bordered"),
                full_width = FALSE)

### Word count per group ----
word_count_per_group_wishes <- evaluation_wishes_filtered %>%
  group_by(`Class Group`) %>%
  summarise(num_words = n()) %>%
  arrange(desc(num_words))

word_count_per_group_wishes %>%
  mutate(num_words = color_bar("lightblue")(num_words)) %>%
  rename(`Number of Words` = num_words) %>%
  kable("html", escape = FALSE, align = "c",
        caption = "Number of Significant Words in Evaluation Wishes 
                   per Group: Minus contractions, special characters, 
                   stopwords, short words, and censored words.") %>%
  kable_styling(bootstrap_options =
                  c("striped", "condensed", "bordered"),
                full_width = FALSE)

# STEP 7. Top Words ----
## Evaluation Likes ----
### Top 10 words for female students ----
evaluation_likes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  filter(`Student's Gender` == "Female") %>%
  count(`Likes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Likes (tokenized)` = reorder(`Likes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Likes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes for Female
          Students") +
  coord_flip()

### Top 10 words for male students ----
evaluation_likes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  filter(`Student's Gender` == "Male") %>%
  count(`Likes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Likes (tokenized)` = reorder(`Likes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Likes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes for Male
          Students") +
  coord_flip()

### Top 10 words per gender ----
popular_words <- evaluation_likes_filtered %>%
  group_by(`Student's Gender`) %>%
  count(`Likes (tokenized)`, `Student's Gender`, sort = TRUE) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Student's Gender`, n) %>%
  mutate(row = row_number())

popular_words %>%
  ggplot(aes(row, n, fill = `Student's Gender`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation",
       y = "Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes per Gender") +
  facet_wrap(~`Student's Gender`, scales = "free") +
  scale_x_continuous(
                     breaks = popular_words$row,
                     labels = popular_words$`Likes (tokenized)`) +
  coord_flip()

### Top words for Group A students ----
evaluation_likes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  filter(`Class Group` == "A") %>%
  count(`Likes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Likes (tokenized)` = reorder(`Likes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Likes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes for Group A
          Students") +
  coord_flip()

### Top words for Group B students ----
evaluation_likes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  filter(`Class Group` == "B") %>%
  count(`Likes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Likes (tokenized)` = reorder(`Likes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Likes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes for Group B
          Students") +
  coord_flip()

### Top words for Group C students ----
evaluation_likes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  filter(`Class Group` == "C") %>%
  count(`Likes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Likes (tokenized)` = reorder(`Likes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Likes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes for Group C
          Students") +
  coord_flip()

### Top 10 words per group ----
popular_words <- evaluation_likes_filtered %>%
  group_by(`Class Group`) %>%
  count(`Likes (tokenized)`, `Class Group`, sort = TRUE) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Class Group`, n) %>%
  mutate(row = row_number())

popular_words %>%
  ggplot(aes(row, n, fill = `Class Group`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation", y = "Number of Times Used") +
  ggtitle("Most Frequently Used Words in Course Evaluation Likes per 
          Class Group") +
  facet_wrap(~`Class Group`, scales = "free") +
  scale_x_continuous(
                     breaks = popular_words$row,
                     labels = popular_words$`Likes (tokenized)`) +
  coord_flip()

## Evaluation Wishes ----
### Top 10 words for female students ----
evaluation_wishes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  filter(`Student's Gender` == "Female") %>%
  count(`Wishes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Wishes (tokenized)` = reorder(`Wishes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Wishes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes for Female
          Students") +
  coord_flip()

### Top 10 words for male students ----
evaluation_wishes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  filter(`Student's Gender` == "Male") %>%
  count(`Wishes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Wishes (tokenized)` = reorder(`Wishes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Wishes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes for Male
          Students") +
  coord_flip()

### Top 10 words per gender ----
popular_words <- evaluation_wishes_filtered %>%
  group_by(`Student's Gender`) %>%
  count(`Wishes (tokenized)`, `Student's Gender`, sort = TRUE) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Student's Gender`, n) %>%
  mutate(row = row_number())

popular_words %>%
  ggplot(aes(row, n, fill = `Student's Gender`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation", y = "Number of Times Used") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes per Gender") +
  facet_wrap(~`Student's Gender`, scales = "free") +
  scale_x_continuous(
                     breaks = popular_words$row,
                     labels = popular_words$`Wishes (tokenized)`) +
  coord_flip()

### Top words for Group A students ----
evaluation_wishes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  filter(`Class Group` == "A") %>%
  count(`Wishes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Wishes (tokenized)` = reorder(`Wishes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Wishes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes for Group A
          Students") +
  coord_flip()

### Top words for Group B students ----
evaluation_wishes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  filter(`Class Group` == "B") %>%
  count(`Wishes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Wishes (tokenized)` = reorder(`Wishes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Wishes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes for Group B
          Students") +
  coord_flip()

### Top words for Group C students ----
evaluation_wishes_filtered %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  filter(`Class Group` == "C") %>%
  count(`Wishes (tokenized)`, sort = TRUE) %>%
  top_n(9) %>%
  mutate(`Wishes (tokenized)` = reorder(`Wishes (tokenized)`, n)) %>%
  ggplot() +
  geom_col(aes(`Wishes (tokenized)`, n), fill = blue_grey_colours_1) +
  blue_grey_theme() +
  xlab("Word in Course Evaluation") +
  ylab("Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes for Group C
          Students") +
  coord_flip()

### Top 10 words per group ----
popular_words <- evaluation_wishes_filtered %>%
  group_by(`Class Group`) %>%
  count(`Wishes (tokenized)`, `Class Group`, sort = TRUE) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Class Group`, n) %>%
  mutate(row = row_number())

popular_words %>%
  ggplot(aes(row, n, fill = `Class Group`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation",
       y = "Number of Times Used (Term Frequency)") +
  ggtitle("Most Frequently Used Words in Course Evaluation Wishes per 
          Class Group") +
  facet_wrap(~`Class Group`, scales = "free") +
  scale_x_continuous(
                     breaks = popular_words$row,
                     labels = popular_words$`Wishes (tokenized)`) +
  coord_flip()

# STEP 8. Word Cloud ----

# Word clouds are visually appealing and can provide a quick, intuitive
# representation of the most frequently occurring words in a text or dataset.

# [CAUTION] However, they also have several disadvantages:
#   1. Lack of context
#   2. Loss of quantitative information
#   3. Insensitive to word importance
#   4. Difficulty in handling large datasets
#   5. Ineffective for sentiment analysis
#   6. Ambiguity
#   7. Limited customization
#   8. Subjectivity
#   9. Difficulty in multilingual texts
#   10. Statistical limitations

## Evaluation Likes ----
evaluation_likes_filtered_cloud <- evaluation_likes_filtered %>% # nolint
  count(`Likes (tokenized)`, sort = TRUE)

wordcloud2(evaluation_likes_filtered_cloud, size = .5)

## Evaluation Wishes ----
evaluation_wishes_filtered_cloud <- evaluation_wishes_filtered %>% # nolint
  count(`Wishes (tokenized)`, sort = TRUE)

wordcloud2(evaluation_wishes_filtered_cloud, size = .5)

# STEP 9. Term Frequency - Inverse Document Frequency (TF-IDF) ----
# We need to quantify just how important various terms are in each comment with
# respect to all the comments made.

# TF-IDF is used to evaluate the importance of a word in a document relative to
# a collection of documents (a collection of documents is called a corpus).
# By doing so, TF-IDF helps identify how significant a word is within a
# particular document compared to its general frequency in a set of documents.

# The assumption behind TF-IDF is that terms that appear more frequently in a
# document (or a comment in this case) should be given a higher weight, unless
# it also appears in many other documents (or many other comments in this
# case).

## Term Frequency (TF) ----
# This measures how often a word appears in a specific document. Words that
# occur frequently within a document are likely to be important in describing
# the content of that document.

### Formula for TF ----
# (Number of times a term appears in a document) /
#   (Total number of terms in the document)

## Inverse Document Frequency (IDF) ----
# This measures how unique or rare a word is across a collection of documents.
# Words that are rare across many documents but present in one specific
# document are considered more valuable in distinguishing that document from
# others.

### Formula for IDF ----
# log((Total number of documents in the corpus) /
#   (Number of documents containing the term))

## TF-IDF Score ----
# The TF-IDF score combines both TF and IDF. It assigns a higher score to words
# that have high frequency within a document (TF) but are relatively rare in
# other documents (IDF). These are the words that are considered most important
# for describing the content of a particular document.

### Formula for TF-IDF ----
# The formula is: TF * IDF
# In essence, TF-IDF helps identify words that are both frequent within a
# document and distinctive across a corpus. These words are often considered to
# be the keywords or key terms that best represent the content or topic of the
# document.

## Example of TF-IDF ----
# Consider a collection of news articles. The word "election" might appear
# frequently in many articles, but if it appears significantly more often in
# one specific article, the TF-IDF score for "election" in that article would
# be high, indicating that "election" is an important term in that specific
# article.

# TF-IDF is widely used in various NLP applications, such as text
# classification, information retrieval, document clustering, and more, to help
# analyze and understand textual data by identifying the most relevant and
# distinctive terms within documents.

## Simpler TF-IDF calculation ----
# Term Frequency (TF): Number of times a term occurs in a document
# Document Frequency (DF): Number of documents that contain the term
# Inverse Document Frequency (IDF) = 1/DF
# TF-IDF is equal to TF * IDF
# The IDF of any term is, therefore, a higher number for words that occur in
# fewer of the documents in the collection.

## Stopword Removal Before TF-IDF ----

### Advantages ----

# Stopwords are common words like "the," "and," "in," which typically do not
# carry much meaningful information. Removing them can reduce noise in your
# data and improve the efficiency of TF-IDF calculations.
# It can help focus the analysis on the more meaningful and distinctive terms
# in your documents.

### Disadvantages ----

# In some cases, stopwords may carry contextual information. For example, in
# sentiment analysis, words like "not" or "but" can change the meaning of a
# sentence. Removing them may lead to a loss of important information.
# If you're using TF-IDF for tasks like topic modeling or document clustering,
# stopwords may play a role in identifying topics or clusters.

## Stopword Inclusion in TF-IDF ----

### Advantages ----

# Including stopwords in the TF-IDF calculation can preserve their importance
# if they appear in a meaningful way in your documents.
# It can be especially useful in tasks where the context provided by stopwords
# matters.

### Disadvantages ----

# Stopwords can dominate the TF-IDF score for some terms, even though they are
# not usually informative.
# This approach may result in less efficient computations and a larger feature
# space in your TF-IDF matrix.

# In practice, the decision to remove stopwords before TF-IDF or include them
# depends on the specific problem you are trying to solve and the
# characteristics of your dataset. It's common to experiment with both
# approaches and evaluate their impact on the performance of your NLP tasks
# (e.g., text classification, information retrieval, document clustering) to
# determine which one works better for your particular use case.

# Additionally, some libraries, packages, and tools offer options to customize
# stopword removal within the TF-IDF process, allowing you to strike a balance
# between preserving potentially meaningful stopwords and reducing noise in
# your data.

## Evaluation Likes ----
### TF-IDF Score per Gender ----
popular_tfidf_words_gender_likes <- evaluation_likes_filtered %>% # nolint
  unnest_tokens(word, `Likes (tokenized)`) %>%
  distinct() %>%
  filter(!word %in% undesirable_words) %>%
  filter(nchar(word) > 3) %>%
  rename(`Likes (tokenized)` = word) %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  count(`Student's Gender`, `Likes (tokenized)`, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(`Likes (tokenized)`, `Student's Gender`, n)

head(popular_tfidf_words_gender_likes)

top_popular_tfidf_words <- popular_tfidf_words_gender_likes %>%
  arrange(desc(tf_idf)) %>%
  mutate(`Likes (tokenized)` =
           factor(`Likes (tokenized)`,
                  levels = rev(unique(`Likes (tokenized)`)))) %>%
  group_by(`Student's Gender`) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Student's Gender`, tf_idf) %>%
  mutate(row = row_number())

top_popular_tfidf_words %>%
  ggplot(aes(x = row, tf_idf, fill = `Student's Gender`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation", y = "TF-IDF Score") +
  ggtitle("Important Words using TF-IDF by Chart Level") +
  ggtitle("Most Important Words by TF-IDF Score in Course Evaluation Likes per 
      Class Group") +
  facet_wrap(~`Student's Gender`, scales = "free") +
  scale_x_continuous(
                     breaks = top_popular_tfidf_words$row,
                     labels = top_popular_tfidf_words$`Likes (tokenized)`) +
  coord_flip()

### TF-IDF Score per Group ----
popular_tfidf_words_likes <- evaluation_likes_filtered %>% # nolint
  unnest_tokens(word, `Likes (tokenized)`) %>%
  distinct() %>%
  filter(!word %in% undesirable_words) %>%
  filter(nchar(word) > 3) %>%
  rename(`Likes (tokenized)` = word) %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Likes (tokenized)`) %>%
  count(`Class Group`, `Likes (tokenized)`, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(`Likes (tokenized)`, `Class Group`, n)

head(popular_tfidf_words_likes)

top_popular_tfidf_words <- popular_tfidf_words_likes %>%
  arrange(desc(tf_idf)) %>%
  mutate(`Likes (tokenized)` =
           factor(`Likes (tokenized)`,
                  levels = rev(unique(`Likes (tokenized)`)))) %>%
  group_by(`Class Group`) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Class Group`, tf_idf) %>%
  mutate(row = row_number())

top_popular_tfidf_words %>%
  ggplot(aes(x = row, tf_idf, fill = `Class Group`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation", y = "TF-IDF Score") +
  ggtitle("Important Words using TF-IDF by Chart Level") +
  ggtitle("Most Important Words by TF-IDF Score in Course Evaluation Likes per 
      Class Group") +
  facet_wrap(~`Class Group`, scales = "free") +
  scale_x_continuous(
                     breaks = top_popular_tfidf_words$row,
                     labels = top_popular_tfidf_words$`Likes (tokenized)`) +
  coord_flip()

## Evaluation Wishes ----
### TF-IDF Score per Gender ----
popular_tfidf_words_gender_wishes <- evaluation_wishes_filtered %>% # nolint
  unnest_tokens(word, `Wishes (tokenized)`) %>%
  distinct() %>%
  filter(!word %in% undesirable_words) %>%
  filter(nchar(word) > 3) %>%
  rename(`Wishes (tokenized)` = word) %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  count(`Student's Gender`, `Wishes (tokenized)`, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(`Wishes (tokenized)`, `Student's Gender`, n)

head(popular_tfidf_words_gender_wishes)

top_popular_tfidf_words <- popular_tfidf_words_gender_wishes %>%
  arrange(desc(tf_idf)) %>%
  mutate(`Wishes (tokenized)` =
           factor(`Wishes (tokenized)`,
                  levels = rev(unique(`Wishes (tokenized)`)))) %>%
  group_by(`Student's Gender`) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Student's Gender`, tf_idf) %>%
  mutate(row = row_number())

top_popular_tfidf_words %>%
  ggplot(aes(x = row, tf_idf, fill = `Student's Gender`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation", y = "TF-IDF Score") +
  ggtitle("Important Words using TF-IDF by Chart Level") +
  ggtitle("Most Important Words by TF-IDF Score in Course Evaluation Wishes per 
      Class Group") +
  facet_wrap(~`Student's Gender`, scales = "free") +
  scale_x_continuous(
                     breaks = top_popular_tfidf_words$row,
                     labels = top_popular_tfidf_words$`Wishes (tokenized)`) +
  coord_flip()

### TF-IDF Score per Group ----
popular_tfidf_words_likes <- evaluation_wishes_filtered %>% # nolint
  unnest_tokens(word, `Wishes (tokenized)`) %>%
  distinct() %>%
  filter(!word %in% undesirable_words) %>%
  filter(nchar(word) > 3) %>%
  rename(`Wishes (tokenized)` = word) %>%
  select(`Class Group`, `Student's Gender`,
         `Average Course Evaluation Rating`, `Wishes (tokenized)`) %>%
  count(`Class Group`, `Wishes (tokenized)`, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(`Wishes (tokenized)`, `Class Group`, n)

head(popular_tfidf_words_likes)

top_popular_tfidf_words <- popular_tfidf_words_likes %>%
  arrange(desc(tf_idf)) %>%
  mutate(`Wishes (tokenized)` =
           factor(`Wishes (tokenized)`,
                  levels = rev(unique(`Wishes (tokenized)`)))) %>%
  group_by(`Class Group`) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(`Class Group`, tf_idf) %>%
  mutate(row = row_number())

top_popular_tfidf_words %>%
  ggplot(aes(x = row, tf_idf, fill = `Class Group`)) +
  geom_col(fill = blue_grey_colours_1) +
  blue_grey_theme() +
  labs(x = "Word in Course Evaluation", y = "TF-IDF Score") +
  ggtitle("Important Words using TF-IDF by Chart Level") +
  ggtitle("Most Important Words by TF-IDF Score in Course Evaluation Wishes per 
      Class Group") +
  facet_wrap(~`Class Group`, scales = "free") +
  scale_x_continuous(
                     breaks = top_popular_tfidf_words$row,
                     labels = top_popular_tfidf_words$`Wishes (tokenized)`) +
  coord_flip()

# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.
# renv::snapshot() # nolint

# References ----
## Ashton, D., Porter, S., library), N. D. (chart js, library), T. L. (chart js, & library), W. E. (chart js. (2016). radarchart: Radar Chart from ‘Chart.js’ (0.3.1) [Computer software]. https://cran.r-project.org/package=radarchart # nolint ----

## Auguie, B., & Antonov, A. (2017). gridExtra: Miscellaneous Functions for ‘Grid’ Graphics (2.3) [Computer software]. https://cran.r-project.org/package=gridExtra # nolint ----

## Bevans, R. (2023b). Sample Crop Data Dataset for ANOVA (Version 1) [Dataset]. Scribbr. https://www.scribbr.com/wp-content/uploads//2020/03/crop.data_.anova_.zip # nolint ----

## Csárdi, G., Nepusz, T., Traag, V., Horvát, S., Zanini, F., Noom, D., Müller, K., Salmon, M., & details, C. Z. I. igraph author. (2023). igraph: Network Analysis and Visualization (1.5.1) [Computer software]. https://cran.r-project.org/package=igraph # nolint ----

## Gu, Z., Gu, L., Eils, R., Schlesner, M., & Brors, B. (2014). Circlize Implements and Enhances Circular Visualization in R. Bioinformatics (Oxford, England), 30(19), 2811–2812. https://doi.org/10.1093/bioinformatics/btu393 #nolint ----

## Gu, Z. (2022). circlize: Circular Visualization (0.4.15) [Computer software]. https://cran.r-project.org/package=circlize # nolint ----

## Lang, D., & Chien, G. (2018). wordcloud2: Create Word Cloud by ‘htmlwidget’ (0.2.1) [Computer software]. https://cran.r-project.org/package=wordcloud2 # nolint ----

## Leonawicz, M. (2023). memery: Internet Memes for Data Analysts (0.5.7) [Computer software]. https://cran.r-project.org/package=memery # nolint ----

## Liske, D. (2018). R NLP & Machine Learning: Lyric Analysis [Tutorial]. Datacamp. https://www.datacamp.com/tutorial/R-nlp-machine-learning # nolint ----

## Ooms, J. (2023). magick: Advanced Graphics and Image-Processing in R (2.7.5) [Computer software]. https://cran.r-project.org/package=magick # nolint ----

## Pedersen, T. L., & RStudio. (2022). ggraph: An Implementation of Grammar of Graphics for Graphs and Networks (2.1.0) [Computer software]. https://cran.r-project.org/package=ggraph # nolint ----

## Phillips, N. (2017). yarrr: A Companion to the e-Book ‘YaRrr!: The Pirate’s Guide to R’ (0.1.5) [Computer software]. https://cran.r-project.org/package=yarrr # nolint ----

## Queiroz, G. D., Fay, C., Hvitfeldt, E., Keyes, O., Misra, K., Mastny, T., Erickson, J., Robinson, D., Silge  [aut, J., & cre. (2023). tidytext: Text Mining using ‘dplyr’, ‘ggplot2’, and Other Tidy Tools (0.4.1) [Computer software]. https://cran.r-project.org/package=tidytext # nolint ----

## Ren, K., & Russell, K. (2021). formattable: Create ‘Formattable’ Data Structures (0.2.1) [Computer software]. https://cran.r-project.org/package=formattable # nolint ----

## Robinson, D., Misra, K., Silge  [aut, J., & cre. (2022). widyr: Widen, Process, then Re-Tidy Data (0.1.5) [Computer software]. https://cran.r-project.org/package=widyr # nolint ----

## Slowikowski, K., Schep, A., Hughes, S., Dang, T. K., Lukauskas, S., Irisson, J.-O., Kamvar, Z. N., Ryan, T., Christophe, D., Hiroaki, Y., Gramme, P., Abdol, A. M., Barrett, M., Cannoodt, R., Krassowski, M., Chirico, M., & Aphalo, P. (2023). ggrepel: Automatically Position Non-Overlapping Text Labels with ‘ggplot2’ (0.9.3) [Computer software]. https://cran.r-project.org/package=ggrepel # nolint ----

## Wickham, H., Chang, W., Henry, L., Pedersen, T. L., Takahashi, K., Wilke, C., Woo, K., Yutani, H., Dunnington, D., Posit, & PBC. (2023). ggplot2: Create Elegant Data Visualisations Using the Grammar of Graphics (3.4.3) [Computer software]. https://cran.r-project.org/package=ggplot2 # nolint ----

## Wickham, H., François, R., Henry, L., Müller, K., Vaughan, D., Software, P., & PBC. (2023). dplyr: A Grammar of Data Manipulation (1.1.3) [Computer software]. https://cran.r-project.org/package=dplyr # nolint ----

## Wickham, H., Vaughan, D., Girlich, M., Ushey, K., Posit, & PBC. (2023). tidyr: Tidy Messy Data (1.3.0) [Computer software]. https://cran.r-project.org/package=tidyr # nolint ----

## Xie  [aut, Y., cre, Sarma, A., Vogt, A., Andrew, A., Zvoleff, A., Al-Zubaidi, A., http://www.andre-simon.de), A. S. (the C. files under inst/themes/ were derived from the H. package, Atkins, A., Wolen, A., Manton, A., Yasumoto, A., Baumer, B., Diggs, B., Zhang, B., Yapparov, B., Pereira, C., Dervieux, C., Hall, D., … PBC. (2023). knitr: A General-Purpose Package for Dynamic Report Generation in R (1.44) [Computer software]. https://cran.r-project.org/package=knitr # nolint ----

## Zhu  [aut, H., cre, Travison, T., Tsai, T., Beasley, W., Xie, Y., Yu, G., Laurent, S., Shepherd, R., Sidi, Y., Salzer, B., Gui, G., Fan, Y., Murdoch, D., & Evans, B. (2021). kableExtra: Construct Complex Table with ‘kable’ and Pipe Syntax (1.3.4) [Computer software]. https://cran.r-project.org/package=kableExtra # nolint ----

# **Required Lab Work Submission** ----

# NOTE: The lab work should be done in groups of between 2 and 5 members using
#       Git and GitHub.

## Part A ----
# Create a markdown file called "Lab2b-Submission-EDA-Qual-Markdown.Rmd"
# and place it inside the folder called "markdown". Use R Studio to ensure the
# .Rmd file is based on the "GitHub Document (Markdown)" template when it is
# being created.
# Provide an interpretation of the most significant visualizations in the
# markdown file. The emphasis should be on ensuring that the visualizations are
# understandable.

## Part B ----
# Render the .Rmd (R markdown) file into its .md (markdown) version by using
# knitR in RStudio.

# You need to download and install "pandoc" to render the R markdown.
# Pandoc is a file converter that can be used to convert the following files:
#   https://pandoc.org/diagram.svgz?v=20230831075849

# Documentation:
#   https://pandoc.org/installing.html and
#   https://github.com/REditorSupport/vscode-R/wiki/R-Markdown

# By default, Rmd files are open as Markdown documents. To enable R Markdown
# features, you need to associate *.Rmd files with rmd language.
# Add an entry Item "*.Rmd" and Value "rmd" in the VS Code settings,
# "File Association" option.

# Documentation of knitR: https://www.rdocumentation.org/packages/knitr/

# Upload *the link* to "Lab2b-Submission-EDA-Qual-Markdown.md" (not .Rmd)
# markdown file hosted on Github's main branch (do not upload the .Rmd or .md
# markdown files) through the submission link provided on eLearning.