library(shiny)
library(shinythemes)

shinyUI(navbarPage("",theme = shinytheme("flatly"),
                   
                  
                   tabPanel("Objetivo del estudio",
                            column(8,imageOutput('imagen1')),
                            column(4,
                                   wellPanel(h1('El',span('"Happy Index"' , style = "color:red"), 
                                                  'surge de la necesidad de tener un 
                                                   monitor sobre la salud laboral del grupo, esto con 
                                                   el fin de mantener la rotación en un nivel manejable 
                                                   y, además, encontrar cuáles son los drivers que 
                                                   influyen en la percepción de 
                                                   felicidad en los trabajadores.',align="justify"),
                                             style = "background-color: white;")
                                      ),
                            column(1)),
                   navbarMenu("Estructura de la batería",
                              tabPanel("Consistencia de la batería",
                                       fluidPage(
                                         
                                         column(4,
                                                fluidRow(
                                           wellPanel(
                                             
                                            
                                             h2("Análisis de correlaciones",align="center"),
                                             p("Esta gráfica nos dice cómo se relacionan las preguntas (de ahora en adelante referidos como'items') 
                                               de la batería entre sí.", style = "font-size:16pt"),
                                             p('Se obtuvo un Alpha de Cronbach superior a 0.8 y una
                                               Lambda de Gutman mayor a 0.8; esto nos dice que los elementos de la batería se correlacionan
                                               positivamente y de manera significativa.', style = "font-size:16pt")
                                             )),
                                           fluidRow(wellPanel(
                                             style = "background-color: #2c3e50;",
                                             h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                             p('Los puntos azules indican una correlación positiva, mientras que en rojo se encuentran los que tienen correlación 
                                               negativa. Entre más grandes y obscuros sean los puntos mayores son las correlaciones.', style = "color:#C2D1E0; font-size:16pt"),
                                             p('En la gráfica se observan pequeños conglomerados de correlaciones, por ejemplo vemos que las variables 
                                               relacionadas con la evaluación del "jefe" tienen correlaciones altas entre sí.',
                                               style = "color:#C2D1E0; font-size:16pt"),
                                             p('Este análisis nos dice que la batería es consistente, en otras palabras, es correcto construir un índice
                                               general',style = "color:#C2D1E0; font-size:16pt")


                                           )
                                           )),
                                           column(8,
                                             plotOutput('plot1',width = "100%"),
                                             align="center"
                                           )
                                         )
                                       
                              ),
                              tabPanel("Dimensionalidad de la batería",
                                       fluidPage(
                                         
                                         
                                           column(4,wellPanel(
                                             h2("Análisis de factores",align="center"),
                                           
                                             p("El análisis factorial señala que el número óptimo de factores es 5. La 
                                               gráfica nos indica del lado izquierdo la agrupación de los items en factores, y los números
                                               representan la varianza de la variable explicada por el factor asocicado.",style = "font-size:14pt"),
                                             h2("Mapa de correlaciones",align="center"),
                                             p("Por otro lado, el mapa de correlaciones nos da la versión gráfica de una matriz de correlaciones, 
                                               las variables están iluminadas de 5 colores distintos, correspondientes a los 5 
                                               factores que se encontraron.",style = "font-size:14pt"),
                                             radioButtons("gcor", label = h3("Gráficos de dimensionalidad",align="center",style = "font-size:14pt"),
                                                          choices = list("Análisis de Factores" = 1, "Mapa de Correlaciones" = 2), 
                                                          selected = 1)
                                              ),
                                             wellPanel(
                                               style = "background-color: #2c3e50;",
                                               h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                               p('La batería se construyó tomando en cuenta 8 dimensiones. Analizando los modelos con cinco, seis, siete y ocho factores 
                                                  encontramos que el modelo con cinco es el que mejor explica la bateria.
                                                  Esto pues las correlaciones entre los factores nos dicen que las 5 dimensiones son rasgos de una característica general: 
                                                  la satisfacción laboral del empleado.',style = "color:#C2D1E0; font-size:14pt"),
                                               p('En el mapa de correlaciones las variables más cercanas tienen una relación más fuerte y viceversa.',style = "color:#C2D1E0; font-size:14pt")
                                               
                                               
                                               )
                                             ),
                                           column(8, align="center",
                                                  conditionalPanel(
                                                    condition = "input.gcor==1",
                                                    imageOutput("factores")
                                                  ),
                                                  conditionalPanel(
                                                    condition = "input.gcor==2",
                                                    plotOutput("qgraph")
                                                  ))
                                           )
                                       )
                              ),
                   tabPanel("Dimensiones de la batería",
                            fluidPage(
                              
                              
                              column(12,wellPanel(
                                style = "background-color: #FF5050;",
                                h2('Ambiente'),
                                h4(strong('En esta dimensión se encuentran las variables que reflejan el sentir 
                                  del empleado dentro de la organización.'),style = "font-size:15pt"),
                                p('La conforman la percepción de capacidad de desarrollo y habilidades, las oportunidades de crecer, 
                                  la identificación con la empresa, el sentimiento de orgullo asociado, el sentir general y la 
                                  percepción de las metas familiares como asequibles.',style = "font-size:15pt")
                                
                                
                              ),wellPanel(
                                style = "background-color: #FFFF99;",
                                h2('Convivencia'),
                                h4(strong('Esta dimensión resume el sentir del empleado alrededor de sus interacciones con sus compañeros.'),style = "font-size:15pt"),
                                p('La integran las percepciones que se tienen sobre sus compañeros, desde si son agradables, si los 
                                  considera como parte de su familia, si considera que estos proveen un trabajo de calidad, si 
                                  cree que pueden llegar a ser sus amigos, si se siente parte de un equipo, si sus compañeros reconocen 
                                  su trabajo y si se siente motivado por el ambiente.',style = "font-size:15pt")
                                
                                
                              ),wellPanel(
                                style = "background-color: #99FF99;",
                                h2('Percepción del jefe inmediato'),
                                h4(strong('Esta dimensión habla de la percepción que se tiene del jefe inmediato.'),style = "font-size:15pt"),
                                p('Esta constituida la percepción del jefe como ejemplo a seguir, su accesibilidad, su capacidad de 
                                  liderazgo y el interés que el empleado percibe por parte del mismo.',style = "font-size:15pt")
                                
                                
                                ),wellPanel(
                                  style = "background-color: #3399FF;",
                                  h2('Reconocimiento'),
                                  h4(strong('Esta dimensión refleja el reconocimiento que siente tener el empleado.'),style = "font-size:15pt"),
                                  p('Sus items componentes son la percepción del reconocimiento en la última semana, 
                                      reconocimiento del trabajo excepcional, el sentir que su opinión cuenta y el 
                                      tener un equipo necesario para trabajar',style = "font-size:15pt")
                                  
                                  
                                ),wellPanel(
                                  style = "background-color: #9999FF;",
                                  h2('Seguridad'),
                                  h4(strong('Esta dimensión se refiere a la seguridad que el empleado tiene sobre su plaza.'),style = "font-size:15pt"),
                                  p('La componen la seguridad de mantener el trabajo a corto y largo plazo, así como 
                                    la percepción de objetivos claros.',style = "font-size:15pt")
                                  
                                  
                                  )
                                
                              )
                            )
                   ),
                   
                   tabPanel("Gráficas",
                            fluidPage(column(3,
                                  wellPanel(
                                    selectInput('filtrovar',label=h4('Variable de filtro'),
                                                    choices=list( "Plaza" = "PLAZA",
                                                                  "División" = "Division",
                                                                  "Ubicación" = "Ubicacion",
                                                                  "Territorio" = "Territorio",
                                                                  "Zona" = "Zona",
                                                                  "Género" = "SEXO",
                                                                  "Edad" = "EDAD_C",
                                                                  "Antigüedad" = "ANTIGUEDAD_C",
                                                                 "Total"),
                                               selected="Total"
                                             ),
                                             radioButtons('filtrocat',label=h4('Categoría de filtro'),
                                                          choices=list('MASCULINO'='MASCULINO','FEMENINO'='FEMENINO')),
                                    helpText('Selecciona la variable sobre la que quieres filtrar.')
                                             ),
                              wellPanel(
                                selectInput("facet", label = h4("Variable 1"), 
                                            choices = list( "Género" = "SEXO", 
                                                            "Plaza" = "PLAZA",
                                                            "División" = "Division",
                                                            "Ubicación" = "Ubicacion",
                                                            "Territorio" = "Territorio",
                                                            "Zona" = "Zona",
                                                            "Edad" = "EDAD_C",
                                                            "Antigüedad" = "ANTIGUEDAD_C",
                                                            "Total"), selected = "Total"),
                                
                                selectInput("variable", label = h4("Variable 2"), 
                                            choices=list("Admiro el liderazgo de mi jefe"="jefe.liderazgo",
                                                         "Así me siento por trabajar en Elektra"="as<ed>.me.siento",
                                                         "Considero que mi jefe es un ejemplo a seguir"="jefe.ejemplo",
                                                         "Considero que soy parte de un equipo"="soy.parte.equipo",
                                                         "Cuando pienso en mi futuro, tengo la seguridad que trabajré aquí los próximos 3 años"="seguridad.largo.plazo",
                                                         "Dentro de Elektra estimulan mi desarrollo profesional y humano"="desarrollo.prof.y.humano",
                                                         "El ambiente laboral me motiva a dar lo mejor de mi"="ambiente.motiva",
                                                         "Elektra me da la oportunidad de desarrollar mis habilidades"="oportunidad.des.habilidades",
                                                         "En Elektra me hacen sentir que mi trabajo es importante"="mi.trabajo.importa",
                                                         "En Elektra se reconocen a las personas que realizan trabajo excepcional"="reconocen.trabajo.excepcional",
                                                         "En la última semana han reconocido mi esfuerzo"="reconocimiento.ultima.semana",
                                                         "Estoy seguro de mantener mi trabajo el próximo mes"="seguridad.corto.plazo",
                                                         "Me identifico con la misión y los valores de Elektra"="me.identifico",
                                                         "Me siento orgulloso de pertenecer a Elektra"="estoy.orgulloso",
                                                         "Mi jefe muestra interés en mi sentir como persona y no sólo como empleado"="jefe.se.interesa.en.m<ed>",
                                                         "Mis compañeros de trabajo son como mi segunda familia"="companeros.familia",
                                                         "Mis compañeros están comprometidos a brindar un trabajo de calidad"="companeros.calidad",
                                                         "Mis compañeros reconocen mi progreso"="companeros.reconocen",
                                                         "Mis opiniones son tomadas en cuenta"="mi.opini<f3>n.cuenta",
                                                         "Por lo general mis compañeros de trabajo son agradables"="companeros.agradables",
                                                         "Se pueden tener buenos amigos en el trabajo"="companeros.amigos",
                                                         "Si tuviera que definir como es mi jefe, sería de la siguiente forma"="jefe.accesible",
                                                         "Siento que puedo realizar mis metas familiares, trabajando en Elektra"="metas.familiares",
                                                         "Tengo claros los objetivos de mi puesto"="objetivos.claros",
                                                         "Tengo el material y equipo necesario para hacer correctamente mi trabajo"="equipo.necesario",
                                                         "Score"= "score",
                                                         "Score Ambiente" = "score_ambiente",
                                                         "Score Conveniencia" = "score_convivencia",
                                                         "Score Jefe" = "score_jefe",
                                                         "Score Seguridad" = "score_seguridad",
                                                         "Score Reconocimiento" = "score_reconocimiento")
                                            
                                ),
                                helpText('Selecciona las variables con las que deseas crear el cruce, para obtener las frecuencias simples 
                                         selecciona como primer variable "Total".')
                                )),
                              column(9,
                                   plotOutput("descriptivo",height=1000,width=1300),align="center")
                              
                   )),
                   
                   
                   
                   
                   
                   navbarMenu('Análisis secundario',
                              tabPanel('Importancia de las variables',
                                       fluidPage(
                                         column(3,
                                                wellPanel(
                                                  h2("Importancia de las variables",align="center"),
                                                  p("Haciendo uso de la equivalencia entre IRT y el análisis factorial se obtuvieron
                                                    los pesos para cada una de las preguntas que forman la bateria para el índice.",
                                                    style = "font-size:16pt"),
                                                  p('En la gráfica derecha mostramos  cada una de las preguntas de la bateria 
                                                    ordenadas por la importancia que tuvieron para la creación del índice'
                                                    ,style = "font-size:16pt")
                                                  
                                                  ), wellPanel(
                                                    style = "background-color: #2c3e50;",
                                                    h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                                    p('Vemos que la pregunta más importante es la que indica cómo se sienten los trabajadores;
                                                      podemos ver también que cinco de los primeros diez lugares los ocupan preguntas que
                                                      pertenecen a la dimensión de "Ambiente".',style = "color:#C2D1E0; font-size:16pt")
                                                    )
                                                    ),
                                         column(9,
                                                plotOutput('graf_pesos',width = "100%"),
                                                align="center"
                                         )
                                                    )),
                              tabPanel('Importancia de las dimensiones',
                                       fluidPage(
                                         column(3,
                                                wellPanel(
                                                  h2("Importancia de las dimensiones",align="center"),
                                                  p("Para cada una de las 5 dimensiones se calculó un índice. Estos índices se utilizaron en un modelo de bosques 
                                                    aleatorios para explicar al índice general; como resultado se obtuvo que el 98% de la variablildad del índice
                                                    general se explica con estas cinco variables.",style = "font-size:16pt"),
                                                  p('En la gráfica de la derecha se puede ver qué tan importante es cada una de las dimensiones para explicar al score
                                                    general.',style = "font-size:16pt")
                                                  
                                                  ), wellPanel(
                                                    style = "background-color: #2c3e50;",
                                                    h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                                    p('Los rubros de ambiente y convivencia son los que 
                                                      mayor impacto tienen en la felicidad percibida 
                                                      por los empleados. Sin embargo la escala es corta, es decir,  
                                                      a pesar de que el score de reconocimiento sale como el "menos" importante, sigue 
                                                      siendo influyente en la calificación general.',style = "color:#C2D1E0; font-size:16pt")
                                                    )
                                                    ),
                                         column(9,
                                                plotOutput('importancia',width = "100%"),
                                                align="center"
                                         )
                                                    )),
                              tabPanel('Información de los items',
                                       fluidPage(
                                         column(3,
                                                wellPanel(
                                                  h2('Curvas de información',align="center"),
                                                  p('En esta gráfica se muestran las trazas de información de los items. Aquí encontramos que tanto
                                                    aporta cada item para discernir entre la felicidad de los socios.',style = "font-size:16pt")
                                                ), wellPanel(
                                                  style = "background-color: #2c3e50;",
                                                  h2('¿Qué significa?',style = "color:#C2D1E0",align="center"),
                                                  p('Dependiendo de en donde se encuentre el pico de la distribución podemos inferir el lugar en el que 
                                                    tiene impacto, por ejemplo la primer variable "objetivos claros" discrimina del lado más bajo de la escala,
                                                    es decir nos da información sobre las personas más infelices.
                                                    ',style = "color:#C2D1E0; font-size:16pt"),
                                                  p('Por otro lado la altura de las distribuciones nos indica que tan bien discrimina el item, por ejemplo,
                                                     la variable "mi opinión cuenta" discrimina muy bien en el centro de la escala.',style = "color:#C2D1E0; font-size:16pt")
                                                )),
                                         column(9,
                                                imageOutput('discriminacion'),
                                                align="center"
                                                )
                                       )),
                              tabPanel('Estructura relacional de los items',
                                       fluidPage(column(4,
                                                        wellPanel(
                                                          h2('Red condicional bayesiana',align="center"),
                                                          p('Este modelo crea una gráfica direccionada utilizando las probabilidades condicionales entre las 
                                                            variables',style = "font-size:16pt")
                                                        ), wellPanel(
                                                          style = "background-color: #2c3e50;",
                                                          h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                                          p('Supongamos que tenemos temas específicos sobre los cuáles queremos mejorar los resultados; con este modelo
                                                            obtenemos cuáles son los caminos que debemos de seguir para lograr esas mejoras. Por ejemplo, si quisiéramos  
                                                            lograr que los trabajadores sintieran que su trabajo importa tendríamos que trabajar para lograr que sientan
                                                            que el ambiente de trabajo en el que están los motiva y además trabajar en que exista un sentido de pertenencia 
                                                            a un equipo; esto último se logra fomentando el compañerismo (mis compañeros son de calidad, son mis amigos, son agradables,
                                                            son como mi segunda familia).',style = "color:#C2D1E0; font-size:16pt"),
                                                          p('De nuevo confirmamos la importancia de las dimensiones de ambiente y convivencia al ver que las 
                                                            variables que las componen se ubican en la parte superior de la red.',style = "color:#C2D1E0; font-size:16pt")
                                                          )),
                                                        column(8,
                                                               imageOutput('red',width=900, height = 900),
                                                               align="center"
                                                        ))
                              
                              )
),
tabPanel("Conclusiones",
         fluidPage(
        column(12,wellPanel(
               style = "background-color: #2c3e50;",
               h2(strong('Conclusiones Generales',style = "color:#C2D1E0")),
               p('El objetivo principal de este trabajo es encontrar una forma de cuantificar la salud laboral de
                 los socios con la finalidad de controlar el problema de rotación.',style = "color:#C2D1E0;font-size:16pt"),
               p('Utilizando la información de los modelos llegamos a las siguientes recomendaciones que nos ayudarán a 
                 atacar este problema de forma duradera:',
                 tags$ul(
                   tags$li("Necesitamos crear un sentido de pertenencia y orgullo entre los socios."),
                   tags$li("Para hacer esto necesitamos trabajar sobre dos líneas: la humana y la del trabajo."),
                   tags$li("Para trabajar sobre la línea humana tenemos que", strong(" fomentar "),"en los socios un sentido de", 
                           strong("pertenencia "), "a su equipo de trabajo,", strong("generar un ambiente "), "que los motive a dar lo mejor y ", 
                           strong("reconocer su trabajo."), "Es decir, hay que trabajar sobre las dimensiones de convivencia y reconocimiento."),
                   tags$li("Para trabajar sobre la línea de trabajo tenemos que hacerle saber a los socios que es posible",strong(" desarrollar
                           todas sus habilidades "), "tanto profesionales como humanas dentro del grupo; más aún, que el desarrollo de 
                           estas les permitirá ", strong("crear carrera "),"y así podrán lograr todas las ",strong("metas familiares "),"que tienen. 
                           Es decir, hay que trabajar sobre la dimensión de Ambiente."),
                   tags$li("Haciendo lo anterior obtendremos además, una mejora en la percepción de seguridad que tienen los socios de mantener su 
                           trabajo a corto y largo plazo dentro del grupo."),
                   tags$li("Creemos importante mencionar que a la par hay que asegurarnos que los socios tengan todos los materiales de
                           trabajo que requiere su puesto, pues probablemente alrededor de esta variable puede construirse una dimensión 
                           que propicie mejoras en las dos líneas de trabajo antes mencionadas"),
                   style = "color:#C2D1E0;font-size:16pt"
                  ),style = "color:#C2D1E0;font-size:16pt")
               ),
               wellPanel(
                 style = "background-color: #2c3e50;",
                 h2(strong('Análisis de la batería'),style="color:#C2D1E0"),
                 p('Con el análisis de estructura encontramos que la batería es consistente y que estadísticamente 
                   es válido suponer la existencia de un índice que resuma la información de ésta.',
                   style = "color:#C2D1E0;font-size:16pt"),
                 p('Encontramos que para mejorar la salud laboral del grupo hay que trabajar en cinco aspectos: ',
                   tags$ul(
                     tags$li(strong("Ambiente: "), "agrupa las preguntas relacionadas a desarrollo de habilidades,
                             oportunidad de crecer identificación con el grupo y percepción de metas familiares asequibles."),
                     tags$li(strong("Convivencia: "),"agrupa las preguntas relacionadas con compañerismo, pertenencia a un equipo y ambiente motivador."),
                     tags$li(strong("Reconocimiento: "),"agrupa las preguntas que describen el reconocimiento que siente el empleado
                             en el trabajo."),
                     tags$li(strong("Percepción del jefe inmediato: "), "agrupa las preguntas que hablan sobre el jefe."),
                     tags$li(strong("Seguridad: "),"agrupa las preguntas relacionadas a la rotación."),
                     style = "color:#C2D1E0;font-size:16pt"
                     ),
                   style = "color:#C2D1E0;font-size:16pt"),
                 p('Tomando en cuenta estos cinco aspectos se creó un score que cuantifica la felicidad general de los socios. 
                   Con este score y usando conocimiento experto fácilmente podemos establecer un semáforo que nos indique 
                   que tan contento/descontento está cada uno de los socios.',style = "color:#C2D1E0;font-size:16pt")
                 )
             )
             )
        
  ),tabPanel('Calcular',
             column(4,wellPanel(h2("¿Tienes una nueva base?",align="center"),
                                p("Aquí puedes subir tus datos y calcular el índice utilizando el modelo que obtuvimos.",style = "font-size:16pt"), 
                                p("Lo único que tienes que hacer es subir una nueva base que cumpla con los requerimientos
                                  que el modelo necesita. Estos los puedes consultar en el botón de 'Requerimientos'.",style = "font-size:16pt"),
                                p("Una vez hecho eso automáticamente corremos el modelo sobre los nuevos datos y calculamos todos los índices.Del lado derecho
                                   de la pantalla te mostramos la base que acabas de subir para para que te asegures de que es la que quieres ocupar.",style = "font-size:16pt"),
                                p("Puedes descargar los datos nuevos utilizando el botón de descarga que se encuentra abajo.",style = "font-size:16pt"),
                                p("Para hacer más fácil el proceso ponemos a tu disposición el layout que necesita la base, para que solo tengas 
                                  que rellenarlo.",style = "font-size:16pt")
                                ),
              conditionalPanel(condition ="assert:<output.contenido>",
                                 downloadButton('archivorequerimientos','Requerimientos')
              ),
              br(),
              conditionalPanel(condition ="assert:<output.contenido>",
                               downloadButton('archivolayout','Layout')
              ),
              br(),
              wellPanel(fileInput('archivoupload',h2('Sube la base'),
                                          accept=c('text/csv',
                                                   'text/comma-separated-values,text/plain',
                                                   '.csv'
                                          )
             ),
             checkboxInput('header','El archivo lleva encabezados',TRUE),
             radioButtons('sep','Separador',choices=list('Coma'=',','Punto y coma'=';','Tabulador'='\t','Pipe'='|'))
             ),
             
             conditionalPanel(condition ="assert:<output.contenido>",h2('Descarga la base con índices'),
                              downloadButton('archivodescarga','Descarga')
             )
             ),
             column(8,tableOutput('contenido'))
    ),tabPanel("Contacto",
              column(12,imageOutput('contacto'),align="center"))

))


