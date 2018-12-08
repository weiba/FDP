diffusion<-function(m,t){
  diag(m)<-0    #去除自己-自己的权值
  DC<-colSums(m)
  a<-0.5#自身-扩散加权常数
  
  diffusionList<-matrix(0,nrow(m),2)
  diffusionList[,1]<-rownames(m)
  
  #初始化initMatrix能量
  for(i in 1:nrow(diffusionList)){
    diffusionList[i,2]<-AP$V4[which(AP$V2==diffusionList[i,1])]/99
  }
  initEnergy<-diffusionList#存储初始能量
  
  while(t){
    last_diffusionList<-diffusionList#这里用来储存每次扩散后的结果，不然如果for循环中直接递归diffusionList,每次循环都会改变一个表内的元素
    for(j in 1:nrow(diffusionList)){
      diffusionList[j,2]<-a*as.numeric(initEnergy[j,2])+(1-a)*sum(as.numeric(last_diffusionList[,2])*(m[j,]/DC[j]))
    }
    #diffusionList[,2]<-scale(as.numeric(diffusionList[,2]))
    t=t-1
    
  }
  
  
  #归一化
  max_diff<-max(as.numeric(diffusionList[,2]))
  min_diff<-min(as.numeric(diffusionList[,2]))
  diffusionList[,2]<-(as.numeric(diffusionList[,2])-min_diff)/(max_diff-min_diff)
  
  
  return(diffusionList)
  
}


