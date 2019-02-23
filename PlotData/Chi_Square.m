
clear

filename={'Conf1','Conf2','Conf3','Conf4','Conf5','Conf6','Conf7','Conf8','Conf9','Conf10',...
   	 'Conf11','Conf12','Conf13','Conf14','Conf15','Conf16','Conf17','Conf18','Conf19','Conf20',...
            'Conf21','Conf22','Conf23','Conf24','Conf25',};

Expected=load('Kalhore.dat');
E=Expected(:,2);

for i=1:25
	name=strcat(filename{i},'/COM_errorbar.dat');
	t=load(name);
	
    x{i}=t;
    yy=mean([t(1:23,2),t(24:46,2)],2);
   
    
    chi=((yy-E).^2)./E;
    chi2(i)=sum(chi);
    
end



for i=1:3
	clear array
	for j=1:length(x)
        	array(:,j)=x{j}(:,i);
    	end
    	Y(:,i)=mean(array,2);
end
dlmwrite('Avg_COM_errorbar.dat',Y,'\t');
