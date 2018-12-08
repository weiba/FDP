library(SNFtool)
source("dataLoad.R")#AP、SP1~12、ECC
source("toMatrix.R")#MatrixSP1~12
source("matrixFuse.R")
source("resultNum.R")
source("EntropyRank.R")
source("diffusion.R")

#12子网的邻接矩阵
m1_degree<-toDegreeMatrix(SP1)
m2_degree<-toDegreeMatrix(SP2)
m3_degree<-toDegreeMatrix(SP3)
m4_degree<-toDegreeMatrix(SP4)
m5_degree<-toDegreeMatrix(SP5)
m6_degree<-toDegreeMatrix(SP6)
m7_degree<-toDegreeMatrix(SP7)
m8_degree<-toDegreeMatrix(SP8)
m9_degree<-toDegreeMatrix(SP9)
m10_degree<-toDegreeMatrix(SP10)
m11_degree<-toDegreeMatrix(SP11)
m12_degree<-toDegreeMatrix(SP12)


#12子网ECC网络,此时.Data文件中的下列数据是commonEdge/Edges方法
m1_ECC<-toECCMatrix(m1_degree)#(SP1)
m2_ECC<-toECCMatrix(m2_degree)#(SP2)
m3_ECC<-toECCMatrix(m3_degree)#(SP3)
m4_ECC<-toECCMatrix(m4_degree)#(SP4)
m5_ECC<-toECCMatrix(m5_degree)#(SP5)
m6_ECC<-toECCMatrix(m6_degree)#(SP6)
m7_ECC<-toECCMatrix(m7_degree)#(SP7)
m8_ECC<-toECCMatrix(m8_degree)#(SP8)
m9_ECC<-toECCMatrix(m9_degree)#(SP9)
m10_ECC<-toECCMatrix(m10_degree)#(SP10)
m11_ECC<-toECCMatrix(m11_degree)#(SP11)
m12_ECC<-toECCMatrix(m12_degree)#(SP12)


#weightMatrix、degreeMatrix
######融合12个ECC子网作为最终边的权值######
#此时.Data文件中的下列数据是基于toECCMatrix的(commonEdge/Edges)方法，融合方式为欧氏距离
weightMatrix<-matrixFuse(m1_ECC,m2_ECC,m3_ECC,m4_ECC,m5_ECC,m6_ECC,m7_ECC,m8_ECC,m9_ECC,m10_ECC,m11_ECC,m12_ECC,fmode = 3)


#Diffusion结果
Diffresult<-diffusion(weightMatrix,30)#finalMatrix、、degreeSNFMatrix
#####

#Entropy结果
entropyResult<-EntropyRank(weightMatrix,20)
#####

#Entropy+Diffusion结果
a<-0.8
EDresult<-matrix(NA,nrow = nrow(entropyResult),ncol = 2)
EDresult[,1]<-entropyResult[,1]
EDresult[,2]<-a*as.numeric(Diffresult[,2])+(1-a)*as.numeric(entropyResult[,2])
resultNum(EDresult,100,200,300,400)












