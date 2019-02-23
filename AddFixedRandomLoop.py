

import sys

f=open(sys.argv[1])

cont=f.readlines()

ff=open('tmp.data.chain_InactiveX_Actual_loop')
whole=ff.readlines()
l=whole[-1].split()
print whole[-1],
print len(cont)
totalbond=int(l[0])

fw=open('tmp.data.chain_InactiveX_loop','w')

fw.write(whole[0])
fw.write(whole[1])
fw.write(str(len(cont)+totalbond)+' bonds\n')
fw.write(whole[3])
fw.write('2 bond types\n')

for i in range(5,len(whole)):
	fw.write(whole[i])

for j in range(len(cont)):
	l=cont[j].split()
	totalbond=totalbond+1
	fw.write(str(totalbond)+'\t'+l[1]+'\t'+l[2]+'\t'+l[3]+'\n')
