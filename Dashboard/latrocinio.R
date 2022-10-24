library(tidyverse)
library(sf)
library(ggiraph)
library(readxl)
library(plotly)

# Dados


# DPS_ID


dps_id <- readRDS("C:\\Users\\Caio\\Desktop\\Learning Shiny\\aprendendo_shiny\\dps_id.rds")



latrocinio_2018 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Latrocinio\\Latrocinio_2018_2022.xlsx", sheet = '2018')

latrocinio_2019 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Latrocinio\\Latrocinio_2018_2022.xlsx", sheet = '2019')

latrocinio_2020 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Latrocinio\\Latrocinio_2018_2022.xlsx", sheet = '2020')

latrocinio_2021 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Latrocinio\\Latrocinio_2018_2022.xlsx", sheet = '2021')




  
limpar_latrocinio <- function(dado){
  
  dado %>% 
    dplyr::filter(DEPARTAMENTO_CIRC == 'DECAP') %>% 
    dplyr::distinct(DP_ELABORACAO,ANO_BO,NUM_BO, .keep_all = TRUE) %>% 
    dplyr::mutate(DP_COD = str_extract(`DP - CIRCUNSCRICAO`, "[0-9]+"),
                  DP_COD = as.integer(DP_COD),
                  ocorrencia = lubridate::ymd(DATA_FATO),
                  BO_EMITIDO = lubridate::date(DATAHORA_REGISTRO_BO),
                  BO_EMITIDO = lubridate::ymd(BO_EMITIDO),
                  diferenca_tempo = difftime(BO_EMITIDO, ocorrencia, units = 'days'),
                  mes = lubridate::month(ocorrencia),
                  ano = lubridate::year(ocorrencia))
  
  
  
}  




latrocinio <- list(latrocinio_2018,latrocinio_2019,latrocinio_2020,latrocinio_2021) %>% 
  map(limpar_latrocinio) %>% 
  reduce(full_join)


nomes_dps <- latrocinio %>% select(DP_COD, `DP - CIRCUNSCRICAO`) %>% unique()



latrocinio <- latrocinio %>% rename( 'vitimas' = `Nº DE VIT EM LATRO`)

latrocinio_linhatempo <- latrocinio


latrocinio <- latrocinio %>% select(DP_COD, ano, vitimas)



# preencher dps que possuem 0 ocorrencia


# 2018 falta 2,3,7,8,9,10,11,,13,15,,19,20,21,22,23,24,26,27,29,30,31,32,36,41,42,43,45,46,49,50,51,52,53,54,56,58,65,72,77,80,81,
#91,95,96,98,99,102,103



# 2019 faltam 3,4,5,,7,8,9,14,17,20,21,22,23,24,27,29,30,31,32,33,35,36,39,41,43,44,46,48,56,57,58,59,62,63,67,68,70,75,77,78,80,
#83,85,87,89,90,91,93,96,102,103



# em 2020 faltam 1,4,5,6,8,9,11,12,13,15,17,18,20,22,23,26,27,30,,32,33,34,35,36,38,39,40,41,42,43,44,45,48,50,53,57,58,62,64,65,
#66,69,72,77,80,81,83,85,87,89,90,91,92,93,97,98,99,101,102,103


# faltam em 2021 1,2,4,5,6,8,9,10,11,13,15,16,19,20,21,22,24,26,27,29,30,31,32,33,34,35,36,38,41,42,43,45,46,49,52,53,54,56,57,58,
#59,64,,66,67,68,69,72,73,,75,77,81,83,85,89,91,97,100,102



