

clear all

%file1='MSD_1005-1052.dat';file2='MSD_3654-3701.dat';
%file1='MSD_1012-1052.dat';file2='MSD_3661-3701.dat';
%file1='MSD_1013-1052.dat';file2='MSD_3662-3701.dat';
%file1='MSD_1013-1148.dat'; file2='MSD_3662-3797.dat';
%file1='MSD_1026-1134.dat';file2='MSD_3675-3783.dat';

%file1='MSD_1052-1106.dat';file2='MSD_3701-3755.dat';
%file1='MSD_1052-1134.dat';file2='MSD_3701-3783.dat';
%file1='MSD_1052-1141.dat';file2='MSD_3701-3790.dat';
%file1='MSD_1052-1142.dat';file2='MSD_3701-3791.dat';
% file1='MSD_1052-1148.dat';file2='MSD_3701-3797.dat';
 


% file1='MSD_1106-1142.dat';file2='MSD_3755-3791.dat';
% file1='MSD_1226-1278.dat';file2='MSD_3875-3927.dat';
% file1='MSD_1306-1329.dat';file2='MSD_3955-3978.dat';
% file1='MSD_1306-1363.dat';file2='MSD_3955-4012.dat';
% file1='MSD_1306-1405.dat';file2='MSD_3955-4054.dat';


% file1='MSD_1329-1405.dat';file2='MSD_3978-4054.dat';
% file1='MSD_1346-1408.dat';file2='MSD_3995-4057.dat';
% file1='MSD_1363-1408.dat';file2='MSD_4012-4057.dat';
%file1='MSD_2699-2798.dat';file2='MSD_50-149.dat';
% file1='MSD_2701-2795.dat';file2='MSD_52-146.dat';
% 
% 
% 
% file1='MSD_2701-2798.dat';file2='MSD_52-149.dat';
% file1='MSD_3193-3306.dat';file2='MSD_544-657.dat';
% file1='MSD_3194-3306.dat';file2='MSD_545-657.dat';
% file1='MSD_3259-3306.dat';file2='MSD_610-657.dat';
% file1='MSD_3519-3614.dat';file2='MSD_870-965.dat';
% 
% 
% file1='MSD_3519-3621.dat';file2='MSD_870-972.dat';
% file1='MSD_3568-3614.dat';file2='MSD_919-965.dat';
% file1='MSD_3568-3621.dat';file2='MSD_919-972.dat';
% file1='MSD_25-180.dat';file2='MSD_2674-2829.dat';
% file1='MSD_26-179.dat';file2='MSD_2675-2828.dat';
% 
% 
 file1='MSD_26-180.dat';file2='MSD_2675-2829.dat';
% 


 




for i=1:5
	T{i}=load(strcat('Conf',num2str(i),'/TAG/',file1));
	T{i+5}=load(strcat('Conf',num2str(i),'/TAG/',file2));
end 



%color={'r','b','k','c','g'};
%dt=0.005;

name={'3D(XYZ)','XY-plane','YZ-plane','XZ-plane'};

figure

XL=0.1;XR=0.01;XGap=0.06;Row=2;
YT=0.08;YB=0.12;YGap=0.08;Col=2;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 

set(gcf, 'PaperSize', [12 8]);
set(gcf, 'PaperPosition', [0 0 12 8]);

for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
        marray=[XPos,YPos,Width,Height];
	subplot('Position',marray);
        %array=get(gca,'position')
	for p=1:length(T)
		x=T{p}(:,1);
		y(:,p)=T{p}(:,chro+1);
		plot(x,y(:,p),'k-','linewidth',0.05);
		hold on 
	end 
	value=mean(y,2);
	plot(x,value,'r-','linewidth',2);
	my=min(min(y));
	mx=max(max(y));
	axis([0,300,my*0.98, 1.02*mx ])

	 start=49;
	 finish=299;
	 po=polyfit(x(start:finish),value(start:finish),1);
         yfit=polyval(po,x(start:finish));    
         plot(x(start:finish),yfit,'b-','linewidth',1,'MarkerFaceColor','b')
         coef1=sprintf('%0.3f',po(1));
         coef2=sprintf('%0.1f',po(2));
         ht=text(100,my*1.05,strcat('y = ', num2str(coef1) ,'*x +',num2str(coef2)),'Color','k');

	

	ht=title(name{chro});
	PP=get(ht,'Position');  set([ht],'FontName','Helvetica','FontSize',12);
	 set(ht,'Position',[PP(1) PP(2)-mx*0.02 PP(3)])
	if i==2
	xlabel('time')
	else
	set(gca,'xticklabel',[])
	end
	if j==1
	ylabel('MSD')
	end
      
	%histogram(MSD,'BinWidth',0.2,'Normalization','pdf','EdgeColor',color{tau},'DisplayStyle','stairs','Linewidth',1)
	
        XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end
%value/30

%tname={'\tau=5','\tau=10','\tau=15','\tau=20','\tau=25'};

% legend(tname,'location','northeast');
% 
% xlabel('Displacement')
% ylabel('P(Displacement)')
% title('Chromosome 9, M\_id =79, T=12')
% 
saveas(gcf,'diffusion_file31','pdf');
