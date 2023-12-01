
# Load Deprivation Data ---------------------------------------------------

imd <- read.xlsx("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/833970/File_1_-_IMD2019_Index_of_Multiple_Deprivation.xlsx", sheet = 2)
imd <- imd%>%
  left_join(lsoa_lookup, c("LSOA.code.(2011)" = "LSOA11CD"))%>%
  mutate(`Index.of.Multiple.Deprivation.(IMD).Decile` = factor(`Index.of.Multiple.Deprivation.(IMD).Decile`))

imd_domain <- read.xlsx("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/833973/File_2_-_IoD2019_Domains_of_Deprivation.xlsx", sheet = 2)

imd_domain <- imd_domain %>%
  left_join(lsoa_lookup, c("LSOA.code.(2011)" = "LSOA11CD")) %>%
  mutate(`Income.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Income.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`),
         `Employment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Employment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`),
         `Education,.Skills.and.Training.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Education,.Skills.and.Training.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`),
         `Health.Deprivation.and.Disability.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Health.Deprivation.and.Disability.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`),
         `Crime.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Crime.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`),
         `Barriers.to.Housing.and.Services.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Barriers.to.Housing.and.Services.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`),
         `Living.Environment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)` = factor(`Living.Environment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`))


# Deprivation Map ---------------------------------------------------------

## Join to dataset with geojson at lsoa level
dep <- geojson_lsoa %>%
  left_join(imd, by = c("LSOA11CD" = "LSOA.code.(2011)"))

## Create palette
pal_fac_imd<-colorFactor(palette = "Blues", levels = 10:1, domain = dep$`Index.of.Multiple.Deprivation.(IMD).Decile`)

dep_map_icb <- function(icb){
  
  dep_icb <- dep %>%
    filter(ICB22CDH == icb)
  
  coord <- icb_lookup_coord %>%
    filter(ICB23CDH == icb)
  
  lat <- coord[[1,3]]
  lng <- coord[[1,4]]
  zoom <- coord[[1,5]]
  
  leaflet(dep_icb) %>%
    addPolygons(data = geojson_icb, color = "black", weight = 3) %>%
    addPolygons(data = geojson_subicb, color = "black", weight = 1) %>%
    addPolygons(stroke = TRUE, weight = 0.4, opacity = 0.5, fillOpacity = 0.6, dashArray = "5, 10",
                color = "white", fillColor = ~pal_fac_imd(`Index.of.Multiple.Deprivation.(IMD).Decile`),
                label = paste0(dep_icb$LSOA11NM.y,": Decile - ", dep_icb$`Index.of.Multiple.Deprivation.(IMD).Decile`)) %>%
    addProviderTiles(providers$CartoDB.Voyager) %>%
    addLegend(values = dep_icb$`Index.of.Multiple.Deprivation.(IMD).Decile`, pal = pal_fac_imd, title = "IMD Decile - 2019", position = "topright") %>%
    setView(lng = lng, lat = lat, zoom = zoom)
  
}


# Deprivation Deciles -----------------------------------------------------

