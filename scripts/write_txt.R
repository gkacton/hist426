
# Defining a write_txt() function -----------------------------------------------------------

write_txt <- function(df, directory){
  for(i in 1:nrow(df)){
    q_filepath <- paste(directory, df$ID[i], "_q.txt", sep = "")
    df$q_file[i] <- q_filepath
    a_filepath <- paste(directory, df$ID[i], "_a.txt", sep = "")
    df$a_file[i] <- a_filepath
    writeLines(df$q_text[i], q_filepath)
    writeLines(df$a_text[i], a_filepath)
    # write additional files for bonus questions + answers
    if(df$bonus_q_text[i] != ""){
      bonus_q_filepath <- paste(directory, df$ID[i], "_bonus_q.txt", sep = "")
      df$bonus_q_file[i] <- bonus_q_filepath
      bonus_a_filepath <- paste(directory, df$ID[i], "_bonus_a.txt", sep = "")
      df$bonus_a_file[i] <- bonus_a_filepath
      writeLines(df$bonus_q_text[i], bonus_q_filepath)
      writeLines(df$bonus_a_text[i], bonus_a_filepath)
    } else{
      df$bonus_q_file[i] <- NA
      df$bonus_a_file[i] <- NA
    }
  }
}
  
