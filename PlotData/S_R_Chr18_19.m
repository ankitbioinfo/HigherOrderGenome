clear

a1=load('./GM12878/GM_SR.dat');
a2=load('./HMEC/GM_SR.dat');
a3=load('./HUVEC/GM_SR.dat');
a4=load('./IMR90/GM_SR.dat');
a5=load('./NHEK/GM_SR.dat');

x={a1,a2,a3,a4,a5};

Ch19=load('Kreth_chr19');
Ch18=load('Kreth_chr18');


radius=17.2;
interval=linspace(0,17.2,100);
binsize=interval(2)-interval(1);
for j=1:1
	sum1=0.0;
	for i=1:length(interval)
		sum1=sum1+(4*pi*interval(i)^2)*binsize;
    end
	for i=1:length(interval)
		chr_array(i)=radius*(4*pi*interval(i)^2)/sum1;
    end
end



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
             z18=mean([AL(:,18+2),AL(:,18+25)],2);
             z19=mean([AL(:,19+2),AL(:,19+25)],2);     
             p1=plot(AL(:,2),z18,'r-');
             hold on 
             p2=plot(AL(:,2),z19,'b-');
             
             if chro==1
             p5=plot(Ch18(:,1)/98,Ch18(:,2),'ro');
             p6=plot(Ch19(:,1)/98,Ch19(:,2),'bx');
             end
             
             
             set(gca,'YTick',0:2:4.1)
             set(gca,'FontSize',18)
             
               
             fontname = 'Helvetica';
             set(0,'defaultaxesfontname',fontname);
             set(0,'defaulttextfontname',fontname);
             
             prandom= plot(interval./radius,chr_array,'m-')   ;
             
            axis([0,1.1,0,4.02])
            
             set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica')  %% Palatino'
	  
             ht= title(name{chro});
             PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.3 PP(3)])
            if (j==1)
                hy=ylabel('S(R)');
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
            
            set([ht;],'FontName','Helvetica','FontSize',18);
            %set(gca,'FontName',MyFontName,'FontSize',MyFontSize);
            
           else
            hl=legend([p1,p2,p5,p6,prandom],'18 Sim','19 Sim','18 Exp','19 Exp','Random','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',18);
            pos=get(hl,'position');
            set(hl,'position',[XPos YPos-0.1 pos(3:4)])
            legend('boxoff')
                       
         end
            
           set(gca,'color','none')  
        
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SR_18_19', 'pdf')

