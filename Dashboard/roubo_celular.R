# Biblioteca

library(tidyverse)
library(readxl)
library(sf)
library(purrr)
library(lubridate)
library(DT)
library(plotly)
library(leaflet)
library(ggiraph)
library(highcharter)
library(highcharter)


# IMPORTAÇÃO DOS DADOS--------------------------------------------------------------------------


dez <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\novo.xlsx")

jan <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_01.xlsx")

fev <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_02.xlsx")

mar <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_03.xlsx")

abr <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_04.xlsx")

mai <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_05.xlsx")

jun <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_06.xlsx")

jul <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_07.xlsx")

ago <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_08.xlsx")

set <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_09.xlsx")

out <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_10.xlsx")

nov <- read_xlsx("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Celulares\\roubos celular 2021_11.xlsx")






# IMPORTAR DADOS DE 2022



jan22 <- read_delim('C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\Dados\\2022\\dados_sem_bug\\DadosBO_2022_1(ROUBO DE CELULAR) (1).csv', delim = ';')


fev22 <- read_delim('C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\Dados\\2022\\dados_sem_bug\\DadosBO_2022_2(ROUBO DE CELULAR) (1).csv', delim = ';')


mar22 <- read_delim('C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\Dados\\2022\\dados_sem_bug\\DadosBO_2022_3(ROUBO DE CELULAR) (1).csv', delim = ';')


abr22 <- read_delim('C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\Dados\\2022\\dados_sem_bug\\DadosBO_2022_4(ROUBO DE CELULAR) (1).csv', delim = ';')



mai22 <- read_delim('C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\Dados\\2022\\dados_sem_bug\\DadosBO_2022_5(ROUBO DE CELULAR).csv', delim = ';')






# CRIANDO FUNÇÕES PARA ARRUMAR OS DADOS--------------------------------------------------------------------------



limpeza <- function(dado){
  
  provisorio <- dado %>% 
    dplyr::filter(!str_detect(DELEGACIA_CIRCUNSCRICAO, '^DEL.SEC'))  %>% 
    dplyr::distinct(NUM_BO,ANO_BO, DELEGACIA_CIRCUNSCRICAO, .keep_all = TRUE) %>%  # alterei aqui 16/10
    tidyr::separate(BO_EMITIDO, into = c('BO_EMITIDO', 'horario'), sep = ' ') %>% 
    dplyr::mutate(#DELEGACIA_CIRCUNSCRICAO = case_when(DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.1ª CENTRO' ~ '03º D.P. CAMPOS ELISEOS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.7ª ITAQUERA' ~ '32º D.P. ITAQUERA',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.3ª OESTE' ~ '14º D.P. PINHEIROS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.8ª SÃO MATEUS' ~ '49º D.P. SAO MATEUS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.2ª SUL' ~ '96º D.P. MONÇÕES',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.5ª LESTE' ~ '81º D.P. BELEM',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.6ª SANTO AMARO' ~ '11º D.P. SANTO AMARO',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.4ª NORTE' ~ '13º D.P. CASA VERDE',
                  #                                    TRUE ~ DELEGACIA_CIRCUNSCRICAO),
                  DP_COD = str_extract(DELEGACIA_CIRCUNSCRICAO, "[0-9]+"),
                  DP_COD = as.integer(DP_COD),
                  ocorrencia = lubridate::ymd(DATAOCORRENCIA),
                  BO_EMITIDO = lubridate::ymd(BO_EMITIDO),
                  diferenca_tempo = difftime(BO_EMITIDO, ocorrencia, units = 'days'))
  
  
  
}




