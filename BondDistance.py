

import numpy 

a=open('tmp.data.chain_InactiveX_Actual_loop')
cont=a.readlines()
normalbond=[]
secondbond=[]
flag=0
for i in range(len(cont)):
	l=cont[i].split()
	if cont[i].find('Bonds')!=-1:
		flag=1 

	if (flag==1)&(len(l)==4):
		if int(l[1])==1:
			normalbond.append([int(l[2]),int(l[3])])
		if int(l[1])==2:
			secondbond.append([int(l[2]),int(l[3])])


lpb=len(normalbond)
lsb=len(secondbond)
print lpb,lsb 

startPos=6001
endPos=10001+1
noOfFrame=0

a=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
size=a+a
csize=numpy.cumsum(size)
atoms=sum(size)
print "number of atoms",atoms

pbond=numpy.zeros(lpb,dtype=numpy.float)
sbond=numpy.zeros(lsb,dtype=numpy.float)


chromosome=numpy.zeros((atoms+1,3),dtype=numpy.float)

fpb=open('primarybond.dat','w')
fsb=open('secondarybond.dat','w')

for filen in range(startPos,endPos,50):
	noOfFrame+=1
	name='my/file'+str(filen)+'.dat'
	f=open(name)
	cont=f.readlines()
	
	print filen, "Time", cont[1][0:-1]

	for i in range(5,len(cont)):  ###8  check this line 
		l=cont[i].split()
		if len(l)==6:
			chromosome[int(l[0])]=[float(l[3]),float(l[4]),float(l[5])]


	for i in range(lpb):
		#pbond[i]+=numpy.linalg.norm(chromosome[normalbond[i][0]]-chromosome[normalbond[i][1]])
		fpb.write(str(numpy.linalg.norm(chromosome[normalbond[i][0]]-chromosome[normalbond[i][1]]))+'\n')

	for i in range(lsb):
		#sbond[i]+=numpy.linalg.norm(chromosome[secondbond[i][0]]-chromosome[secondbond[i][1]])
		fsb.write(str(numpy.linalg.norm(chromosome[secondbond[i][0]]-chromosome[secondbond[i][1]]))+'\n')



'''
for i in range(lpb):
	fpb.write(str(pbond[i]/noOfFrame)+'\n')

for i in range(lsb):
	fsb.write(str(sbond[i]/noOfFrame)+'\n')
'''


