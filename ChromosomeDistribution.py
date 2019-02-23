#from matplotlib import *
#from pylab import *
import numpy 

interval=numpy.linspace(0,22,100)

chr_array=[]
for i in range(47):
	array=[]
	for i in range(len(interval)):
		array.append(0)
	chr_array.append(array)


def Expectation(x,p):
	tot=0.0    ## p is the y 
	for i in range(len(x)):
		tot+=x[i]*p[i]
	return tot/sum(p)

startPos=2501
endPos=10001+1
noOfFrame=0

a=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
size=a+a
csize=numpy.cumsum(size)
atoms=sum(size)
print "number of atoms",atoms
	
chromosome=numpy.zeros((atoms+1,3),dtype=numpy.float)

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

	start=1 
	for i in range(1,47):
		for j in range(start,1+csize[i-1]):
			dist=numpy.linalg.norm(chromosome[j])
			for k in range(1,len(interval)):
				if(dist>=interval[k-1])&(dist<interval[k]):
					chr_array[i][k-1]+=1
		start=1+csize[i-1]
		



for j in range(1,47):
	for i in range(len(interval)):
		chr_array[j][i]=chr_array[j][i]/float(noOfFrame)


radius=20.16
binsize=interval[1]-interval[0]
for j in range(1,47):
	sum1=0.0
	for i in range(len(interval)):
		sum1=sum1+(binsize*chr_array[j][i])
	for i in range(len(interval)):
		chr_array[j][i]=radius*chr_array[j][i]/sum1
		
xvec=[]
for i in range(len(interval)):
	xvec.append(interval[i]/radius)

print "Number of frame", noOfFrame

ff=open('chromosome_errorbar.dat','w')

xvec_square=[]
for i in xvec:
	xvec_square.append(i**2)

for j in range(1,47):
	y=Expectation(xvec,chr_array[j])
	variance=Expectation(xvec_square,chr_array[j]) - (y**2)
	z=numpy.sqrt(variance)
	if j>23:
		x=j-23
	else:
		x=j
	ff.write(str(x)+'\t'+str(y)+'\t'+str(z)+'\n')
	
ff.close()
ff=open('chromosome_distribution.dat','w')


for j in range(len(interval)):
	ff.write(str(j+1)+'\t'+str(xvec[j])+'\t')
	for i in range(1,47):
		ff.write(str(chr_array[i][j])+'\t')
	ff.write('\n')
ff.close()




