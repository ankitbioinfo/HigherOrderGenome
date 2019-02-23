
import numpy 

radius=17.2
interval=numpy.linspace(0,radius+2,100)

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

startPos=4001
endPos=10001+1
noOfFrame=0

centero=[123,343,584,742,930,1124,1295,1440,1590,1721,1867,1986,2101,2216,2324,2445,2523,2600,2690,2751,2801,2849,2946]

for i in range(23):
	centero.append(centero[i]+3043)



a=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
size=a+a
csize=numpy.cumsum(size)
atoms=sum(size)
print "number of atoms",atoms
	
chromosome=numpy.zeros((atoms+1,3),dtype=numpy.float)

centdist=numpy.zeros((atoms+1),dtype=numpy.float)

for filen in range(startPos,endPos,1):
	noOfFrame+=1
	name='my/file'+str(filen)+'.dat'
	f=open(name)
	cont=f.readlines()
	
	print filen, "Time", cont[1][0:-1]

	for i in range(5,len(cont)):  ###8  check this line 
		l=cont[i].split()
		if len(l)==6:
			chromosome[int(l[0])]=[float(l[3])/radius,float(l[4])/radius,float(l[5])/radius]

	start=1 
	for i in range(1,47):
		for j in range(start,1+csize[i-1]):
			dist=numpy.linalg.norm(chromosome[j] - chromosome[ centero[  i-1]]) 
			centdist[j]+=dist     
		
			
		start=1+csize[i-1]
		


	

ff=open('centeromere_distribution_mid.dat','w')

for i in range(1,1+atoms):
	centdist[i]=centdist[i]/float(noOfFrame)
	ff.write(str(centdist[i])+'\n')




ff.close()




