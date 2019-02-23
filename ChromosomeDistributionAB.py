#from matplotlib import *
#from pylab import *
import numpy 

radius=17.2
interval=numpy.linspace(0,radius+2,100)
chr_arrayAA=numpy.zeros((46,len(interval)),dtype=numpy.float)
chr_arrayBB=numpy.zeros((46,len(interval)),dtype=numpy.float)

f=open('./../GM1.dat')
Atype=[]
Btype=[]
for line in f:
	l=line.split()
	if int(l[1])>=6:
		Atype.append(int(l[0]))
		Atype.append(int(l[0])+3043)
	if int(l[1])==1:
		Btype.append(int(l[0]))
		Btype.append(int(l[0])+3043)



startPos=4001
endPos=10001+1
noOfFrame=0

a=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
size=a+a
csize=numpy.cumsum(size)
atoms=sum(size)
print "number of atoms",atoms
	
chromosome=numpy.zeros((atoms+1,3),dtype=numpy.float)
ABtype=numpy.zeros((atoms+1,1),dtype=numpy.int)

for filen in range(startPos,endPos,1):
	noOfFrame+=1
	name='my/file'+str(filen)+'.dat'
	f=open(name)
	cont=f.readlines()
	
	print filen, "Time", cont[1][0:-1]

	for i in range(5,len(cont)):  ###8  check this line 
		l=cont[i].split()
		if len(l)==6:
			chromosome[int(l[0])]=[float(l[3]),float(l[4]),float(l[5])]
			if int(l[0]) in Atype:
				ABtype[int(l[0])]=1

	start=1 
	for i in range(1,47):
		for j in range(start,1+csize[i-1]):
			dist=numpy.linalg.norm(chromosome[j])
			for k in range(1,len(interval)):
				if(dist>=interval[k-1])&(dist<interval[k]):
					if ABtype[j]==1:
						chr_arrayAA[i-1][k-1]+=1
					else:
						chr_arrayBB[i-1][k-1]+=1

		start=1+csize[i-1]
	


binsize=interval[1]-interval[0]	
xvec=[]
for i in range(len(interval)):
	xvec.append(interval[i]/radius)

print "Number of frame", noOfFrame

for j in range(46):
	for i in range(len(interval)):
		chr_arrayAA[j][i]=chr_arrayAA[j][i]/float(noOfFrame)
		chr_arrayBB[j][i]=chr_arrayBB[j][i]/float(noOfFrame)


		


for j in range(46):
	sumAA=0.0
	sumBB=0.0
	for i in range(len(interval)):
		sumAA+=(binsize*chr_arrayAA[j][i])
		sumBB+=(binsize*chr_arrayBB[j][i])

	for i in range(len(interval)):
		chr_arrayAA[j][i]=radius*chr_arrayAA[j][i]/sumAA
		chr_arrayBB[j][i]=radius*chr_arrayBB[j][i]/sumBB
		





fAA=open('chromosome_distributionAA.dat','w')
for j in range(len(interval)):
	fAA.write(str(j+1)+'\t'+str(xvec[j])+'\t')
	for i in range(46):
		fAA.write(str(chr_arrayAA[i][j])+'\t')
	fAA.write('\n')

fBB=open('chromosome_distributionBB.dat','w')
for j in range(len(interval)):
	fBB.write(str(j+1)+'\t'+str(xvec[j])+'\t')
	for i in range(46):
		fBB.write(str(chr_arrayBB[i][j])+'\t')
	fBB.write('\n')



