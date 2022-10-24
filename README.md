# Crimes SP - Dashboard


Caso queira acessar o Dashboard [clique aqui](https://caio-martins.shinyapps.io/Crimes-SP-Dashboard/)

Dashboard com alguns dos dados da criminalidade em SP entre 2018 e 2021.
Este projeto é inspirado num infográfico do [Estadão](https://infograficos.estadao.com.br/cidades/criminalidade-bairro-a-bairro/) 

Como o infográfico do Estadão só compreende até o ano de 2017, quis realizar para os períodos subsequentes.

O Dashboard aqui desenvolvido contemplará os seguintes crimes: roubos de celulares, roubos de veículos, homicídios e latrocínios. 

O Dashboard contemplará 3 infográficos:

1. Mapa dos crimes. Mapa com os dados agregados por distrito policial
2. Tabela interativa com o número de ocorridos por Delegacias de Polícias
3. Gráfico com o número de ocorridos ao longo do ano


### Metodologia:

A manipulação e limpeza dos dados foi realizada utilizando o R (tidyverse). O dashboard foi construído utilizando o pacote Shiny e o Shinydashboard.

Os dados podem ser encontrados neste [link](http://www.ssp.sp.gov.br/transparenciassp/Consulta.aspx) no site da Segurança Pública de SP.


Para agrupar os dados corretamente procurei a metodologia disponibilizada no [site](http://www.ssp.sp.gov.br/transparenciassp/Consulta.aspx) 'Exportar Metodologia'. No entanto, a metodologia não explica em detalhes, o que não ajuda muito. Entretanto, procurei seguir as diretrizes "Para conclusões quanto as quantidades de ocorrências é necessária exclusão das duplicidades por meio dos campos: NOME_DELEGACIA,ANO_BO, NUM_BO ".

Conforme as análises iam avançando, realizei comparativos com algumas informações disponibilizadas pela própria SSP, pela Folha de SP e pela FECAP. Em alguns tipos de crimes como "Latrocínio" e "Homicidios" chegamos aos mesmos números de ocorridos. Mas já em crimes de "Roubos de Celulares" e "Roubos de Veículos" há uma certa inconsistência nos valores encontrados. 

Por exemplo, a [Folha de SP](https://www1.folha.uol.com.br/cotidiano/2022/02/roubo-de-celular-se-concentra-na-volta-para-casa-e-na-periferia-de-sp.shtml) levanta que em 2021 a 47º DP Capão Redondo registrou 4045 casos de roubos de celulares no ano de 2021. Já a [FECAP](https://www.fecap.br/2022/03/03/roubo-e-furto-de-celulares-estudo-da-fecap-lista-locais-ruas-e-bairros-mais-perigosos-da-cidade-sp/) levanta que em 2021 houve 3389 roubos no Capão Redondo.

Nas minhas análises, agrupei os ocorridos por "Data de Ocorrência" ao invés de "Data de Emissão de BO". 


## Dashboard

Caso queira acessar o Dashboard [clique aqui](https://caio-martins.shinyapps.io/Crimes-SP-Dashboard/)

Como ficou o dashboard ?



![dashboard3_imagem](https://user-images.githubusercontent.com/75284489/197599920-422ab207-711c-4f75-ba1f-d83210dd371a.png)

Como podemos ver na imagem acima, há na barra lateral esquerda os tipos de crime. Após selecionar o crime na lateral esquerda, é possível selecionar o ano de visualização.

![dashboard_imagem](https://user-images.githubusercontent.com/75284489/197599914-8b5991d9-a523-4cb0-90ac-2fcf37be2ac2.png)

O mapa é interativo, ou seja, podemos passar o mouse pelos distritos que nos informa o nome da Delegacia, o número e a quantidade de ocorridos.

A tabela do lado direito também é interativa, podendo pesquisar o nome da delegacia de interesse.

![imagem2_dash](https://user-images.githubusercontent.com/75284489/197599922-391a6582-b501-492a-9ede-e5695db2bacf.png)

