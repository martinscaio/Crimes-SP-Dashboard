library(tidyverse)
library(sf)
library(ggiraph)
library(reactlog)


# Importando dados


homicidio_18 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Homicidios\\Homicidio_2017_2022.xlsx", sheet = '2018')
homicidio_19 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Homicidios\\Homicidio_2017_2022.xlsx", sheet = '2019')
homicidio_20 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Homicidios\\Homicidio_2017_2022.xlsx", sheet = '2020')
homicidio_21 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Homicidios\\Homicidio_2017_2022.xlsx", sheet = '2021')
homicidio_22 <- readxl::read_excel("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Homicidios\\Homicidio_2017_2022.xlsx", sheet = '2022 Jan a Ago')


# Funções para limpar


limpeza_homicidio <- function(dado){
  
  provisorio <- dado %>% 
    dplyr::filter(DEPARTAMENTO_CIRC == 'DECAP') %>% 
    dplyr::distinct(ANO_BO,NUM_BO,`DP - CIRCUNSCRICAO`, .keep_all = TRUE) %>% 
    dplyr::mutate(DP_COD = str_extract(`DP - CIRCUNSCRICAO`, "[0-9]+"),
                  DP_COD = as.integer(DP_COD),
                  ocorrencia = lubridate::ymd(DATA_FATO),
                  BO_EMITIDO = lubridate::date(DATAHORA_REGISTRO_BO),
                  BO_EMITIDO = lubridate::ymd(BO_EMITIDO),
                  diferenca_tempo = difftime(BO_EMITIDO, ocorrencia, units = 'days'))
  
  
  
}



arrumar_homicidio <- function(dado){
  
  data_errada <- dado %>% 
    dplyr::filter(diferenca_tempo > 180)
  
  
  data_certa <- data_errada %>% 
    dplyr::mutate(ocorrencia = BO_EMITIDO)
  
  
  dados_arrumados <- data.table::setDT(dado)[data.table::setDT(data_certa), on = "NUM_BO", ocorrencia := i.ocorrencia]
  
  
  arrumar_na <- dado %>% filter(is.na(ocorrencia)) %>% mutate(ocorrencia = BO_EMITIDO)
  
  
  dados_arrumados <- data.table::setDT(dados_arrumados)[data.table::setDT(arrumar_na), on = "NUM_BO", ocorrencia := i.ocorrencia]
  
  
  dados_arrumados <- dados_arrumados %>% 
    dplyr::mutate(mes_ocorrencia = lubridate::month(ocorrencia),
                  ano_ocorrencia = lubridate::year(ocorrencia),
                  dia_ocorrencia = lubridate::day(ocorrencia),
                  mes_boletim = lubridate::month(BO_EMITIDO),
                  ano_boletim = lubridate::year(BO_EMITIDO),
                  dia_boletim = lubridate::day(BO_EMITIDO))
  
  
  
}


homicidio_20 <- homicidio_20 %>% mutate(NUM_BO = as.character(NUM_BO),
                                        NUMERO_LOGRADOURO = as.character(NUMERO_LOGRADOURO))



homicidio_21 <- homicidio_21 %>% mutate(NUM_BO = as.character(NUM_BO),
                                        NUMERO_LOGRADOURO = as.character(NUMERO_LOGRADOURO))



# aplicação da limpeza



homicidio <- list(homicidio_18,homicidio_19, homicidio_20,homicidio_21) %>% 
  map(limpeza_homicidio) %>% 
  map(arrumar_homicidio) %>% 
  reduce(full_join)


homicidio_tabela <- homicidio


homicidio <- homicidio %>% select(DP_COD, ano_ocorrencia, `Nº DE VÍT HD`)



# Quais são as dps com 0 ocorrencias. Preencher


# em 2018 falta dp 18,31,56
# em 2019 falta dp 36, 51,52,57,93,
# em 2020 falta 26, 27,36,57,102,103
# em 2021 falta 18,27,36,57,81,93,

