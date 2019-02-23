


import numpy as np 

M=np.zeros((3043,3043),dtype=np.float)


nof=0
for i in range(1,26):
	print i
	nof+=1
	#f=open('SimulationContactMaps'+str(i)+'/HeatMap.dat')
	f=open('Conf'+str(i)+'/SimulationContactMaps/1.25/CMap.dat')
	k=0
	for line in f:
		l=line.split()
		for j in range(len(l)):
			M[k][j]+=float(l[j])
		k=k+1
	print i,k
print nof 

ff=open('AvgContactMap_1_25.dat','w')
#ff=open('AvgHeatMap.dat','w')
for j in range(3043):
	for i in range(3043):
		ff.write(str('%0.2f' %(M[j][i]/float(nof)))+' ')
	ff.write('\n')

