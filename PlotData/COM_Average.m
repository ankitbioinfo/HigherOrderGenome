clear


a1=load('./Conf1/CentreOfMass_distribution.dat');
a2=load('./Conf2/CentreOfMass_distribution.dat');
a3=load('./Conf3/CentreOfMass_distribution.dat');
a4=load('./Conf4/CentreOfMass_distribution.dat');
a5=load('./Conf5/CentreOfMass_distribution.dat');


x={a1,a2,a3,a4,a5};


length(x)

for i=1:46
    clear array
    for j=1:length(x)
        array(:,j)=x{j}(:,i+2);
    end
    Y(:,i)=mean(array,2);
end
x={[a1(:,1:2),Y]};

dlmwrite('GM_COM.dat',x,'\t');



