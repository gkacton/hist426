
# Source data -------------------------------------------------------------

source("data_prep.R")


# Groupings ---------------------------------------------------------------

# Does question contain a woman mentioned by name?

woman_named <- nhbb_clean %>% 
  filter(woman_named == T) %>% 
  group_by(is_fictional) %>% 
  count()

woman_answers <- nhbb_clean %>% 
  filter(is_answer == T)

woman_named_q_only <- nhbb_clean %>% 
  filter(woman_named == T & is_answer == F) %>% 
  select(names, q_text_clean, ID) %>% 
  separate_rows(names, sep = ", ") 

woman_named_all <- nhbb_clean %>% 
  filter(woman_named == T) %>% 
  select(names, q_text_clean, ID) %>% 
  separate_rows(names, sep = ", ")

woman_counts <- woman_named_all %>% 
  group_by(names) %>% 
  count()


# Make table of just questions that feature women -------------------------

woman_qs <- as.data.frame(matrix(ncol = 4, nrow = nrow(woman_answers)))
colnames(woman_qs) <- c("ID", "question", "answer", "type") 

# write only questions for which the woman is the answer to a new df
for (i in 1:nrow(woman_answers)){
  if(woman_answers$a_text[i] %in% woman_answers$names[i] == TRUE | 
     woman_answers$names[i] %in% woman_answers$a_text[i] == TRUE |
     grepl(woman_answers$a_text[i], woman_answers$names[i]) == TRUE |
     grepl(woman_answers$names[i], woman_answers$a_text[i]) == TRUE) {
    woman_qs$ID[i] <- woman_answers$ID[i]
    woman_qs$question[i] <- woman_answers$q_text_clean[i]
    woman_qs$answer[i] <- woman_answers$a_text[i]
    woman_qs$type[i] <- "tossup/lightning"
  } else if(woman_answers$bonus_a_text[i] %in% woman_answers$names[i] == TRUE | 
            woman_answers$names[i] %in% woman_answers$bonus_a_text[i] == TRUE |
            grepl(woman_answers$bonus_a_text[i], woman_answers$names[i]) == TRUE |
            grepl(woman_answers$names[i], woman_answers$bonus_a_text[i]) == TRUE){
    woman_qs$ID[i] <- woman_answers$ID[i]
    woman_qs$question[i] <- woman_answers$bonus_q_text_clean[i]
    woman_qs$answer[i] <- woman_answers$bonus_a_text[i]
    woman_qs$type[i] <- "bonus"
  }
}

# fix the "type" column 

for (j in 1:nrow(woman_qs)) {
  if(grepl("lightning", woman_qs$ID[j]) == TRUE){
    woman_qs$type[j] <- "lightning"
  } else if(woman_qs$type[j] == "tossup/lightning" & 
            grepl("lightning", woman_qs$ID[j]) == FALSE){
    woman_qs$type[j] <- "tossup"
  }
}

repeats <- woman_qs %>% 
  group_by(answer) %>% 
  count()

