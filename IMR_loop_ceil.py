

import random 


#sizechr=[250,244,198,192,181,172,160,147,142,136,135,134,116,108,103,91,82,78,60,63,49,52,156]
sizechr=[ 249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157]
N=sum(sizechr)
nbonds=2*N-46
index=nbonds+1
print nbonds
f=open('tmp.data.chain_InactiveX_Actual_loop','w')
f1=open('tmp.data.chainInactiveX')
for l in f1:
	f.write(l)

remaining=[]
looplist=[]
f2=open('IMR_Final_loopList_ceil.dat')

GMloop=f2.readlines()

temp=0

for chro in range(23):
	aa=[]
	for j in range(len(GMloop)):
		l=GMloop[j].split()
		if (chro+1)==int(l[0]):
			first=int(l[1])
			second=int(l[2])
			aa.append(first)
			aa.append(second)
			if (first<=sizechr[chro])&(second<=sizechr[chro]):
				first=int(l[1])+temp
				second=int(l[2])+temp
				if (first+1)!=second:
					looplist.append([first,second])
					f.write(str(index)+'\t2\t'+str(first)+'\t'+str(second)+'\n')
					remaining.append('\t2\t'+str(first+N)+'\t'+str(N+second)+'\n')
					index=index+1
				else:
					print l
		
	temp+=sizechr[chro]
	#print chro+1,max(aa)

print len(looplist),len(remaining)
for i in remaining:
	f.write(str(index)+i)
	index=index+1
