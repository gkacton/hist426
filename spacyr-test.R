
# import spacyr -----------------------------------------------------------

library(spacyr)
spacy_install()
spacy_initialize(model = "en_core_web_sm")
source("data_prep.R")

# Subset a random sample from NHBB data -----------------------------------

x <- 1:300
random_num <- sample(x, size = 25)

nhbb_sample <- nhbb_clean[random_num,]


# SpacyR ------------------------------------------------------------------

nhbb_txt <- nhbb_sample %>% 
  select(ID, q_text_clean)

nhbb_txt_parsed <- spacy_parse(nhbb_txt, lemma = FALSE, entity = TRUE, nounphrase = TRUE)
