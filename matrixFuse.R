matrixFuse<- function(...,fmode){
  #fmode取值,
  #1:SNF多项融合
  #2:1和2再和3,4……
  #3:距离最近的两个先融合，再和剩下的与结果最近的融合
  #4:层次聚类
  
  gc()
  k=20
  sigma=0.5
  t=20
  m=list(...)
  affM<-list()

  
  for(i in 1:length(m)){
    affM[[i]]<-affinityMatrix(m[[i]],k,sigma)
  }
  
  
  EuclidDistance<-function(m1,m2){
    distance<-sum((m1-m2)^2)^(1/2)
    return(distance)
  }
  
  
  
######################  
  if(fmode==1){#直接多项融合
      result<-SNF(affM,k,t)
      dimnames(result)<-list(rownames(m[[1]]),colnames(m[[1]]))
      return(result)
  }
  
######################  
  if(fmode==2){#affM两两SNF,1和2，和3，和4……
    result<-SNF(list(affM[[1]],affM[[2]]),k,t)
    for(i in 3:length(affM)){
      result<-SNF(list(result,affM[[i]]),k,t)
    }
    dimnames(result)<-list(rownames(m[[1]]),colnames(m[[1]]))
    return(result)
  }

######################  
  if(fmode==3){#距离最近的矩阵融合后的结果，和剩下的比较距离，结果和距离最近的那一个融合
    #设置初始的两个距离最近的矩阵
    init_Matrix<-matrix(0,nrow = length(affM),ncol = length(affM),dimnames = list(1:length(affM),1:length(affM)))#存储每个矩阵循环时，与其他矩阵之间的距离
    for(i in 1:length(affM)){
      for(j in i:length(affM)){
        if(i==j){
          next
        }
        init_Matrix[i,j]<-EuclidDistance(affM[[i]],affM[[j]])
      }
    }
    #初始的两个矩阵的序列,init_Matrix是一个上三角的距离矩阵，行==列且行列名均为待融合矩阵序列的序列
    distance<-init_Matrix[1,2]
    #记录距离最小的两个矩阵的序列
    num1<-as.numeric(rownames(init_Matrix)[1])
    num2<-as.numeric(colnames(init_Matrix)[2])
    #遍历上三角，取得距离最小的两个矩阵的序列，即行列名
    for(i in 1:(nrow(init_Matrix)-1)){
      for(j in (i+1):ncol(init_Matrix)){
        if(distance>init_Matrix[i,j]){
          distance<-init_Matrix[i,j]
          num1<-i
          num2<-j
        }
      }
    }
    
    #初始最终融合的结果
    result<-SNF(list(affM[[num1]],affM[[num2]]),k,t)
    affM<-affM[-c(num1,num2)]#删除掉初始值(affM[[1]])
    while (length(affM)>0) {
      tempList<-c()
      for(i in 1:length(affM)){
        tempList<-c(tempList,EuclidDistance(result,affM[[i]]))#result和剩余所有子网之间的距离
      }
      num<-which(tempList==min(tempList),arr.ind = TRUE)#获取最小距离的子网在列表中的位置序列
      result<-SNF(list(result,affM[[num]]),k,t)#融合
      affM<-affM[-num]#删除掉融合后的矩阵(affM[[num]])
    }
    dimnames(result)<-list(rownames(m[[1]]),colnames(m[[1]]))#行列重命名
    return(result)
    
  }
  
######################  
  if(fmode==4){#层次聚类,两两融合
    while(length(affM)>1){
      distanceMatrix<-matrix(Inf,length(affM),length(affM))
      for(i in 1:length(affM)){
        for(j in i:length(affM)){
          if(i==j){
            next
          }
          distanceMatrix[i,j]<-EuclidDistance(affM[[i]],affM[[j]])
        }
      }
      num1<-which(distanceMatrix==min(distanceMatrix),arr.ind = TRUE)[1]#行对应的蛋白质
      num2<-which(distanceMatrix==min(distanceMatrix),arr.ind = TRUE)[2]#列对应的蛋白质
      result<-SNF(list(affM[[i]],affM[[j]]),k,t)#融合对应蛋白质
      affM<-affM[-c(num1,num2)]   #把对应蛋白质从列表里删除
      affM[[length(affM)+1]]<-result    #加入融合后的矩阵
    }
    
    dimnames(result)<-list(rownames(m[[1]]),colnames(m[[1]]))#行列重命名
    return(result)
  }
  
}

 








