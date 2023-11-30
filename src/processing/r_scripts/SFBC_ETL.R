# Script for the ETL of SFBC data files


result <- result %>% mutate(SFBC_ID = str_split_fixed(FileName, "\\.", 2)[, 1])

result_wide <- pivot_wider(
  data = result,
  names_from = Field1,
  values_from = Field2
)

capitalise_NHS <- function(x) {
  gsub("\\bNHS\\b", "NHS", x, ignore.case = TRUE)
}

AIDF_df <- result_wide %>%
  mutate(`Network Name 1` = sub("\\\\.*","", `Network Name`),
         `Network Name 2` = sub(".*\\\\", "", `Network Name`),
         Trust = str_to_title(Trust),
         Region = map_chr(Region, ~paste(.x, collapse = ", ")),
         `Org code` = map_chr(`Org code`, ~paste(.x, collapse = ", ")),
         Trust = capitalise_NHS(Trust)) %>%
  select(c(3, 4, 9, 10, 7, 8))