#Helpers-------

filtro<-function(df,variable,facet){
  if(facet=="Total"){
    df2 <- df %>%
      select(one_of(variable)) 
    names(df2)<-c("var_x")
    df2 <- df2 %>%
      group_by(var_x) %>%
      summarise(n=n()) %>%
      mutate(valor=(n/sum(n))*100) %>%
      filter(complete.cases(var_x)) %>%
      select(1,3)
  }else{
    df2 <- df %>%
      select(one_of(facet,variable)) 
    names(df2)<-c("var_y","var_x")
    df2 <- df2 %>%
      group_by(var_y,var_x) %>%
      summarise(n=n()) %>%
      mutate(valor=(n/sum(n))*100) %>%
      filter(complete.cases(var_y)) %>%
      select(1,2,4)
  }
  return(df2)
}

filtro2<-function(df,filtrovar,filtrocat){
  if(filtrovar!="Total"){
    nrenglon <- df %>%
      mutate(index=row.names(.)) %>%
      select(one_of(filtrovar,"index"))
    names(nrenglon)<-c("x","index")
    nrenglon<- nrenglon %>%
      filter(x==filtrocat) %>%
      select(2)
    df<-df[nrenglon$index,]
  }
  return(df)
}

texto<-function(df,variable,facet){
  df2 <- df %>%
    select(one_of(facet,variable))
  names(df2)<-c("x","y")
  df3<- df2 %>%
    group_by(x) %>%
    summarise(media=mean(y))
  return(df3)
}

graf<-function(df,variable,facet,filtrovar,filtrocat){
  df<-filtro2(df,filtrovar,filtrocat)
  
  if(facet == "Total"){
    if(grepl("score",variable)){
      df2 <- df %>%
        select(one_of(variable))
      names(df2)<-c("x")
      lab<-paste("Media: ",round(mean(df2$x,na.rm=T),digits=0),sep="")
      ggplot(df2,aes(x)) + 
        geom_boxplot(aes(y=x),fill="#2c3e50",colour="black") + 
        annotate("text",label=lab,y=99,x=20,colour='black',size=10) +
        theme(panel.background=element_rect(fill='#C2D1E0'),
              strip.background=element_rect(fill="#2c3e50"),
              panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
              axis.text.x=element_blank(),
              axis.text.y=element_text(size=22)) +
        coord_cartesian(ylim=c(-2,105)) +
        ylab("") + xlab("")
    }else{
      df2<-filtro(df,variable,facet)
      ggplot(df2,aes(x=var_x,y=valor)) + 
        geom_bar(stat="identity",fill="#2c3e50",colour="black") + 
        geom_text(aes(y=valor + 3,label=paste0(round(valor),'%')),
                  colour='black',size=6) +
        theme(axis.text.x=element_text(angle=90,size=22),
              axis.text.y=element_text(size=22),
              panel.background=element_rect(fill='#C2D1E0'),
              panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
              strip.background=element_rect(fill="#2c3e50")) +
        ylab("") + xlab("")
    }
  }else{
    if(grepl("score",variable)){
      df2 <- df %>%
        select(one_of(variable,facet))
      names(df2)<-c("x","y")
      df2<-df2[complete.cases(df2$y),]
      df3 <- texto(df,variable,facet)
      df3<-df3[complete.cases(df3$x),]
      ggplot() + 
        geom_boxplot(data=df2,aes(y,x),fill="#2c3e50",colour="black") +
        geom_text(data=df3,aes(label=round(media,digits=0),group=x,x=x),y=102,size=10) +
        theme(panel.background=element_rect(fill='#C2D1E0'),
              strip.background=element_rect(fill="#2c3e50"),
              strip.text.x = element_text(colour = 'white', size = 22),
              panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
              axis.text.x=element_text(angle=90,size=22),
              axis.text.y=element_text(size=22)) +
        coord_cartesian(ylim=c(-2,105)) +
        ylab("") + xlab("")
    }else{
      df2<-filtro(df,variable,facet)
      ggplot(df2,aes(x=var_x,y=valor)) + 
        geom_bar(stat="identity",fill="#2c3e50",colour="black") + 
        geom_text(aes(y=valor + 3,label=paste0(round(valor),"%")),
                  colour='black',size=6) +
        facet_wrap(~var_y) +
        theme(axis.text.x=element_text(angle=90,size=22),
              axis.text.y=element_text(size=22),
              panel.background=element_rect(fill='#C2D1E0'),
              strip.background=element_rect(fill="#2c3e50"),
              panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
              strip.text.x = element_text(colour = 'white', size = 22)) +
        ylab("") + xlab("")
    }
  }
}
  
