
import time 
start_time=time.time()
import os
import numpy as np 

#size=[250,244,198,192,181,172,160,147,142,136,135,134,116,108,103,91,82,78,60,63,49,52,156,...
#250,244,198,192,181,172,160,147,142,136,135,134,116,108,103,91,82,78,60,63,49,52,156]

size=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157,249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
csize=np.cumsum(size)
natoms=csize[-1]
natoms2=natoms/2

#natoms2=5

print natoms,natoms2 
M1=np.zeros((10,natoms2,natoms2),dtype=np.float)
M3=np.zeros((natoms2,natoms2),dtype=np.float)

cutoff=[1.0,1.2,1.25,1.5,1.75,2.0,2.4,2.5,3.0,4.0]

startPos=4001
endPos=10001+1

#print len(range(startPos,endPos,10))
	
nof=0
for filen in range(startPos,endPos,50):
	nof+=1
	name='my/file'+str(filen)+'.dat'
	f=open(name)
	cont=f.readlines()
	chromosome=np.zeros((natoms+1,3),dtype=np.float)

	#print filen, "Time", len(cont)

	for i in range(5,len(cont)):  ###8  check this line 
		l=cont[i].split()
		if len(l)==6:
			chromosome[int(l[0])]=[float(l[3]),float(l[4]),float(l[5])]
			
	#count=0
	for p in range(natoms2):
		for q in range(p+1,natoms2):
			#count=count+1
			sub_vec=np.subtract(chromosome[p+1],chromosome[q+1])
			dist=np.linalg.norm(sub_vec)
			for cut in range(len(cutoff)):
				if dist<=cutoff[cut]: 
					M1[cut][p][q]+=1
			M3[p][q]+=dist
			
					
	#print "count",count 	
		
		#if (p%10)==0:
		#	print p 
	
			

answer=os.path.isdir('SimulationContactMaps')
if answer==True:
	pass
else:
	os.mkdir('SimulationContactMaps')
print "no of frame ", nof	

f=[]
for cut in range(len(cutoff)):
	answer=os.path.isdir('SimulationContactMaps/'+str(cutoff[cut]))
	if answer==True:
		pass
	else:
		os.mkdir('SimulationContactMaps/'+str(cutoff[cut]))
	f1=open('SimulationContactMaps/'+str(cutoff[cut])+'/CMap.dat','w')
	f.append(f1)
for cut in range(len(cutoff)):
	for j in range(natoms2):
		for i in range(natoms2):
			M1[cut][i][j]=M1[cut][j][i]
			f[cut].write(str('%0.2f' %(M1[cut][j][i]/float(nof))  )+' ')
		f[cut].write('\n')
		

ff=open('SimulationContactMaps/HeatMap.dat','w')
for j in range(natoms2):
	for i in range(natoms2):
		M3[i][j]=M3[j][i]
		ff.write(str('%0.2f' %(M3[j][i]/float(nof)))+' ')
	ff.write('\n')

print ("---%s seconds ---"%(time.time()-start_time))
