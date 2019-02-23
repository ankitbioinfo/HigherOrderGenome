clear

a1=load('./GM12878/GM_COM.dat');
a2=load('./HMEC/GM_COM.dat');
a3=load('./HUVEC/GM_COM.dat');
a4=load('./IMR90/GM_COM.dat');
a5=load('./NHEK/GM_COM.dat');




x={a1,a2,a3,a4,a5};


Ch19=load('kalhor_data_19_P_CM_R.d');
Ch18=load('kalhor_data_18_P_CM_R.d');

figure
name={'GM12878','HMEC','HUVEC','IMR90','NHEK'};

XL=0.11;XR=0.01;XGap=0.01;Row=2;
YT=0.08;YB=0.13;YGap=0.1;Col=3;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 

set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	if chro<=5
        marray=[XPos,YPos,Width,Height];
        subplot('Position',marray);
        
             AL=x{chro};
             z18=mean([AL(:,18+2),AL(:,18+25)],2);
             z19=mean([AL(:,19+2),AL(:,19+25)],2);     
             p1=plot(AL(:,2),z18,'r-');
             hold on 
             p2=plot(AL(:,2),z19,'b-');
             if chro==1
             p5=plot(Ch18(:,1),Ch18(:,2),'ro');
             p6=plot(Ch19(:,1),Ch19(:,2),'bx');
             end
             set(gca,'YTick',0:3:11)
             set(gca,'FontSize',18)
             
             
             set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica') 
	         axis([0,1.1,0,6.99])
            ht= title(name{chro});
             PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.3 PP(3)])
            set([ht],'FontName','Helvetica','FontSize',18);
            if (j==1)
                hy=ylabel('S_{CM}(R)');
                set([hy],'FontName','Helvetica','FontSize',18);
            else
                set(gca,'YTicklabel',[]);
            end
            if (chro>2)
                hx=xlabel('R');
                set([hx],'FontName','Helvetica','FontSize',18);
              else
                 set(gca,'XTicklabel',[]);
            end
            
    else
            hl=legend([p1,p2,p5,p6],'18 Sim','19 Sim','18 Exp','19 Exp','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',18);
            pos=get(hl,'position');
            set(hl,'position',[XPos YPos-0.05 pos(3:4)])
            legend('boxoff')
                       
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

saveas(gcf, 'S_CM_18_19', 'pdf')

