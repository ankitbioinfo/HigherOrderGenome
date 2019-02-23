
#from pylab import *
import numpy 
f=open('output.com')
cont=f.readlines()


def Expectation(x,p):
	tot=0.0    ## p is the y 
	for i in range(len(x)):
		tot+=x[i]*p[i]
	return tot/sum(p)

interval=numpy.linspace(0,22,200)
chr_array=[]
for i in range(47):
	array=[]
	for i in range(len(interval)):
		array.append(0)
	chr_array.append(array)

timestep=[]
for i in range(3,len(cont),47):
	l=cont[i].split()
	timestep.append(int(l[0]))
	if int(l[0])==2000000:
		startPos=i
	if int(l[0])==10000000:
		endPos=i

print "no of frame", len(timestep),startPos,endPos
noOfFrame=0
for i in range(startPos,endPos,47):
	noOfFrame+=1
	for j in range(i+1,i+47):
		l=cont[j].split()
		index=int(l[0])
		a=[float(l[1]),float(l[2]),float(l[3])]
		dist=numpy.linalg.norm(a)
		for k in range(1,len(interval)):
				if(dist>=interval[k-1])&(dist<interval[k]):
					chr_array[index][k]+=1   ##########
		#chromosome[int(l[0])].append(dist)


print "used number of frame ",noOfFrame
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

ff=open('COM_errorbar.dat','w')

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
ff=open('CentreOfMass_distribution.dat','w')
for j in range(len(interval)):
	ff.write(str(j+1)+'\t'+str(xvec[j])+'\t')
	for i in range(1,47):
		ff.write(str(chr_array[i][j])+'\t')
	ff.write('\n')
'''
f, axarr = subplots(4, 6)
xx=-1
for i in range(1,24):
	yy=(i-1)%6
	if yy==0:
		xx+=1
	axarr[xx,yy].plot(xvec,chr_array[i],'r.-',label='chr '+str(i))
	axarr[xx,yy].plot(xvec,chr_array[i+23],'b.-',label='chr '+str(i+23))
	axarr[xx,yy].legend(loc='upper right',prop={'size':9})
	if xx==3:
		axarr[xx,yy].set_xlabel('R')
	if yy==0:
		axarr[xx,yy].set_ylabel('S(R)')
	axarr[xx,yy].tick_params(axis='both', which='major', labelsize=10)
	axarr[xx,yy].tick_params(axis='both', which='minor', labelsize=10)
	axarr[xx,yy].locator_params(nbins=3)
	

setp([a.get_xticklabels() for a in axarr[3, 5:6]], visible=False)
setp([a.get_yticklabels() for a in axarr[3:4, 5]], visible=False)
#f.savefig('RadialDis'+str(i)+'_'+str(i+23)+'.png')
f.tight_layout()
#show()





for i in range(1,24):
	f=figure()
	plot(xvec,chr_array[i],'r.-',label='chr '+str(i))
	plot(xvec,chr_array[i+23],'b.-',label='chr '+str(i+23))
	legend(loc='upper right')
	xlabel('Radius')
	ylabel('COM')
	f.savefig('COM'+str(i)+'_'+str(i+23)+'.png')
'''



