Operating system:windows 10
CPU:Intel(R) Core(TM) i3-4170CPU@3.70GHz
RAM:8.0GB
Type system:64 bits
software environment:R x64 3.4.2
IDE:RStudio
1.Firstly，please check out that if the R package "SNFtool" is installed before running the code。If not，please install it by this statement：install.packages("SNFtool")，or download this package from "https://cran.r-project.org/web/packages/SNFtool/index.html"
2.The input file should include twelve dynamic networks and store in separate ".txt" formated files.There are two groups of network data in the corresponding folder："DIP2010"and"subnet_SC_net".please copy these datas under the root directory where "main.R" is located .
3.Each network file in these two folder contains two columns of protein names,and each line represents two proteins and one side of the dynamic network.The twelve network files in folder "DIP2010" contain 2759 proteins,including 827 essential proteins.The twelve network files in folder "subnet_SC_net" contain 2559 proteins,including 785 essential proteins.
4.Finally，run all the code in "main.R".
5.The output in the console is a list of correct number and correct rate of Top 400 proteins.