latrocinio <- latrocinio %>% 
  add_row(DP_COD = 2, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 3, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 7, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 8, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 9, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 10, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 11, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 13, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 15, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 19, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 20, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 21, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 22, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 23, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 24, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 26, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 27, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 29, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 30, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 31, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 32, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 36, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 41, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 42, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 43, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 45, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 46, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 49, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 50, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 51, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 52, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 53, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 54, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 56, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 58, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 65, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 72, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 77, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 80, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 81, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 91, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 95, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 96, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 98, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 99, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 102, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 103, ano = 2018, vitimas = 0) %>%
  add_row(DP_COD = 3, ano = 2019, vitimas = 0) %>%
  add_row(DP_COD = 4, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 5, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 7, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 8, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 9, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 14, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 17, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 20, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 21, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 22, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 23, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 24, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 27, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 29, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 30, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 31, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 32, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 33, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 35, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 36, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 39, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 41, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 43, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 44, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 46, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 48, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 56, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 57, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 58, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 59, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 62, ano = 2019, vitimas = 0) %>%
  add_row(DP_COD = 63, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 67, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 68, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 70, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 75, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 77, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 78, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 80, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 83, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 85, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 87, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 89, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 90, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 91, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 93, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 96, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 102, ano = 2019, vitimas = 0) %>% 
  add_row(DP_COD = 103, ano = 2019, vitimas = 0) %>%
  add_row(DP_COD = 1, ano = 2020, vitimas = 0) %>% 
  add_row(DP_COD = 4, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 5, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 6, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 8, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 9, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 11, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 12, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 13, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 15, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 17, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 18, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 20, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 22, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 23, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 26, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 27, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 30, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 32, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 33, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 34, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 35, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 36, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 38, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 39, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 40, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 41, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 42, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 43, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 44, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 45, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 48, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 50, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 53, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 57, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 58, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 62, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 64, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 65, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 66, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 69, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 72, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 77, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 80, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 81, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 83, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 85, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 87, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 89, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 90, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 91, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 92, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 93, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 97, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 98, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 99, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 101, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 102, ano = 2020, vitimas = 0) %>%
  add_row(DP_COD = 103, ano = 2020, vitimas = 0) %>% 
  add_row(DP_COD = 1, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 2, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 4, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 5, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 6, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 8, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 9, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 10, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 11, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 13, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 15, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 16, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 19, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 20, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 21, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 22, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 24, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 26, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 27, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 29, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 30, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 31, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 32, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 33, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 34, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 35, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 36, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 38, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 41, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 42, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 43, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 45, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 46, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 49, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 52, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 53, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 54, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 56, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 57, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 58, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 59, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 64, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 66, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 67, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 68, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 69, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 72, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 73, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 75, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 77, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 81, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 83, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 85, ano = 2021, vitimas = 0) %>%
  add_row(DP_COD = 89, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 91, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 97, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 100, ano = 2021, vitimas = 0) %>% 
  add_row(DP_COD = 102, ano = 2021, vitimas = 0)



latrocinio_tabela <- latrocinio


latrocinio <- latrocinio %>% group_by(DP_COD, ano) %>% summarise(vitimas = sum(vitimas))




# IMPORTANDO ARQUIVO SHAPE-------------------------------------------------

zonas_elec_sp <- read_sf("C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\arquivo shape\\DISTPOL2021_MSP_CEM_V1.shp")


# -----------------------




latrocinio <- zonas_elec_sp %>% left_join(latrocinio, by = 'DP_COD') 



latrocinio <- latrocinio %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Vítimas:",vitimas))


latrocinio$latrocinios <- cut(latrocinio$vitimas, 
                              breaks=c(-1,1, 2, 3, 4,5,6), 
                              labels=c("0","1", "2", "3","4", "5"), right = FALSE)




# Gráfico interativo

t = latrocinio %>%
  filter(ano == 2019) %>% 
  ggplot(aes()) + 
  geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id,
                      aes(fill = latrocinios,tooltip = tooltip))+
  scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01", "#5B0D06"))+
  labs(title = "Criminalidade Bairro a Bairro",
       subtitle = "Roubos de Celulares por Distrito Policial no ano de 2021",
       caption = 'Fonte: Secretaria de Estado da Segurança Pública de São Paulo')+
  theme_void() + 
  theme(panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        plot.background = element_rect(fill = "transparent", colour = NA),
        plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(size = 7))


tooltip_css = paste0("border-radius: 4px;",
                     "border: 1px solid gray;",
                     "background: white;",
                     "padding: 5px;",
                     "text-align: center;",
                     "opactiy: 0.5")
g = girafe(ggobj =  t, 
           options = list(
             opts_tooltip(css = tooltip_css),
             opts_zoom(max = 5),
             opts_hover_inv(css = "opacity:0.5;"),
             opts_hover(css = "stroke:red;stroke-width:1.0;")
           ) )





g



# Tabela

latrocinio_tabela <- latrocinio_tabela %>% left_join(nomes_dps, by = 'DP_COD')


latrocinio_tabela <- latrocinio_tabela %>% 
  group_by(ano, `DP - CIRCUNSCRICAO`) %>% 
  summarise(vitimas = sum(vitimas)) %>% 
  arrange(desc(vitimas))








# Gráfico de barras



latrocinio_linhatempo <- latrocinio_linhatempo %>% 
  mutate(mes = lubridate::month(mes, label = TRUE)) %>% 
  group_by(mes, ano) %>% 
  count() %>% 
  arrange()

latrocinio_linhatempo %>% filter(ano == 2020) %>% ungroup() %>% 
  plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
  layout(yaxis = list(title = '', showgrid = F),
         xaxis = list(title = '', showgrid = F)) %>% 
  layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16))) %>% 
  layout(xaxis = list(categoryorder = "mes",
                      categoryarray = c("jan", "fev", "mar", "abr", "mai",
                                        "jun","jul","ago","set","out","nov","dez")))







# checagem dps que faltam

teste <- latrocinio %>% filter(ano == 2021)

dps <- unique(teste$DP_COD)


dps %>% sort()


dps_completo %>% sort()


dps_completo