dep_deciles_plot <- function(icb){
  
  icb_title <- as.data.frame(dep) %>%
    filter(ICB22CDH == icb) %>%
    group_by(ICB22NM) %>%
    summarise()
  
  plot_title <- paste0("Proportion of ", icb_title[[1,1]], '</br></br>', " LSOAs by Deprivation Decile")
  
  
  dep_deciles <- as.data.frame(dep) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Index.of.Multiple.Deprivation.(IMD).Decile`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs))
  
  ggplot(dep_deciles, aes(x = `Index.of.Multiple.Deprivation.(IMD).Decile`, y = Prop_LSOAs))+
    geom_bar(stat = "identity")
  
  hline <- function(y = 0, color = "black") {
    list(
      type = "line", 
      x0 = 0, 
      x1 = 1, 
      xref = "paper",
      y0 = y, 
      y1 = y, 
      line = list(color = color),
      style = "dashed"
    )
  }
  
  
  dep_deciles %>%
    plot_ly(x = ~`Index.of.Multiple.Deprivation.(IMD).Decile`, y = ~Prop_LSOAs, type = "bar",
            hoverinfo = 'text', text = ~paste0("Decile ", `Index.of.Multiple.Deprivation.(IMD).Decile`, ": ",
                                               round(Prop_LSOAs*100,2), "%"), textposition = "none") %>%
    layout(shapes = list(hline(0.1)),
           title = list(text = plot_title),
           xaxis = list(title = list(text = "IMD Decile")),
           yaxis = list(title = list(text = "Proportion of LSOAs"),
                        tickformat = ".0%"))
  
  
}


# Deprivation Domain Deciles ----------------------------------------------

dep_domains <- geojson_lsoa %>%
  left_join(imd_domain, by = c("LSOA11CD" = "LSOA.code.(2011)"))

dep_domain_deciles <- function(icb) {
  
  icb_title <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(ICB22NM) %>%
    summarise()
  
  plot_title <- paste0("Proportion of ", icb_title[[1,1]], '</br></br>', " LSOAs by Deprivation Decile")
  
  
  dep_deciles_domain1 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Income.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Income") %>%
    rename("Decile" = `Income.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domain2 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Employment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Employment") %>%
    rename("Decile" = `Employment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domain3 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Education,.Skills.and.Training.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Education, Skills and Training") %>%
    rename("Decile" = `Education,.Skills.and.Training.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domain4 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Health.Deprivation.and.Disability.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Health and Disability") %>%
    rename("Decile" = `Health.Deprivation.and.Disability.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domain5 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Crime.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Crime") %>%
    rename("Decile" = `Crime.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domain6 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Barriers.to.Housing.and.Services.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Barriers to Housing") %>%
    rename("Decile" = `Barriers.to.Housing.and.Services.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domain7 <- as.data.frame(dep_domains) %>%
    filter(ICB22CDH == icb) %>%
    group_by(`Living.Environment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`) %>%
    summarise("LSOAs" = n())%>%
    mutate("Prop_LSOAs" = LSOAs/sum(LSOAs),
           "Domain" = "Living Environment") %>%
    rename("Decile" = `Living.Environment.Decile.(where.1.is.most.deprived.10%.of.LSOAs)`)
  
  dep_deciles_domains <- rbind(dep_deciles_domain1,
                               dep_deciles_domain2,
                               dep_deciles_domain3,
                               dep_deciles_domain4,
                               dep_deciles_domain5,
                               dep_deciles_domain6,
                               dep_deciles_domain7) %>%
    mutate(Domain = factor(Domain, levels = c("Income", "Employment", "Education, Skills and Training",
                                              "Health and Disability", "Crime", "Barriers to Housing",
                                              "Living Environment")))
  
  dep_deciles_domains %>%
    group_by(Domain) %>%
    do(p = plot_ly(., x = ~Decile, y = ~Prop_LSOAs, fill = ~Domain,
                   type = "bar")) %>%
    subplot(nrows = 2, shareX = TRUE, shareY = TRUE)
  
  hline <- function(y = 0, color = "black") {
    list(
      type = "line", 
      x0 = 0, 
      x1 = 1, 
      xref = "paper",
      y0 = y, 
      y1 = y, 
      line = list(color = color),
      style = "dashed"
    )
  }
  
  palette <- c("#407EC9", "#F04E98", "#40C1AC", "#F68D2E", "#68D2DF", "#8A1538", "#6CC24A")
  
  domain_plot <- . %>% 
    plot_ly(x = ~Decile, y = ~Prop_LSOAs, fill = ~Domain, type = "bar",
            hoverinfo = 'text', text = ~paste0("Decile ", Decile, ": ",
                                               round(Prop_LSOAs*100,2), "%"), textposition = "none"
    ) %>%
    add_annotations(
      text = ~unique(Domain),
      x = 0.2,
      y = 0.9,
      yref = "paper",
      xref = "paper",
      xanchor = "left",
      yanchor = "top",
      showarrow = FALSE,
      font = list(size = 10)
    ) %>%
    layout(shapes = list(hline(0.1)),
           title = list(text = plot_title),
           xaxis = list(title = list(text = "IMD Decile", standoff = 1)),
           yaxis = list(title = list(text = "Proportion of LSOAs"),
                        tickformat = ".0%"),
           showlegend = FALSE,
           margin = list( t= 40))
  
  dep_deciles_domains %>%
    group_by(Domain) %>%
    do(p = domain_plot(.)) %>%
    subplot(nrows = 2, shareX = FALSE, shareY = TRUE, titleX = TRUE, margin = 0.03)
  
}
