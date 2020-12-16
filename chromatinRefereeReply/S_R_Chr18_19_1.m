clear

a1=load('./GM12878/GM_SR.dat');
a2=load('./HMEC/GM_SR.dat');
a3=load('./HUVEC/GM_SR.dat');
a4=load('./IMR90/GM_SR.dat');
a5=load('./NHEK/GM_SR.dat');
a6=load('./GM12878/GM_SR.dat');

x={a1,a6,a2,a3,a4,a5};

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



g = fittype( @(p3,p4, x) (1/p4)*exp((x-p3)./p4).*exp(-exp((x-p3)./p4)));
g1 =  fittype(@(p5,p6, x) (1/(p6*sqrt(2*pi)))*exp(-((x-p5).^2)./(2*(p6.^2))));
name={'GM12878','GM12878','HMEC','HUVEC','IMR90','NHEK'};
startingVals=[0.5,0.2];
figure

XL=0.17;XR=0.01;XGap=0.01;Row=1;
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
             p5=plot(Ch18(:,1)/98,Ch18(:,2),'ro');
             p6=plot(Ch19(:,1)/98,Ch19(:,2),'bx');             
%              disp('chr 18')
%              [h,p,ks2stat]=kstest2(z18,Ch18(:,2))
%              1-p
%              disp('chr 19')
%              [h,p,ks2stat]=kstest2(z19,Ch19(:,2))
%              1-p
             end
             
             
             if chro==1         
             disp('chro18')
             Sx=AL(:,2);Sy=z18;Ex=Ch18(:,1)./98;Ey=Ch18(:,2);
             [fE,GE] = fit(Ex,Ey,g,'StartPoint',startingVals)
             [fS,GS] = fit(Sx,Sy,g,'StartPoint',startingVals)
             p7=plot(Ex,fE(Ex),'g-','Linewidth',2);
             p8=plot(Sx,fS(Sx),'g--','Linewidth',2);
             
             disp('chro19')
             %p6=plot(Ch19(:,1)/98,Ch19(:,2),'bx');    
             Sx=AL(:,2);Sy=z19;Ex=Ch19(:,1)./98;Ey=Ch19(:,2);
             startingVals=[0.4,0.6];
             [fE,GE] = fit(Ex,Ey,g1,'StartPoint',startingVals)
             [fS,GS] = fit(Sx,Sy,g1,'StartPoint',startingVals)
             p9=plot(Ex,fE(Ex),'m-','Linewidth',2);
             p10=plot(Sx,fS(Sx),'m--','Linewidth',2);
  
             end
             
             
             
             
             
             set(gca,'YTick',0:2:4.1)
             set(gca,'FontSize',10)
             
               
             fontname = 'Helvetica';
             set(0,'defaultaxesfontname',fontname);
             set(0,'defaulttextfontname',fontname);
             if chro>1
             prandom= plot(interval./radius,chr_array,'m-')   ;
             end
             
            axis([0,1.1,0,4.02])
            
             set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica')  %% Palatino'
	  
             ht= title(name{chro},'fontweight','normal');
             PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.1 PP(3)])
            if (j==1)
                hy=ylabel('S(R)');
                set([hy],'FontName','Helvetica','FontSize',12);
               
            else
                set(gca,'YTicklabel',[]);
            end
            if (chro==1)
                hx=xlabel('R');
                set([hx],'FontName','Helvetica','FontSize',12);
            else
                 set(gca,'XTicklabel',[]);
            end
            
            set([ht;],'FontName','Helvetica','FontSize',12);
            %set(gca,'FontName',MyFontName,'FontSize',MyFontSize);
            
          % else
            if chro>2 
            hl=legend([p1,p2,prandom],'18 Sim','19 Sim','Random','Location','NorthWest');
            set([hl],'FontName','Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[XPos YPos+0.21 pos(3:4)])
            legend('boxoff')
            end
            
               if chro==1
            hl=legend([p8,p10,p7,p9],'18 Sim','19 Sim','18 Exp','19 Exp','Location','NorthWest');
            set([hl],'FontName', 'Helvetica','FontSize',7);
            pos=get(hl,'position');
            set(hl,'position',[pos(1)+0.05 pos(2)-0.05 pos(3) pos(4)])
            legend('boxoff')
            text(0.47,3.8,'Extreme value','Color', 'g','FontName',  'Helvetica','FontSize',8);
            text(0.47,3.5,'Gaussian', 'Color', 'm','FontName','Helvetica','FontSize',8);
               end
            
            
             if chro==2
            hl=legend([p1,p2,p5,p6,prandom],'18 Sim','19 Sim','18 Exp','19 Exp','Random','Location','NorthWest');
            set([hl],'FontName', 'Helvetica','FontSize',6);
            pos=get(hl,'position');
            set(hl,'position',[pos(1)+0.05 pos(2)-0.025 pos(3) pos(4)])
            legend('boxoff')
              end
            
            
            
            
                       
         end
            
           set(gca,'color','none')  
        
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SR_18_19_2', 'pdf')

