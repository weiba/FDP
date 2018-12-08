#####检验正确个数,M[,c("name","value")],N为验证前n个数
resultNum<-function(Matr,...){
  #先排序
  M<-Matr[,1:2]
  sortByValue<-order(-as.numeric(M[,2]),M[,1])#先数值从大到小排序，再字母从小到大排序
  M<-Matr[sortByValue,1:2]
  
  #开始验证
  
  times<-c(...)
  nlist<-list()
  k<-1
  for (i in times) {
    n<-0
    for(j in 1:i){
      if(AP[which(as.character(AP[,2])==M[j,1]),3]==1){
        n<-n+1
      }
    }
    nlist[[k]]<-c(n,paste((n/i)*100,"%",sep = ""))            #num: n; ratio: paste((n/j)*100,"%",sep = "")
    k<-k+1
  }
  print(nlist)
}
