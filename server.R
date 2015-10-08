 # server.R
library(shiny)

shinyServer(function(input, output,session){
  
  observe({
    if(input$filtrovar!="Total"){
      datos1<-df %>%
        dplyr::select(one_of(input$filtrovar))
      
      r_options<-eval(parse(text=paste('list(',paste('"',levels(datos1[,1]),'"="',levels(datos1[,1]),'"',
                                                     collapse=',',sep=''),')')))
    }else{
      r_options<-"Total"
    }
    updateRadioButtons(session,'filtrocat',choices=r_options)
  })

  
  output$plot1 <- renderPlot({
    
    
      corrplot(correlaciones2, method = "circle",mar=c(0,0,0,0),tl.cex = 1.6,cl.cex=1.6,tl.col="black")
      
    
    
    
  }, height = 900, width = 1000)
  
 
  output$imagen1<-renderImage({
    list(src='images/empleados.jpg',
    filetype='image/jpeg',
    alt='wiiiii')
  }, 
  deleteFile = F)
  
  output$factores<-renderImage({
    list(src='images/Factores.png',
         filetype='image/png',
         alt='wiiiii',
         width = 1200,
         height = 1300)
  }, 
  deleteFile = F)
  
  output$qgraph<-renderPlot({
    
      qgraph(correlaciones,minimum=.1,cut=.9,borders=TRUE,layout='spring',vsize=4,overlay=T,
             vTrans=100,groups=grupos,node.width=2,
             labels=names(df)[4:29],normalize=T,label.scale=F,label.cex=1.2,legend.cex=1.2)

  },height=1000,width=1100)
  
  
#   output$factores<-renderPlot({
#     if(input$gcor==1){
#     fa.diagram(factores5,cut=.1,mai='Dimensiones de la batería')
#     }
#     if(input$gcor==2){
#       qgraph(correlaciones,minimum=.1,cut=.9,borders=TRUE,layout='spring',vsize=4,overlay=T,
#              vTrans=100,groups=grupos,node.width=2,
#              labels=names(df)[4:29],normalize=T,label.scale=F,label.cex=1.2,legend.cex=1.2)
#       
#       
#     }
#   },height=1000,width=1100)
#   
#     
  output$importancia<-renderPlot({
    
    graf_importancia_dimensiones(importancia)    
    
  },height=900,width=1000)
  
  
  output$discriminacion<-renderPlot({
    plot(modelo,type='infotrace',main='Trazas de información de los items')
  },height=1200,width=1200)
  
  
  output$red<-renderImage({
    list(src='images/red.png',
         filetype='image/png',
         alt='wiiiii',
         width = 1000,
         height = 1000)
  }, 
  deleteFile = F)
  
  output$descriptivo<-renderPlot({
    graf(df,input$variable,input$facet,input$filtrovar,input$filtrocat)
  })
  
  output$graf_pesos<-renderPlot({
    graf_pesos(pesos)
  },height=1100,width=1300)
  
  ### Data import:
  Dataset <- reactive({
    archivodisplay<-input$archivoupload
    if (is.null(archivodisplay)) {
      # User has not uploaded a file yet
      return(data.frame())
    }
    
    Dataset <- read.csv(archivodisplay$datapath,header=input$header,sep=input$sep)
    
    return(Dataset)
  })
  
  output$contenido<-renderTable({
    archivodisplay<-input$archivoupload
    
    if(is.null(archivodisplay)) return(NULL)
    
    return(Dataset())
  })
  
  output$cosa <- renderTable({
    #Checamos que haya variables para elegir 
    if (is.null(input$file)) return(NULL)
    tabla<-indice(Dataset(),df,
               modelo,
               modelo_ambiente,
               modelo_convivencia,
               modelo_jefe,
               modelo_reconocimiento,
               modelo_seguridad)
    return(tabla)
  })
  
  output$archivodescarga <- downloadHandler(
    filename = "datos.csv",
    content = function(file){
      tabla2<-indice(Dataset(),df,
                     modelo,
                     modelo_ambiente,
                     modelo_convivencia,
                     modelo_jefe,
                     modelo_reconocimiento,
                     modelo_seguridad)
      write.csv(tabla2,file,row.names=F)
    }
  )
  
  output$archivolayout <- downloadHandler(
    filename = "Layout.csv",
    content = function(file){
      layout <- data.frame(matrix(ncol=length(df)))
      names(layout)<-names(df)
      write.csv(layout,file,row.names=F)
    }
  )
  
  output$archivorequerimientos <- downloadHandler(
    filename = "Requerimientos.txt",
    content = function(file){
      requerimiento<-requerimientos()
    }
  )
  
  output$contacto<-renderImage({
    list(src='images/contacto.png',
         filetype='image/png',
         alt='wiiii',
         width = 1200,
         height = 900)
  }, 
  deleteFile = F)
  
})