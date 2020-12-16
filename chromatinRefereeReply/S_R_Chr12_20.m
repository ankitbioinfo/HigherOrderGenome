clear

a1=load('./GM12878/GM_SR.dat');
a2=load('./HMEC/GM_SR.dat');
a3=load('./HUVEC/GM_SR.dat');
a4=load('./IMR90/GM_SR.dat');
a5=load('./NHEK/GM_SR.dat');
a6=load('./GM12878/GM_SR.dat');

x={a1,a6,a2,a3,a4,a5};

Ch12=load('Kreth_chr12');
Ch20=load('Kreth_chr20');


%g = fittype( @(p1,p3,p4,p5,p6, x) (0.5-p1)*(1/(p6*sqrt(2*pi)))*exp(-((x-p5).^2)./(2*(p6.^2)))  + (0.5+p1)*(1/p4)*exp((x-p3)./p4).*exp(-exp((x-p3)./p4)));
g = fittype( @(p3,p4, x) (1/p4)*exp((x-p3)./p4).*exp(-exp((x-p3)./p4)));

%startingVals =[0.6,0.2, 0.4,    0.85,0.1];
startingVals=[0.5,1];
name={'GM12878','GM12878','HMEC','HUVEC','IMR90','NHEK'};

figure

XL=0.09;XR=0.01;XGap=0.01;Row=2;
YT=0.08;YB=0.15;YGap=0.1;Col=3;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 

set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
        if chro<=6
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
             disp('chr12')
             [h,p,ks2stat]=kstest2(z12,Ch12(:,2))
             1-p
             disp('chr20')
             [h,p,ks2stat]=kstest2(z20,Ch20(:,2))
             1-p
             end
             
             
             if chro==2
             %p5=plot(Ch12(:,1)./98,Ch12(:,2),'bo');
             %p6=plot(Ch20(:,1)./98,Ch20(:,2),'rx');
                         		
            
            
             disp('chro20')
             Sx=AL(:,2);Sy=z20;Ex=Ch20(:,1)./98;Ey=Ch20(:,2);
             [fE,GE] = fit(Ex,Ey,g,'StartPoint',startingVals)
             [fS,GS] = fit(Sx,Sy,g,'StartPoint',startingVals)
             p9=plot(Ex,fE(Ex),'g-','Linewidth',2);
             p10=plot(Sx,fS(Sx),'g--','Linewidth',2);
             
             disp('chro12')
             Sx=AL(:,2);Sy=z12;Ex=Ch12(:,1)./98;Ey=Ch12(:,2);
             [fE,GE] = fit(Ex,Ey,g,'StartPoint',startingVals)
             [fS,GS] = fit(Sx,Sy,g,'StartPoint',startingVals)
             p7=plot(Ex,fE(Ex),'m-','Linewidth',2);
             p8=plot(Sx,fS(Sx),'m--','Linewidth',2);
  

             end
             
             set(gca,'YTick',0:1:2)
             set(gca,'FontSize',14)
             
             %prandom= plot(interval./radius,chr_array,'m-')   ;
             
            axis([0,1.1,0,3])
	  
             set(gca,'ticklength',3*get(gca,'ticklength'))
             set(gca, 'FontName', 'Helvetica')
             ht= title(name{chro},'fontweight','normal');
              PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.1 PP(3)])
            if (j==1)
                hy=ylabel('S(R)');
                set([hy],'FontName', 'Helvetica','FontSize',16);
            else
                set(gca,'YTicklabel',[])
            end
            if (chro>3)
                hx=xlabel('R');
                set([hx],'FontName', 'Helvetica','FontSize',16);
            else
                 set(gca,'XTicklabel',[]);
            end
            
            set([ht;],'FontName', 'Helvetica','FontSize',16);
            %set(gca,'FontName',MyFontName,'FontSize',MyFontSize);
            
           %else
            if chro>2
            hl=legend([p1,p2],'12 Sim','20 Sim','Location','NorthWest');
            set([hl],'FontName', 'Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[XPos YPos+0.24 pos(3) pos(4)])
            legend('boxoff')
            end
            
              if chro==1
            hl=legend([p1,p2,p5,p6],'12 Sim','20 Sim','12 Exp','20 Exp','Location','NorthWest');
            set([hl],'FontName', 'Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[XPos-0.02 YPos+0.17 pos(3) pos(4)])
            legend('boxoff')
              end
            
              
            if chro==2
            hl=legend([p8,p10,p7,p9],'12 Sim','20 Sim','12 Exp','20 Exp','Location','NorthWest');
            set([hl],'FontName', 'Helvetica','FontSize',9);
            pos=get(hl,'position');
            set(hl,'position',[XPos-0.02 YPos+0.17 pos(3) pos(4)])
            legend('boxoff')
            text(0.47,2.8,'Extreme value fit','FontName', 'Helvetica','FontSize',8);
            end
            
            
            
                       
         end
            
            set(gca,'color','none') 
        
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SR_12_20', 'pdf')

