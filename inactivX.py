

filename='tmp.data.chain'
f=open(filename)

fw=open(filename+'InactiveX','w')

number=input("enter the type of Inactive X")

for line in f:
	l=line.split()
	if len(l)==6:
		if int(l[1])==46:
			fw.write(l[0]+'\t'+l[1]+'\t'+str(number)+'\t'+l[3]+'\t'+l[4]+'\t'+l[5]+'\n')
		else:
			fw.write(line)
	else:
		fw.write(line)
		
