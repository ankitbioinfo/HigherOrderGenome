#from matplotlib import *
#from pylab import *
import numpy as np 

import os 
answer = os.path.isdir('ContactPb1')

if answer==True:
	pass
else:
	os.mkdir('ContactPb1')


answer=os.path.isdir('SpatialDistance')
if answer==True:
	pass
else:
	os.mkdir('SpatialDistance')
			
fw=[]
for i in range(46):
	fw.append(open('SpatialDistance/Spatial_Chr_'+str(i+1)+'.dat','w'))




asize=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157,249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
csize=np.cumsum(asize)
natoms=csize[-1]+1
noc=46  ### number of chromosome 

print csize 

'''
CMatrix=[]
for i in range(noc):
	array=[]
	for i in range(noc):
		array.append(0)
	CMatrix.append(array)
'''

startPos=4001
endPos=10001+1

M1=np.zeros((46,250),dtype=np.float)
M2=np.zeros((46,250),dtype=np.float)
M3=np.zeros((46,250),dtype=np.float)
M4=np.zeros((46,250),dtype=np.float)
M5=np.zeros((46,250),dtype=np.float)
M6=np.zeros((46,250),dtype=np.float)
M7=np.zeros((46,250),dtype=np.float)
M8=np.zeros((46,250),dtype=np.float)

value=np.zeros((46),dtype=np.object)
chromosome=np.zeros((46),dtype=np.object)
for i in range(46):
	value[i]=np.zeros((asize[i]-1),dtype=np.float)
	chromosome[i]=np.zeros((asize[i],3),dtype=np.float)


nof=0.0	

for filen in range(startPos,endPos,20):
	nof+=1
	name='my/file'+str(filen)+'.dat'
	f=open(name)
	cont=f.readlines()	

	print filen, "Time", len(cont)
	
	for i in range(5,len(cont)):  ###8  check this line 
		l=cont[i].split()		
		if len(l)==6:			
			for chro in range(47):
				if int(l[1])==chro:
					if chro==1:
						start=0
					else:
						start=csize[chro-2]
					#print "ankit",chro,l[0],start,int(l[0])-start-1
					chromosome[chro-1][int(l[0])-start-1,:]=[float(l[3]),float(l[4]),float(l[5])]
			

	for p in range(noc):
		count=np.zeros((asize[p]),dtype=np.float)
		M=np.zeros((asize[p]),dtype=np.float)
		for i in range(asize[p]-1):
			for j in range(i+1,asize[p]):
					#print p,i,j
					sub_vec=np.subtract(chromosome[p][i],chromosome[p][j])
					dist=np.linalg.norm(sub_vec)
					
					if dist<=1.0:
						M1[p][j-i]+=1
					if dist<=1.25:
						M2[p][j-i]+=1					
					if dist<=1.5:
						M3[p][j-i]+=1
					if dist<=1.75:
						M4[p][j-i]+=1
					if dist<=2.0:
						M5[p][j-i]+=1					
					if dist<=2.5:
						M6[p][j-i]+=1
					if dist<=3.0:
						M7[p][j-i]+=1
					if dist<=4.0:
						M8[p][j-i]+=1

					M[j-i]+=dist
					count[j-i]+=1.0
		value[p]+=M[1:]/count[1:]
			
		
	

				
	


print "no of frame ", nof


for p in range(noc):
	ff=open('ContactPb1/contact'+str(p+1)+'.dat','w')
	for i in range(1,asize[p]):
		ff.write(str(i)+'\t'+str(M1[p][i]/nof)+'\t'+str(M2[p][i]/nof)+'\t'+str(M3[p][i]/nof)+'\t'+str(M4[p][i]/nof)+'\t'+str(M5[p][i]/nof)+'\t'+str(M6[p][i]/nof)+'\t'+str(M7[p][i]/nof)+'\t'+str(M8[p][i]/nof)+'\n')
	

for k in range(noc):
	for p in range(asize[k]-1):
		fw[k].write(str(p+1)+'\t'+str(value[k][p]/nof)+'\n') 