homicidio <- homicidio %>% 
  add_row(DP_COD = 18, ano_ocorrencia = 2018, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 31, ano_ocorrencia = 2018, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 56, ano_ocorrencia = 2018, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 36, ano_ocorrencia = 2019, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 51, ano_ocorrencia = 2019, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 52, ano_ocorrencia = 2019, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 57, ano_ocorrencia = 2019, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 93, ano_ocorrencia = 2019, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 26, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 27, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 36, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 57, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 102, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 103, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>%
  add_row(DP_COD = 96, ano_ocorrencia = 2020, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 18, ano_ocorrencia = 2021, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 27, ano_ocorrencia = 2021, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 36, ano_ocorrencia = 2021, `Nº DE VÍT HD` = 0) %>% 
  add_row(DP_COD = 57, ano_ocorrencia = 2021, `Nº DE VÍT HD` = 0)%>% 
  add_row(DP_COD = 81, ano_ocorrencia = 2021, `Nº DE VÍT HD` = 0)%>% 
  add_row(DP_COD = 93, ano_ocorrencia = 2021, `Nº DE VÍT HD` = 0)






homicidio <- homicidio %>% group_by(DP_COD, ano_ocorrencia) %>% summarise(vitimas = sum(`Nº DE VÍT HD`))





# IMPORTANDO ARQUIVO SHAPE-------------------------------------------------

zonas_elec_sp <- read_sf("C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\arquivo shape\\DISTPOL2021_MSP_CEM_V1.shp")


# -----------------------




homicidio <- zonas_elec_sp %>% left_join(homicidio, by = 'DP_COD') 



homicidio <- homicidio %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Vítimas:",vitimas))


homicidio$homicidios <-  cut(homicidio$vitimas, 
                             breaks=c(-1, 4, 10, 20, 30,40), 
                             labels=c("0 - 4", "5 - 10", "11 - 20", 
                                      "21 - 30", "31 - 40"), right = TRUE) 







# Mapa


a = homicidio %>% filter(ano_ocorrencia == 2018) %>% 
  ggplot(aes()) + 
  geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id, # preciso arrumar isso
                      aes(fill = homicidios,tooltip = tooltip))+
  #scale_fill_continuous(high = "#132B43", low = "#56B1F7", name = '')+
  #scale_fill_distiller_interactive(name = "Score", palette = 1)+
  scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01"))+
  theme_void() + 
  theme(panel.grid.minor = element_blank(),
        rect = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
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


h = girafe(ggobj =  a, 
           options = list(
             opts_tooltip(css = tooltip_css),
             opts_zoom(max = 5),
             opts_hover_inv(css = "opacity:0.5;"),
             opts_hover(css = "stroke:red;stroke-width:1.0;")
           ) )


h


# teste 

teste <- homicidio

teste$homicidio <- cut(teste$vitimas, 
                   breaks=c(-1, 5, 10, 20, 30, 40), 
                   labels=c("0 - 5", "5 - 10", "10 - 20", 
                            "20 - 30", "30 - 40"))



teste %>% view()




a = teste %>% filter(ano_ocorrencia == 2021) %>% 
  ggplot(aes()) + 
  geom_sf_interactive(color = 'gray50', size = 0.2, data_id = roubos_delegacia_21$`DP_COD`, # preciso arrumar isso
                      aes(fill = homicidio,tooltip = tooltip))+
  #scale_fill_continuous(high = "#132B43", low = "#56B1F7", name = '')+
  #scale_fill_distiller_interactive(name = "Score", palette = 1)+
  scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01"))+
  theme_void() + 
  theme(panel.grid.minor = element_blank(),
        rect = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
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


h = girafe(ggobj =  a, 
           options = list(
             opts_tooltip(css = tooltip_css),
             opts_zoom(max = 5),
             opts_hover_inv(css = "opacity:0.5;"),
             opts_hover(css = "stroke:red;stroke-width:1.0;")
           ) )


h



# check pra ver as DPS faltantes

teste <- homicidio %>% filter(ano_ocorrencia == 2020)


dps <- unique(teste$DP_COD)


dps_completo <- unique(homicidio$DP_COD)


dps %>% sort()

dps_completo %>% sort()


dps_completo






# Tabela



homicidio_tabela %>% select(`DP - CIRCUNSCRICAO`)

homicidios_tab <- homicidio_tabela %>% 
  #filter(ano_ocorrencia == 2021) %>%
  group_by(`DP - CIRCUNSCRICAO`, ano_ocorrencia) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  rename(DELEGACIA = `DP - CIRCUNSCRICAO`,
         'NÚMERO DE ROUBOS' = n,
         ANO = ano_ocorrencia)

homicidios_tab %>% filter(ANO == 2021) %>% 
  DT::datatable()





# Gráfico plotly 




homicidio_linhatempo <- homicidio_tabela %>% 
  mutate(mes = lubridate::month(mes_ocorrencia, label = TRUE)) %>% 
  group_by(mes, ano_ocorrencia) %>% 
  count() %>% 
  arrange()


homicidio_linhatempo %>% filter(ano_ocorrencia == 2021) %>% ungroup() %>% 
  plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
  layout(yaxis = list(title = '', showgrid = F),
         xaxis = list(title = '', showgrid = F)) %>% 
  layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16)))
