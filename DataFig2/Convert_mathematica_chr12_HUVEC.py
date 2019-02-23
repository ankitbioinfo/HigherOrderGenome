
import os 
pathname=os.getcwd()
import numpy as np 

a=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157,249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
size=a
csize=np.cumsum(size)
atoms=sum(size)

print atoms 
f1=open('HUVEC1.dat')
gmfile=f1.readlines()


#red=1 , yellow =6, yellowgreen =7, green =8 ,  cyan =9 ,  blue =10 ,    indigo =11 ,violet =12 ,'RGBColor[0.0, 0.0, 0.0]'

violet='RGBColor[0.56078431,0,1]'
green='RGBColor[0,.50196,0]'
blue='RGBColor[0,0,1]'
indigo='RGBColor[0.2941,0,0.5098]'
yellowgreen='RGBColor[ 0.60392157,0.80392157,0.19607843]'
cyanblue='RGBColor[ 0,0.51764706,0.70980392]'

chrom_number=12+23-1 

sphCo=['Red','Yellow',yellowgreen,green,'Cyan',blue,indigo,violet]
gm=[]
start=0
for k in range(1,20):
	count=0
	for i in range(start+1,1+csize[k-1]): #less one notice 
		count=count+1
		if (k==(chrom_number+1))or(k==(chrom_number+1-23)):
			l=gmfile[i].split()
			if int(l[1])==1:
				gm.append(sphCo[0])
			elif int(l[1])==6:
				gm.append(sphCo[1])
			elif int(l[1])==7:
				gm.append(sphCo[2])
			elif int(l[1])==8:
				gm.append(sphCo[3])
			elif int(l[1])==9:
				gm.append(sphCo[4])
			elif int(l[1])==10:
				gm.append(sphCo[5])
			elif int(l[1])==11:
				gm.append(sphCo[6])
			elif int(l[1])==12:
				gm.append(sphCo[7])
	#print k, count 
	start=csize[k-1]

#print gm 

gm=gm+gm

chrom=np.zeros((a[chrom_number],3),dtype=np.float)

f=open('file10001.dat')
savename='Figure'
ff=open('mathematica'+savename+'.dat','w')
chromosome=np.zeros((a[chrom_number],3),dtype=np.float)
cont=f.readlines()

#print size
#print csize 
radius=17.2


print size[chrom_number]
print csize[chrom_number] 
	
for i in range(5,len(cont)):  ###8  check this line 
	l=cont[i].split()
	if len(l)==6:
		if int(l[1])==(chrom_number+1):
			#print l[0],csize[chrom_number-1]
			chromosome[int(l[0])-1-csize[chrom_number-1]]=[float(l[3])/radius,float(l[4])/radius,float(l[5])/radius]
	


#  Opacity[1.], Red, Specularity[White,20]'  18 
#   Opacity[1.], Blue, Specularity[White,20]' 19
#  else  Opacity[0.1], Gray'
#ff.write('Export["'+pathname+'/'+savename+'.png", Graphics3D[{Gray, EdgeForm[]\n')
#ff.write('Export["'+pathname+'/'+savename+'.png", Graphics3D[{\n')

#ff.write('Export["'+savename+'.png", Graphics3D[{\n')

ff.write('insidestuff = {')


for i in range(len(chromosome)):
	chrom[i]=140.0*(chromosome[i]+[-0.25,-0.25,-0.5])   ## 8 [-0.25,0,-.5]  9 [-0.25,-0.25,-0.5]
	

#for i in range(40): #less one notice 
for i in range(a[chrom_number]): 
	if i==0:
		ff.write('Opacity[1.], '+gm[i]+', Specularity[],Sphere[{'+str(chrom[i][0])+','+str(chrom[i][1])+','+str(chrom[i][2])+'},10]'+'\n')
	else:
		ff.write(',Opacity[1.], '+gm[i]+', Specularity[],Sphere[{'+str(chrom[i][0])+','+str(chrom[i][1])+','+str(chrom[i][2])+'},10]'+'\n')

#for i in range(40): #less one notice 
for i in range(a[chrom_number]-1): 
	#ff.write(',Opacity[0.1], Red, Cylinder[{{'+str(chrom[i][0])+','+str(chrom[i][1])+','+str(chrom[i][2])+'},'+'{'+str(chrom[i+1][0])+','+str(chrom[i+1][1])+','+str(chrom[i+1][2])+'}},5]'+'\n')
	ff.write(',Opacity[1.], Black, Specularity[], Cylinder[{{'+str(chrom[i][0])+','+str(chrom[i][1])+','+str(chrom[i][2])+'},'+'{'+str(chrom[i+1][0])+','+str(chrom[i+1][1])+','+str(chrom[i+1][2])+'}},3]'+'\n')

ff.write('};\n\n')



ff.write('final=Show[\n')
ff.write(' Graphics3D[{\n')
ff.write('   insidestuff\n')
ff.write('   },\n')
ff.write('  Boxed -> False,\n')
ff.write('  ImageSize -> {250, Automatic},\n')
ff.write('  Method -> {"ShrinkWrap" -> True}\n')
ff.write('  ],\n\n\n')

ff.write('SetOptions[{SphericalPlot3D}, PlotPoints -> 70];\n')


ff.write(' SphericalPlot3D[\n')
ff.write('  140,\n')
ff.write('  {t, 0, Pi},\n')
ff.write('  {p, 0, 2*Pi},\n')
ff.write('  PlotStyle -> \n')
ff.write('   Directive[White, Opacity[0.2], Specularity[White, 10]],\n')
ff.write('  Mesh -> 15,\n')
ff.write('  MeshStyle -> Opacity[0.075]\n')
ff.write('  ]\n')
ff.write(' ]\n\n\n')


ff.write('Export["Figure_HUVEC.png",final,ImageResolution->300,"CompressionLevel" -> 0]\n')


#ff.write('},Boxed->False],ImageResolution -> 600,"CompressionLevel" -> 0 ]\n')

		






