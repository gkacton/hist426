
# load in data ------------------------------------------------------------

nhbb <- read.csv("NHBB_manifest.csv")
library(tidyverse)
library(magrittr)
library(stringr)

# remove rows without questions written in --------------------------------

nhbb <- nhbb %>% 
  filter(q_text != "")

# generate IDs
for (i in 1:nrow(nhbb)) {
  if(is.na(nhbb$question_num[i]) == T){
    nhbb$ID[i] <- paste(nhbb$year[i], nhbb$set[i], nhbb$tournament_round[i], nhbb$game_round[i], sep = ".")
  }
  if(nhbb$type[i] != "lightning"){
    nhbb$ID[i] <- paste(nhbb$year[i], nhbb$set[i], nhbb$tournament_round[i], nhbb$game_round[i], nhbb$question_num[i], sep = ".")
  } else if(nhbb$type[i] == "lightning"){
    nhbb$ID[i] <- paste(nhbb$year[i], nhbb$set[i], nhbb$tournament_round[i], nhbb$game_round[i], "lightning", nhbb$lightning_round[i], nhbb$question_num[i], sep = ".")
  } 
}

# Remove pronunciation guides, bonus characters, etc ----------------------

# test

test_exp <- nhbb$q_text[300]
test_exp_clean <- str_remove_all(test_exp, "\\[.*?\\]") # to remove all strings of any number of characters that are square-brackets (such as pronunciation guides)
test_exp_clean <- str_remove_all(test_exp_clean, "\\(\\*\\)") # to remove indicator of bonus (*)
test_exp_clean

# test successful

# loop to remove from all questions
nhbb_clean <- nhbb

# remove pronunciation guides (in square brackets) and bonus indicators ((*) and (+))
for (i in 1:nrow(nhbb_clean)){
  nhbb_clean$q_text[i] <- str_remove_all(nhbb_clean$q_text[i], "\\[.*?\\]")
  nhbb_clean$q_text[i] <- str_remove_all(nhbb_clean$q_text[i], "\\]")
  nhbb_clean$q_text[i] <- str_remove_all(nhbb_clean$q_text[i], "\\(.*?\\)")
  nhbb_clean$q_text[i] <- str_remove_all(nhbb_clean$q_text[i], "\\(\\*\\)")
  nhbb_clean$q_text[i] <- str_remove_all(nhbb_clean$q_text[i], "\\(\\+\\)")
  nhbb_clean$bonus_q_text[i] <- str_remove_all(nhbb_clean$bonus_q_text[i], "\\[.*?\\]")
  nhbb_clean$bonus_q_text[i] <- str_remove_all(nhbb_clean$bonus_q_text[i], "\\]")
  nhbb_clean$bonus_q_text[i] <- str_remove_all(nhbb_clean$bonus_q_text[i], "\\(.*?\\)")
  nhbb_clean$bonus_q_text[i] <- str_remove_all(nhbb_clean$bonus_q_text[i], "\\(\\*\\)")
  nhbb_clean$bonus_q_text[i] <- str_remove_all(nhbb_clean$bonus_q_text[i], "\\(\\+\\)")
}

# select columns
nhbb_clean <- nhbb_clean %>% 
  select(ID, year, set, tournament_round, game_round, lightning_round, question_num,
         type, lightning_lead, q_text, a_text, bonus_q_text, bonus_a_text,
          woman_named, is_fictional, is_myth, is_answer, names, author)

# write to csv
write.csv(nhbb_clean, "nhbb_clean.csv")

