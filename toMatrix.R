  s<-unique(rbind(SP1,SP2,SP3,SP4,SP5,SP6,SP7,SP8,SP9,SP10,SP11,SP12))
  allElements<-unique(c(as.character(s[,1]),as.character(s[,2])))#所有子网中所含蛋白质的名称
  newName<-list(allElements,allElements)

  #############0-1权值############
  toDegreeMatrix<-function(sp)
  {
    dMatrix<-matrix(data = 0,nrow = length(allElements),ncol = length(allElements),dimnames = newName)
    for(i in 1:length(sp$V1)){#1:nrow(dMatrix 或 wMatrix)也行
      if(as.character(sp$V1[i]) %in% allElements & as.character(sp$V2[i]) %in% allElements)
      {
        dMatrix[as.character(sp$V1[i]),as.character(sp$V2[i])]<-1
        dMatrix[as.character(sp$V2[i]),as.character(sp$V1[i])]<-1
      }
    }
    if(length(which(dMatrix>1))>0)
    {
      stop("输入文件有重复边")
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

  



  

  
  
  
  
  
  
  
  
  

