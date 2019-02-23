clear

a1=load('./GM12878/GM_SR.dat');
a2=load('./HMEC/GM_SR.dat');
a3=load('./HUVEC/GM_SR.dat');
a4=load('./IMR90/GM_SR.dat');
a5=load('./NHEK/GM_SR.dat');

x={a1,a2,a3,a4,a5};

name={'GM12878','HMEC','HUVEC','IMR90','NHEK'};

figure

XL=0.099;XR=0.01;XGap=0.01;Row=2;
YT=0.08;YB=0.13;YGap=0.09;Col=3;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 

set(gcf, 'PaperSize', [15 12]);
set(gcf, 'PaperPosition', [0 0 15 12]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	if chro<=5
        marray=[XPos,YPos,Width,Height];
        subplot('Position',marray);
             AL=x{chro};
             z23=AL(:,23+2);
             z46=AL(:,23+25);     
             p1=plot(AL(:,2),z23,'b-');
             hold on 
             p2=plot(AL(:,2),z46,'r-');
             
             
             
             set(gca,'YTick',0:2:4)
             set(gca,'FontSize',21)
             
                
               set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica')
            axis([0,1.1,0,4.1])
	  
             ht= title(name{chro});
               PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.43 PP(3)])
             
            if (j==1)
                hy=ylabel('S(R)');
                set([hy],'FontName','Helvetica','FontSize',23);
            else
                set(gca,'YTicklabel',[]);
            end
            if (chro>2)
                hx=xlabel('R');
                set([hx],'FontName','Helvetica','FontSize',23);
            else
                 set(gca,'XTicklabel',[]);
            end
            
            set([ht;],'FontName','Helvetica','FontSize',27);
            %set(gca,'FontName',MyFontName,'FontSize',MyFontSize);
            
           else
            hl=legend([p1,p2],'Xa','Xi','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',23);
            pos=get(hl,'position');
            set(hl,'position',[XPos+0.05 YPos pos(3:4)])
            legend('boxoff')
                       
    end
            
            set(gca,'color','none')     
            
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SR_Xa_Xi', 'pdf')

