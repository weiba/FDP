Description:FDP is a essential proteins evaluation algorithm by combining dynamic networks and random walk algorithm.

Author:Fengyu Zhang , Wei Peng , Yunfei Yang , Wei Dai and Junrong Song

Recommend operating environment
Operating system:windows 7/8/10 ,recommended to use Win10 version
CPU:Intel(R) Core(TM) i3-4170CPU@3.70GHz
RAM:8.0GB
Type system:64 bits
software environment:R x64 3.4.2
IDE:RStudio

1.Please check out that if the R package "SNFtool" is installed before running the code. If not，please install it by this statement:install.packages("SNFtool")，or download this package from "https://cran.r-project.org/web/packages/SNFtool/index.html"

2.The input file should include twelve dynamic networks store in separate ".txt" formated files,and a file named "protein_allorthology.txt" with 4 columns include sequence, names, essential proteins and orthology information. There are two groups of network data in the corresponding folder:"DIP2010"and"subnet_SC_net".please copy these datas under the root directory where "main.R" is located. "protein_allorthology.txt" is already under the root directory.
".txt" files EXAMPLE:
YHR012W	YJL053W
YBL017C	YOR181W
YHR158C	YKR054C
"protein_allorthology.txt" file EXAMPLE:
10	YAL002W	0	67
11	YAL003W	1	91
12	YAL004W	0	0

3.Each network file in these two folder contains two columns of protein names, and each line represents two proteins and one side of the dynamic network. The twelve network files in folder "DIP2010" contain 2759 proteins,including 827 essential proteins. The twelve network files in folder "subnet_SC_net" contain 2559 proteins,including 785 essential proteins.

4.Create a new project in RStudio, open the file "main.R" and run all the code.

5.The output in the console is a list of correct number and correct rate of Top 400 proteins.

The experimental data and the source code：https://github.com/weiba/FDP. 
