setwd("C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC")
getwd()

library(readxl)
library(purrr)
library(tidyverse)
library(tidyr)

folder_path <- getwd()

sheet_names <- function(file_path){
  
  excel_sheets(file_path)
  
}

excel_files <- list.files(path = folder_path, pattern = "\\.xlsx$", full.names = FALSE)

all_sheet_names <- map(excel_files, sheet_names)


max_length <- max(lengths(all_sheet_names))
all_sheet_names_padded <- lapply(all_sheet_names, function(x) c(x, rep(NA, max_length - length(x))))
all_sheet_names_df <- as.data.frame(all_sheet_names_padded)

names(all_sheet_names_df) <- excel_files
all_sheet_names_df_long <- gather(all_sheet_names_df, key = "File_Name", value = "Sheet_Name")
all_sheet_names_df_long <- all_sheet_names_df %>%
  gather(key = "File_Name", value = "Sheet_Name") %>%
  drop_na()

target_sheets <- all_sheet_names_df_long %>%
  filter(!Sheet_Name %in% c("Front Sheet", "dropdowns", "Master Sheet",
                            "AI Supplier Cost Detail", "GM Activity & Perfromance"))


read_sheets_and_bind <- function(folder_path, sheets_to_read, range) {
  
  excel_files <- list.files(path = folder_path, pattern = "\\.xlsx$", full.names = TRUE)
  
  process_sheet <- function(file_path) {
    
    selected_data <- lapply(sheets_to_read, function(sheet) {
      if (sheet %in% excel_sheets(file_path)) {
        read_excel(file_path, sheet = sheet, range = range, col_names = FALSE) %>%
          mutate(SheetName = sheet, FileName = basename(file_path))
      } else {
        
        data.frame(matrix(NA, nrow = 0, ncol = 0))
      }
    })
    
    return(selected_data)
  }
  
  all_data <- map_dfr(excel_files, process_sheet)
  
  return(all_data)
}

folder_path <- getwd()
sheets_to_read <- target_sheets[,2]
range <- "A1:B5"

result <- read_sheets_and_bind(folder_path, sheets_to_read, range) %>%
  rename("Field1" = 1, "Field2" = 2)

result_wide <- result %>%
  spread(Field1, Field2) # Script resulting in error where 10 rows have a NULL (NA) return for both Field 1 and Field 2.
