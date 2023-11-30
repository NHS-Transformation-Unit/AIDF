# Script for the cleaning of SFBC data due to non-consistent formatting of files on NHS Futures site.


# Separation of specific imaging networks into DF for ease of cleaning

E1_df <- AIDF_df %>%
  filter(`Network Name 1` == "Norfolk, Suffolk & North Essex")

E2_df <- AIDF_df %>%
  filter(`Network Name 1` == "Herts West Essex, Bedford Luton and Mid and South Essex systems")

EM1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "EM1_SFBC")

HNY_df <- AIDF_df %>%
  filter(`SFBC_ID` == "HNY_SFBC")

NEL1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NEL1_SFBC")

NENC_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NENC_SFBC")

NWCM_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NWCM_SFBC")

NWGM_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NWGM_SFBC")

NWL1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NWL1_SFBC")

SE2_df <- AIDF_df %>%
  filter(`SFBC_ID` == "SE2_SFBC")

SW1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "SW1_SFBC")

# Cleaning C&M

CM_Row <- 8
CM_Value <- "Mersey and West Lancashire Teaching Hospitals NHS Trust"

CM_Org <- c("REN",
            "RJR",
            "RJN",
            "RBT",
            "REM",
            "REP",
            "RBQ",
            "RBN",
            "RWW",
            "RBL")

NWCM_df <- NWCM_df %>% 
  mutate(`Org code` = CM_Org,
         Trust = ifelse(row_number() == CM_Row, CM_Value, Trust))

# Cleaning E1

E1_Org <- c("RGM",
            "RGP",
            "RCX",
            "RGR",
            "RGN",
            "RDE",
            "RM1",
            "RGT")

E1_df <- E1_df %>% 
  mutate(`Org code` = E1_Org)

# Cleaning EM1

EM1_Row <- 7
EM1_Value <- "University Hospitals of Leicester NHS Trust"

EM1_Org <- c("RFS",
             "RNQ",
             "RP1",
             "RX1",
             "RK5",
             "RP7",
             "RWE")

EM1_df <- EM1_df %>% 
  mutate(`Org code` = EM1_Org,
         Trust = ifelse(row_number() == EM1_Row, EM1_Value, Trust))

# Cleaning GM

GM_Trusts <- c("Bolton NHS Foundation Trust",
               "Manchester University NHS Foundation Trust",
               "Northern Care Alliance NHS Foundation Trust",
               "Tameside and Glossop Integrated Care NHS Foundation Trust",
               "The Christie NHS Foundation Trust",
               "Stockport NHS Foundation Trust",
               "Wrightington, Wigan and Leigh NHS Foundation Trust", 
               "Blank")

GM_Org <- c("RMC",
            "R0A",
            "RM3",
            "RMP",
            "RBV",
            "RWJ",
            "RRF",
            "Blank")

GM_Remove <- 8

NWGM_df <- NWGM_df %>% 
  mutate(Trust = GM_Trusts,
         Region = "North West",
         `Network Name 1` = "Greater Manchester",
         `Network Name 2` = "North West 2",
         `Org code` = GM_Org,) %>%
  filter(row_number() != GM_Remove)

# Cleaning HNY

HNY_Row <- c(1, 2, 3)
HNY_Value <- c("Hull University Teaching Hospitals NHS Trust",
               "York and Scarborough Teaching Hospitals NHS Foundation Trust",
               "Northern Lincolnshire and Goole NHS Foundation Trust")

HNY_Org <- c("RWA",
             "RCB",
             "RJL")

HNY_df <- HNY_df %>% 
  mutate(`Org code` = HNY_Org,
         Trust = ifelse(row_number() == HNY_Row, HNY_Value, Trust))

# Cleaning NEL1

remove_NELCA <- 4

NEL1_df <- NEL1_df %>%
  slice(-remove_NELCA)

# Cleaning NWL1

remove_NWL1 <- c(1, 2, 4)

NWL1_Org <- c("R1K",
              "RAS",
              "RQM",
              "RYJ")

NWL1_df <- NWL1_df %>%
  slice(-remove_NWL1) %>%
  mutate(`Org code` = NWL1_Org)

# Cleaning SE2

SE2_Dupli <- 5
SE2_df <- rbind(SE2_df, SE2_df[SE2_Dupli, ], SE2_df[SE2_Dupli, ])

SE2_Row <- c(5, 6, 7)
SE2_Value <- c("University Hospitals Sussex NHS Foundation Trust",
               "Queen Victoria Hospital NHS Foundation Trust",
               "Surrey & Sussex Healthcare NHS Trust")

SE2_Org <- c("RDU",
             "RTK",
             "RXC",
             "RA2",
             "RYR",
             "RPC",
             "RTP")

SE2_df <- SE2_df %>% 
  mutate(`Org code` = SE2_Org,
         Trust = ifelse(row_number() == SE2_Row, SE2_Value, Trust))

# Combining all cleaned df

AIDF_Proc <- bind_rows(list(E1_df = E1_df,
                            E2_df = E2_df,
                            EM1_df = EM1_df,
                            HNY_df = HNY_df,
                            NEL1_df = NEL1_df,
                            NENC_df = NENC_df,
                            NWCM_df = NWCM_df,
                            NWGM_df = NWGM_df,
                            NWL1_df = NWL1_df,
                            SE2_df = SE2_df,
                            SW1_df = SW1_df))