graf_pesos<-function(pesos){
  ggplot(pesos,aes(x=preguntas,y=peso)) + 
    geom_point(aes(colour=dimension,group=dimension),size=12,alpha=.5) +
    geom_text(aes(y=peso,label=round(peso,digits=2)),
              colour='black',size=6) +
    theme(panel.background=element_rect(fill='#C2D1E0'),
          strip.background=element_rect(fill="#2c3e50"),
          panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
          axis.text.y=element_text(size=16,face="bold"),
          axis.text.x=element_text(size=16,face="bold"),
          legend.title=element_blank(),
          legend.position="bottom",
          legend.text=element_text(size=17)) +
    coord_flip() +
    xlab("") +
    ylab("")
}

graf_importancia_dimensiones<-function(importancia){
  ggplot(importancia,aes(x=Score,y=Porc_IncMSE)) + 
    geom_point(size=11,colour='#2c3e50') +
    geom_point(size=8,colour='#C2D1E0') +
    theme(panel.background=element_rect(fill='#C2D1E0'),
          strip.background=element_rect(fill="#2c3e50"),
          panel.border = element_rect(colour = "#2c3e50", fill=NA, size=1),
          axis.text.y=element_text(size=22,face="bold"),
          axis.title=element_text(size=18.5,colour="red"),
          legend.title=element_blank()) +
    scale_y_continuous(breaks=NULL) +
    coord_flip() +
    xlab("") +
    ylab("<---   Menor Importancia                                                                             Mayor Importancia   --->")
}

indice<-function(base,df,modelo,
                 modelo_ambiente,
                 modelo_convivencia,
                 modelo_jefe,
                 modelo_reconocimiento,
                 modelo_seguridad){
  
  df2<- base %>%
    mutate(index=row.names(.)) %>%
    arrange(desc(FIEMPLEADO_ID),index) %>%
    filter(!duplicated(FIEMPLEADO_ID)) %>%
    select(one_of(names(base)[names(base) %in% names(df)[4:29]]))
  
  df3<- base %>%
    mutate(index=row.names(.)) %>%
    arrange(desc(FIEMPLEADO_ID),index) %>%
    filter(!duplicated(FIEMPLEADO_ID)) %>%
    select(one_of(names(base)[!(names(base) %in% names(df)[4:29])]))
  
  temp<-df2
  for(j in 1:26){
    temp[,j]<-as.numeric(temp[,j])
  }
  df2<-temp
  
  #Obtenemos el score general
  scores<-as.data.frame(fscores(modelo,
                                full.scores=T,
                                method='EAP',
                                response.pattern = df2))
  df2$score<-as.numeric(scores$F1)
  
  #Obtenemos el índice de ambiente
  ambiente<-df2[,grupos$ambiente]
  scores_ambiente<-as.data.frame(fscores(modelo_ambiente,
                                         full.scores=T,
                                         method='EAP',
                                         response.pattern = ambiente))
  df2$score_ambiente<-as.numeric(scores_ambiente$F1)
  
  #Obtenemos el índice de convivencia
  convivencia<-df2[,grupos$convivencia]
  scores_convivencia<-as.data.frame(fscores(modelo_convivencia,
                                            full.scores=T,
                                            method='EAP',
                                            response.pattern = convivencia))
  df2$score_convivencia<-as.numeric(scores_convivencia$F1)
  
  #Obtenemos el score de jefe
  jefe<-df2[,grupos$jefe]
  scores_jefe<-as.data.frame(fscores(modelo_jefe,
                                     full.scores=T,
                                     method='EAP',
                                     response.pattern = jefe))
  df2$score_jefe<-as.numeric(scores_jefe$F1)
  
  #Obtenemos el score de seguridad
  seguridad<-df2[,grupos$seguridad]
  scores_seguridad<-as.data.frame(fscores(modelo_seguridad,
                                          full.scores=T,
                                          method='EAP',
                                          response.pattern = seguridad))
  df2$score_seguridad<-as.numeric(scores_seguridad$F1)
  
  #Obtenemos el score de reconocimiento
  reconocimiento<-df2[,grupos$reconocimiento]
  scores_reconocimiento<-as.data.frame(fscores(modelo_reconocimiento,
                                               full.scores=T,
                                               method='EAP',
                                               response.pattern = reconocimiento))
  df2$score_reconocimiento<-as.numeric(scores_reconocimiento$F1)
  
  df4 <- cbind(df3,df2)
  
  return(df4)
}


