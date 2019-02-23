clear

a1=load('./GM12878/GM_SR.dat');
a2=load('./HMEC/GM_SR.dat');
a3=load('./HUVEC/GM_SR.dat');
a4=load('./IMR90/GM_SR.dat');
a5=load('./NHEK/GM_SR.dat');

x={a1,a2,a3,a4,a5};

Ch12=load('Kreth_chr12');
Ch20=load('Kreth_chr20');




name={'GM12878','HMEC','HUVEC','IMR90','NHEK'};

figure

XL=0.09;XR=0.01;XGap=0.01;Row=2;
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
             z12=mean([AL(:,12+2),AL(:,12+25)],2);
             z20=mean([AL(:,20+2),AL(:,20+25)],2);     
             p1=plot(AL(:,2),z12,'b-');
             hold on 
             p2=plot(AL(:,2),z20,'r-');
             
             if chro==1
             p5=plot(Ch12(:,1)./98,Ch12(:,2),'bo');
             p6=plot(Ch20(:,1)./98,Ch20(:,2),'rx');
             end
             
             set(gca,'YTick',0:1:2)
             set(gca,'FontSize',18)
             
             %prandom= plot(interval./radius,chr_array,'m-')   ;
             
            axis([0,1.1,0,3])
	  
             set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica')
             ht= title(name{chro});
              PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.2 PP(3)])
            if (j==1)
                hy=ylabel('S(R)');
                set([hy],'FontName', 'Helvetica','FontSize',18);
            else
                set(gca,'YTicklabel',[])
            end
            if (chro>2)
                hx=xlabel('R');
                set([hx],'FontName', 'Helvetica','FontSize',18);
            else
                 set(gca,'XTicklabel',[]);
            end
            
            set([ht;],'FontName', 'Helvetica','FontSize',18);
            %set(gca,'FontName',MyFontName,'FontSize',MyFontSize);
            
           else
            hl=legend([p1,p2,p5,p6],'12 Sim','20 Sim','12 Exp','20 Exp','Location','NorthWest');
            set([hl],'FontName', 'Helvetica','FontSize',18);
            pos=get(hl,'position');
            set(hl,'position',[XPos YPos-0.05 pos(3) pos(4)])
            legend('boxoff')
                       
         end
            
            set(gca,'color','none') 
        
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SR_12_20', 'pdf')

