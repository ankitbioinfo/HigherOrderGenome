
clear all 

kalhore=load('Kalhore.dat');

a(1,:,:)=load('./IMR90/Avg_COM_errorbar.dat');

figure
XL=0.12;XR=0.01;XGap=0.03;Row=1;
YT=0.08;YB=0.15;YGap=0.07;Col=1;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 


%name={ '\chi^2=0.89, Actual loop: 250, T_1=4223,T_6=1550,T_{12}=96,T_{13}=81,T_{14}=61,T_{15}=35,T_{16}=14,T_{17}=16,T_{18}=14,T_{19}=6,T_{20}=2'};

% name={'\chi^2=0.63, #loops=702',...
%       '\chi^2=0.47, #loops=587',... 
%       '\chi^2=0.50, #loops=469',...
%       '\chi^2=0.72, #loops=354',...
%       '\chi^2=0.55, #loops=248',...
%       '\chi^2=0.42, #loops=208'};

set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);
sizes=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157];

for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	if chro<7
        marray=[XPos,YPos,Width,Height];
       	subplot('Position',marray);
        t=a(chro,:,:);    
        xax=sizes(t(:,1:23,1));
        [t(:,1:23,3)',t(:,24:46,3)'];
        zz=max([t(:,1:23,3)',t(:,24:46,3)']');
        yy=mean([t(:,1:23,2)',t(:,24:46,2)'],2);
         
        h=errorbar(xax,yy',zz,'ro','LineWidth',1, 'MarkerEdgeColor','r',...
                 'MarkerFaceColor','none',...
                 'MarkerSize',5);hold on 
             
          SPEP=setdiff([1:23],[21,22,1:6]);
         rsim=corrcoef(xax(SPEP),yy(SPEP));
         p=polyfit(xax(SPEP),yy(SPEP)',1);
         %yfit=polyval(p,xax(SP:EP));  
         plot(xax(SPEP),polyval(p,xax(SPEP)),'r-','linewidth',2,'MarkerFaceColor','m')
%          coef1=sprintf('%0.1e',p(1));
%          coef2=sprintf('%0.1f',p(2));
%          ht=text(100,0.88,strcat('y = ', num2str(coef1) ,'x +',num2str(coef2)),'Color','r');
%         set([ht],'FontName','Helvetica','FontSize',18);        
%              
             
             
        kalhorestd=  0.5*((kalhore(:,2)-kalhore(:,3)) +  (kalhore(:,4)-kalhore(:,2)));
             
        %k=errorbar(xax,kalhore(:,2),kalhorestd,'b^','LineWidth',1, 'MarkerEdgeColor','b',...
        %         'MarkerFaceColor','b',...
        %         'MarkerSize',10); 
        k= plot(xax,kalhore(:,2),'bo','MarkerFaceColor','none','MarkerSize',5);
        
          rexp=corrcoef(xax,kalhore(:,2));  
          p=polyfit(xax,kalhore(:,2)',1);
         yfit=polyval(p,xax);  
         plot(xax,polyval(p,xax),'b-','linewidth',2,'MarkerFaceColor','b')
 
        
        
             
        %textsymbol=[yy+zz' yy-zz' kalhore(:,2)-kalhorestd  kalhore(:,2)+kalhorestd];
	textsymbol=[yy+zz' yy-zz' kalhore(:,2)-0.02 kalhore(:,2)+0.02];
        set(gca,'YTick',0.1:0.3:0.9)
        set(gca,'FontSize',18)
        hl=legend([h,k], strcat('Sim: r=', sprintf('%0.2f', rsim(1,2))),  strcat('Exp: r=', sprintf('%0.2f',rexp(1,2))),...
             'Location','SouthEast','Orientation','vertical');
	set(hl,'color','none'); set(hl, 'Box', 'on');
         set([hl],'FontName','Helvetica','FontSize',18);

        for chrmo=1:23
		  cut=2;
		    if chrmo>9 
			cut=5;
		    end

            if mod(chrmo,2)==0
                ht=text(sizes(chrmo)-cut,max(textsymbol(chrmo,:))+0.035,num2str(chrmo),'Fontsize',18,'Color','k');
            elseif chrmo==23
                ht= text(sizes(chrmo)-cut,min(textsymbol(chrmo,:))-0.035,'X','Fontsize',18,'Color','k');
            else
                ht= text(sizes(chrmo)-cut,min(textsymbol(chrmo,:))-0.035,num2str(chrmo),'Fontsize',18,'Color','k');
            end
        end
        set([ht],'FontName','Helvetica','FontSize',18);
        set(gca, 'FontName', 'Helvetica') 
       axis([40,258,0.08,0.94]);
		if (j==1)
                hy=ylabel('Relative radial position');
                set([hy],'FontName','Helvetica','FontSize',18);
        end
        if (i==1)
              	hx=xlabel('Chromosome size (Mb)');
                set([hx],'FontName','Helvetica','FontSize',18);
        end
	end
	XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

ht=title('IMR90');
PP=get(ht,'Position');
set(ht,'Position',[PP(1) PP(2)-0.03 PP(3)])
set([ht;],'FontName','Helvetica','FontSize',18);
%plot([45,45,55,55,45],[0.5,0.83,0.83,0.5,0.5],'k--','linewidth',1)

% ht=title('\chi^2=0.6983') ;
%  PP=get(ht,'Position');
%  set(ht,'Position',[PP(1) PP(2)-0.03 PP(3)])
%  set([ht],'FontName','Helvetica','FontSize',18);

saveas(gcf, 'ErrorbarIMR90', 'pdf')
