
import numpy 

a=[198,182,160,156,153,150,153,132,125,130,122,122,121,126,104,99,96,91,62,167]
size=a+a
noc=len(size)+1
csize=numpy.cumsum(size)
atoms=sum(size)
print "number of atoms",atoms


startPos=4001
endPos=10001+1
noOfFrame=0


timestep=0.005 


	
chromosome=numpy.zeros((endPos-startPos,atoms+1,3),dtype=numpy.float)

for filen in range(startPos,endPos,1):
	noOfFrame+=1
	name='my/file'+str(filen)+'.dat'
	f=open(name)
	cont=f.readlines()
	
	time=cont[1][0:-1]
	#print filen, "Time", time



	for i in range(5,len(cont)):  ###8  check this line 
		l=cont[i].split()
		if len(l)==6:
			chromosome[filen-startPos][int(l[0])]=[float(l[3]),float(l[4]),float(l[5])]

	'''
	if filen==startPos:
		initPos=chromosome[monomer]
		initTime=float(time)
	
	if filen>startPos:
		dist=numpy.linalg.norm(chromosome[monomer]-initPos)
		Dcoef = (dist**2)/(  (float(time)-initTime)    *   timestep  )
	
		#ff.write(str(time)+'\t'+str(chromosome[monomer][0])+'\t'+str(chromosome[monomer][1])+'\t'+str(chromosome[monomer][2])+'\t'+str(Dcoef)+'\n')
	'''	
N=noOfFrame
print N



m1=[1013,1052,1363,1346,1013,	1052,1052,1306,1226,1306,	1306,1329,544,1005,1052,	545,610,1106,1026,25,	52,26,50,1012,1052,	870,919,870,919, 26, 52]
m2=[1052,1148,1408,1408,1148,	1106,1134,1363,1278,1329,	1405,1405,657,1052,1142,	657,657,1142,1134,180,	146,179,149,1052,1141,	972,972,965,965, 180, 149]

monomer1=[]
monomer2=[]
n=sum(a)

for i in range(len(m1)):
	monomer1.append(n+m1[i])
	monomer1.append(m1[i])
	monomer2.append(n+m2[i])
	monomer2.append(m2[i])


for mo in range(len(monomer1)):
	fy=open('TAG/MSD_'+str(monomer1[mo])+'-'+str(monomer2[mo])+'.dat','w')
	fx=open('TAG/displacement_'+str(monomer1[mo])+'-'+str(monomer2[mo])+'.dat','w')
	for tau in range(1,300):
		MSD_3D=0.0
		MSD_xy=0.0
		MSD_yz=0.0
		MSD_zx=0.0
		for i in range(N-tau):
			disp_3D=numpy.linalg.norm(chromosome[i+tau][monomer1[mo]]-chromosome[i][monomer2[mo]])  ## 3D 
			#print chromosome[i+tau][monomer1]
			disp_xy=numpy.linalg.norm(chromosome[i+tau][monomer1[mo]][[0,1]] - chromosome[i][monomer2[mo]][[0,1]])
			disp_yz=numpy.linalg.norm(chromosome[i+tau][monomer1[mo]][[1,2]] - chromosome[i][monomer2[mo]][[1,2]])
			disp_zx=numpy.linalg.norm(chromosome[i+tau][monomer1[mo]][[0,2]] - chromosome[i][monomer2[mo]][[0,2]])
		    	MSD_3D+= disp_3D**2;
			MSD_xy+= disp_xy**2;
			MSD_yz+= disp_yz**2;
			MSD_zx+= disp_zx**2;
			if tau<6:
				fx.write(str(tau)+'\t'+str(disp_3D)+'\t'+str(disp_xy)+'\t'+str(disp_yz)+'\t'+str(disp_zx)+'\n')
	   
		value1=MSD_3D/(N-tau)
		value2=MSD_xy/(N-tau)
		value3=MSD_yz/(N-tau)
		value4=MSD_zx/(N-tau)
		fy.write(str(tau)+'\t'+str(value1)+'\t'+str(value2)+'\t'+str(value3)+'\t'+str(value4)+'\n')
		if tau%50==0:
			print tau 


#value/30

#   MSD(i)=(norm(chromosome[i+tau][monomer]-chromosome[i][monomer]))^2;  # single particle 










'''
1052 - 1013  #  53 -14  # 12 - 10  # chr 7 # 153 
1052 - 1148  #  53 -149 # 12 - 10  # chr 7 
1363 - 1408  #  79 -124 # 12 - 10  # chr 9 # 125 
1346 - 1408  #  62 -124 # 10 - 10  # chr 9
1013 - 1148  #  14 -149 # 10 - 10  # chr 7 
1106 - 1052  #  107-53  #  8 - 12  # chr 7 
1134 - 1052  #  135 -53 #  8 - 12  # chr 7 
1306 - 1363  #  22 - 79 #  8 - 12  # chr 9 
1226 - 1278  #  74 -126 #  8 - 8   # chr 8 
1329 - 1306  #  45 - 22 #  8 - 8   # chr 9
1306 - 1405  #  22 - 121#  8 - 8   # chr 9 
1329 - 1405  #  45 - 121#  8 - 8   # chr 9 
657 -   544  #  117 - 4 #  10-8    # chr 4 
965 - 972    # 116 -123 #  8-10    # chr 6	

1052-1005    # 53-6    # 12-6
1052-1026    # 53-27
1052-1142    # 53-143

657-545	     # 117-5	# 10-6
657-582      # 117-42
657-610      # 117-70
657-635      # 117-95  

1106-1142    # 107-143  #8-6 
1134-1026    # 135-27

25-180			#6-6
52-146

26-179			#1-1
50-149

1052-1012		#12-1
1052-1141
972-870			#10-1
972-919
965-870			#8-1
965-919			

180-26			#6-1
52-149			
'''
