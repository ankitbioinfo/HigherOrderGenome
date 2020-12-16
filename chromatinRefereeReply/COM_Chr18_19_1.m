clear

a1=load('./GM12878/GM_COM.dat');
a2=load('./HMEC/GM_COM.dat');
a3=load('./HUVEC/GM_COM.dat');
a4=load('./IMR90/GM_COM.dat');
a5=load('./NHEK/GM_COM.dat');
a6=load('./GM12878/GM_COM.dat');



x={a1,a6,a2,a3,a4,a5};




%g = fittype( @(p1,p3,p4,p5,p6, x) (0.5-p1)*(1/(p6*sqrt(2*pi)))*exp(-((x-p5).^2)./(2*(p6.^2)))  + (0.5+p1)*(1/p4)*exp((x-p3)./p4).*exp(-exp((x-p3)./p4)));
g = fittype( @(p1,p3,p4,p5,p6, x) p1*(1/(p4*sqrt(2*pi)))*exp(-((x-p3).^2)./(2*(p4.^2))) +(1-p1)*(1/(p6*sqrt(2*pi)))*exp(-((x-p5).^2)./(2*(p6.^2))));


Ch19=load('kalhor_data_19_P_CM_R.d');
Ch18=load('kalhor_data_18_P_CM_R.d');

figure
name={'GM12878','GM12878','HMEC','HUVEC','IMR90','NHEK'};

XL=0.2;XR=0.01;XGap=0.01;Row=1;
YT=0.08;YB=0.2;YGap=0.1;Col=1;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 

set(gcf, 'PaperSize', [6 5]);
set(gcf, 'PaperPosition', [0 0 6 5]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	if chro<=6
        marray=[XPos,YPos,Width,Height];
        subplot('Position',marray);
        
             AL=x{chro};
             z18=mean([AL(:,18+2),AL(:,18+25)],2);
             z19=mean([AL(:,19+2),AL(:,19+25)],2);     
             p1=plot(AL(:,2),z18,'r-');
             hold on 
             p2=plot(AL(:,2),z19,'b-');

	         if chro==2
             p5=plot(Ch18(:,1),Ch18(:,2),'ro');
             p6=plot(Ch19(:,1),Ch19(:,2),'bx');
             end

             if chro==1
             %p5=plot(Ch18(:,1),Ch18(:,2),'ro');
             %p6=plot(Ch19(:,1),Ch19(:,2),'bx');

		
		disp('chro18')
             startingVals =[0.6,0.2, 0.4,    0.85,0.1];
	        Sx=AL(:,2);Sy=z18;Ex=Ch18(:,1);Ey=Ch18(:,2);
		[fE,GE] = fit(Ex,Ey,g,'StartPoint',startingVals)
		[fS,GS] = fit(Sx,Sy,g,'StartPoint',startingVals)
		p7=plot(Ex,fE(Ex),'g-','Linewidth',2);
        p8=plot(Sx,fS(Sx),'g--','Linewidth',2);
		

		disp('chro19')
        startingVals =[0.5,0.4, 0.05,    0.6,0.05]; %chr 19 
		Sx=AL(:,2);Sy=z19;Ex=Ch19(:,1);Ey=Ch19(:,2);
		[fE,GE] = fit(Ex,Ey,g,'StartPoint',startingVals)
		[fS,GS] = fit(Sx,Sy,g,'StartPoint',startingVals)
		p9=plot(Ex,fE(Ex),'m-','Linewidth',2);
        p10=plot(Sx,fS(Sx),'m--','Linewidth',2);
		
             text(0.55,6.5, 'Gaussian fit','FontName','Helvetica','FontSize',10);



             end
             set(gca,'YTick',0:3:11)
             set(gca,'FontSize',10)
		
	 
	
             
             set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica') 
	         axis([0,1.05,0,6.99])
            ht= title(name{chro},'fontweight','normal');
             PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.1 PP(3)])
            set([ht],'FontName','Helvetica','FontSize',12);
            if (j==1)
                hy=ylabel('S_{CM}(R)');
                set([hy],'FontName','Helvetica','FontSize',12);
            else
                set(gca,'YTicklabel',[]);
            end
            if (chro>=1)
                hx=xlabel('R');
                set([hx],'FontName','Helvetica','FontSize',12);
              else
                 set(gca,'XTicklabel',[]);
            end
            
    %else   
            if chro>2
            hl=legend([p1,p2],'18 Sim','19 Sim','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[XPos YPos+0.25 pos(3:4)])
            legend('boxoff')
            end 
            
             if chro==2
            hl=legend([p1,p2,p5,p6],'18 Sim','19 Sim','18 Exp','19 Exp','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[pos(1)+0.05 pos(2)-0.05 pos(3:4)])
            legend('boxoff')
             end 
            
             if chro==1
            hl=legend([p8,p10,p7,p9],'18 Sim','19 Sim','18 Exp','19 Exp','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[pos(1)+0.05 pos(2)-0.05 pos(3:4)])
            legend('boxoff')
		    end 
                       
         end
        
            %h=legend([p1,p2,p3,p4,p5,p6],'T=[6,12]','T=[1,6,12] [-19]','2.5823','3.6135','4.5','5.5','Location','NorthWest');
            %pos=get(h,'position');
            %set(h,'position',[XPos-0.05 YPos pos(3:4)])
            %legend('boxon')
             %textobj=findobj(hobj,'type','text');
            %set(textobj,'Interpreter','latex','fontsize',12);
            %[hleg,hobj]=legend([p1,p2,p3],'GM12878','HUVEC','K562','Location','NorthWest');
        
             set(gca,'color','none')
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SCM2', 'pdf')

