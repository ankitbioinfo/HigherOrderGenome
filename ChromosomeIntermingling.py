#from matplotlib import *
#from pylab import *
import numpy as np 

'''
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

'''


asize=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157,249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
csize=np.cumsum(asize)
natoms=csize[-1]+1
noc=46  ### number of chromosome 


tsize=[0]+list(csize)




f=open('GM1.dat')

temp=[]
for line in f:
	l=line.split()
	temp.append(int(l[1]))

active_inactive=temp+temp 




'''
CMatrix=[]
for i in range(noc):
	array=[]
	for i in range(noc):
		array.append(0)
	CMatrix.append(array)
'''

startPos=5001
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

for filen in range(startPos,endPos,50):
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
			

	M=np.zeros((noc,noc,3),dtype=np.float)
	for p in range(noc):
		for q in range(p+1,noc):
			#count=np.zeros((asize[p]),dtype=np.float)
			for i in range(asize[p]):
				for j in range(asize[q]):
					#print p,i,j
					sub_vec=np.subtract(chromosome[p][i],chromosome[q][j])
					dist=np.linalg.norm(sub_vec)
					#print p+1,q+1, i+tsize[p]+1, j+tsize[q]+1
					
												
					if dist<=2.5:
						if (active_inactive[i+tsize[p]]!=1)&(active_inactive[j+tsize[q]]!=1):  # AA 
							M[p][q][0]+=1
			
						if (active_inactive[i+tsize[p]]==1)&(active_inactive[j+tsize[q]]==1):  # BB 
							M[p][q][1]+=1

						if (active_inactive[i+tsize[p]]!=1)&(active_inactive[j+tsize[q]]==1):  # AB 
							M[p][q][2]+=1

						if (active_inactive[i+tsize[p]]==1)&(active_inactive[j+tsize[q]]!=1):  # BA 
							M[p][q][2]+=1
					

					
			


				
	
f1=open('InterminglingAA.dat','w')
f2=open('InterminglingBB.dat','w')
f3=open('InterminglingAB.dat','w')

print "no of frame ", nof


for p in range(noc):
	for q in range(noc):
		f1.write(str(M[p][q][0]/nof)+'\t')
		f2.write(str(M[p][q][1]/nof)+'\t')
		f3.write(str(M[p][q][2]/nof)+'\t')
	f1.write('\n')
	f2.write('\n')
	f3.write('\n')	




