
import os

answer=os.path.isdir('my')
if answer==True:
	pass
else:
	os.mkdir('my')


f=open('DUMP_NVE.lammpstrj')
fw=open('txt','w')
index=1
for line in f:
	if line.find('ITEM: TIMESTEP')!=-1:
		fw.close()
		fw=open('my/file'+str(index)+'.dat','w')
		fw.write(line)
		print index
		index+=1
	else:
		fw.write(line)

