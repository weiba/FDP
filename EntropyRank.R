EntropyRank<-function(weightMatrix,k){#前k个邻居
  Cij<-weightMatrix
  diag(Cij)<-0
  Cij<-t(apply(Cij,2,sort,decreasing = TRUE))#排序从左到右递减，apply配合sort只能列排序，行排序会出错
  neighbors<-Cij[,1:k]
  sum_neighbors<-rowSums(neighbors)#每个节点的邻居边的权值之和

  p<-matrix(0,nrow = nrow(weightMatrix),ncol = k)#熵公式中的概率

  p<-neighbors/k
  #for(i in 1:nrow(Cij)){
  #  p[i,]<-neighbors[i,]/sum_neighbors[i]#p的每一行对应的每个邻居除以邻居的和
  #}
  
  
  #information frequency entropy
  Ifi<-matrix(0,nrow = nrow(weightMatrix),ncol = 2)
  Ifi[,1]<-rownames(weightMatrix)
  Ifi[,2]<--rowSums(p*log(p))#每行的每个邻居的p*log(p)按行加起来
  return(Ifi)
}