arrumar <- function(dado){
  
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





# OS DADOS DE 2022 ESTÃO EM OUTRO FORMATO POR ISSO VOU REPLICAR AS FUNÇÕES DE LIMPEZA COM
# ALTERAÇÃO EM UMA LINHA 




limpeza_22 <- function(dado){
  
  provisorio <- dado %>% 
    dplyr::filter(str_detect(RUBRICA, '^Roubo') & STATUS == 'Consumado') %>% 
    dplyr::distinct(NUM_BO, .keep_all = TRUE) %>% 
    tidyr::separate(BO_EMITIDO, into = c('BO_EMITIDO', 'horario'), sep = ' ') %>% 
    dplyr::mutate(#DELEGACIA_CIRCUNSCRICAO = case_when(DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.1ª CENTRO' ~ '03º D.P. CAMPOS ELISEOS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.7ª ITAQUERA' ~ '32º D.P. ITAQUERA',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.3ª OESTE' ~ '14º D.P. PINHEIROS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.8ª SÃO MATEUS' ~ '49º D.P. SAO MATEUS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.2ª SUL' ~ '96º D.P. MONÇÕES',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.5ª LESTE' ~ '81º D.P. BELEM',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.6ª SANTO AMARO' ~ '11º D.P. SANTO AMARO',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.4ª NORTE' ~ '13º D.P. CASA VERDE',
                  #                                    TRUE ~ DELEGACIA_CIRCUNSCRICAO),
                  DP_COD = str_extract(DELEGACIA_CIRCUNSCRICAO, "[0-9]+"),
                  DP_COD = as.integer(DP_COD),
                  ocorrencia = lubridate::dmy(DATAOCORRENCIA), # alteração desta função para a outra limpeza()
                  BO_EMITIDO = lubridate::dmy(BO_EMITIDO),     # alteração aqui também
                  diferenca_tempo = difftime(BO_EMITIDO, ocorrencia, units = 'days'))
  
  
  
}








# LIMPANDO OS DADOS--------------------------------------------------------------

# dados 2021

dados_21 <- list(dez, abr, fev, jan, mar, abr, mai, jun, jul, ago, set, out, nov) %>% 
  map(limpeza) %>% 
  map(arrumar) %>% 
  reduce(full_join)





dados_22 <- list(jan22, fev22, mar22, abr22, mai22) %>% 
  map(limpeza_22) %>% 
  map(arrumar) %>% 
  reduce(full_join)



# Retirando algumas colunas que entram em conflito e não são mais úteis


dados_21 <- dados_21 %>% select(c(-BO_INICIADO,
                                  -DATAOCORRENCIA,
                                  -HORAOCORRENCIA,
                                  -DATACOMUNICACAO,
                                  -DATAELABORACAO,
                                  -DATANASCIMENTO))

dados_22 <- dados_22 %>% select(c(-BO_INICIADO,
                                  -DATAOCORRENCIA,
                                  -HORAOCORRENCIA,
                                  -DATACOMUNICACAO,
                                  -DATAELABORACAO,
                                  -DATANASCIMENTO))


# Juntando os dados de 2021 e 2022 num só dataframe



# roubos <- dados_21 %>% full_join(dados_22)


roubos <- dados_21


roubos %>% filter(ano_ocorrencia == 2021) %>%  group_by(DELEGACIA_CIRCUNSCRICAO) %>% count() %>% arrange(desc(n))


roubos <- roubos %>% group_by(DP_COD, ano_ocorrencia) %>% count() %>% arrange(desc(n))



# IMPORTANDO ARQUIVO SHAPE-------------------------------------------------

zonas_elec_sp <- read_sf("C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\arquivo shape\\DISTPOL2021_MSP_CEM_V1.shp")






roubos <- zonas_elec_sp %>% left_join(roubos, by = 'DP_COD') 




roubos <- roubos %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Roubos:",n))






# MAPA --------------------



roubos$Numero <- cut(roubos$n, 
                              breaks=c(100,400, 700, 1000, 1300,1600,2000,2500,3500,4200), 
                              labels=c("100-400","401-700", "701-1000", "1001-1300","1301-1600","1601-2000","2001-2500",
                                       "2501-3500","3501-4200"), right = FALSE)




t = roubos %>%
  filter(ano_ocorrencia == 2021) %>% 
  ggplot(aes()) + 
  geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id,
                      aes(fill = Numero,tooltip = tooltip))+
  scale_fill_manual(values = c("#FCF7CC", "#F1E57E","#DFCE39","#DFAF2E","#DE9B14", "#DE7F14","#DC5B02","#DC4102","#C60F00"))+
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




# dados tabela

dados_tabela <- dados_21 %>% 
  group_by(DELEGACIA_CIRCUNSCRICAO, ano_ocorrencia) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  rename(DELEGACIA = DELEGACIA_CIRCUNSCRICAO,
         'NÚMERO DE ROUBOS' = n)




# gráfico de barras

dados_linhatempo <- dados_21 %>% 
  mutate(mes = lubridate::month(mes_ocorrencia, label = TRUE)) %>% 
  group_by(mes, ano_ocorrencia) %>% 
  count() %>% 
  arrange()





# TESTE PLOTLY



library(plotly)

dados_linhatempo %>% filter(ano_ocorrencia == 2021) %>% ungroup() %>% 
  plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
  layout(yaxis = list(title = '', showgrid = F),
         xaxis = list(title = '', showgrid = F))


