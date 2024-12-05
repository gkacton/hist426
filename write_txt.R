

# Source from data prep script --------------------------------------------

source("data_prep.R")

# Create .txt files for q's and a's ---------------------------------------

for (j in 1:nrow(nhbb)) {
  q_filepath <- paste("text_files/", nhbb$ID[j], "_q.txt", sep = "")
  nhbb$q_file[j] <- q_filepath
  a_filepath <- paste("text_files/", nhbb$ID[j], "_a.txt", sep = "")
  nhbb$a_file[j] <- a_filepath
  writeLines(nhbb$q_text[j], q_filepath)
  writeLines(nhbb$a_text[j], a_filepath)
  # write additional files for bonus questions + answers
  if(nhbb$bonus_q_text[j] != ""){
    bonus_q_filepath <- paste("text_files/", nhbb$ID[j], "_bonus_q.txt", sep = "")
    nhbb$bonus_q_file[j] <- bonus_q_filepath
    bonus_a_filepath <- paste("text_files/", nhbb$ID[j], "_bonus_a.txt", sep = "")
    nhbb$bonus_a_file[j] <- bonus_a_filepath
    writeLines(nhbb$bonus_q_text[j], bonus_q_filepath)
    writeLines(nhbb$bonus_a_text[j], bonus_a_filepath)
  } else{
    nhbb$bonus_q_file[j] <- NA
    nhbb$bonus_a_file[j] <- NA
  }
}

