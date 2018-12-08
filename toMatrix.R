  s<-unique(rbind(SP1,SP2,SP3,SP4,SP5,SP6,SP7,SP8,SP9,SP10,SP11,SP12))
  allElements<-unique(c(as.character(s[,1]),as.character(s[,2])))#所有子网中所含蛋白质的名称
  newName<-list(allElements,allElements)

  #############0-1权值############
toDegreeMatrix<-function(sp){
  gc()
  
  dMatrix<-matrix(data = 0,nrow = length(allElements),ncol = length(allElements),dimnames = newName)

  for(i in 1:length(allElements)){#1:nrow(dMatrix 或 wMatrix)也行
    for(j in i:length(allElements)){#i:nrow(dMatrix 或 wMatrix)也行
    
      if(colnames(dMatrix)[j] %in% sp[which(rownames(dMatrix)[i]==sp[,1],arr.ind = TRUE),2]){
        dMatrix[i,j]<-1
        dMatrix[j,i]<-1
        next
      }
      if(colnames(dMatrix)[j] %in% sp[which(rownames(dMatrix)[i]==sp[,2],arr.ind = TRUE),1]){
        dMatrix[i,j]<-1
        dMatrix[j,i]<-1
        next
      }
    }
  }
  return(dMatrix)
}



  ############ECC权值############
toECCMatrix<-function(m_degree){#直接赋值初始ECC时参数为sp
  gc()
  
  wMatrix<-matrix(data = 0,nrow = length(allElements),ncol = length(allElements),dimnames = newName)
  
  ##########针对每个子网求ECC矩阵
  for(i in 1:length(allElements)){
    for(j in i:length(allElements)){
      if(m_degree[i,j]==1){#判断两蛋白质是否有边相连
        commonEdge<-length(which(m_degree[,i]==1 & m_degree[,j]==1))#公共节点形成三角
        Edges<-min(sum(m_degree[i,])-1,sum(m_degree[,j])-1)#两节点度，取其最小值
        if(commonEdge==0){
          next
        }
        wMatrix[i,j]<-commonEdge/Edges
      }
    }
  }
  return(wMatrix)
  
}

  



  

  
  
  
  
  
  
  
  
  

