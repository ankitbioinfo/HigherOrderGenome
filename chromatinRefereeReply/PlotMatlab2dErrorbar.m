



  name={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','Xa','Xi'};


  a=load('GM12878_CT_Oct31/isooutput1Superloop.dat');
  b=load('IMR_Kamal/isooutput1.dat');
  
  gmtell=a(:,1);
  gmvarell=a(:,2);
  gmtreg=a(:,3);
  gmvarreg=a(:,4);
  
  imrtell=b(:,1);
  imrvarell=b(:,2);
  imrtreg=b(:,3);
  imrvarreg=b(:,4);
  
  
  
  sehgal=load('SehgalData_Ellipticity_Regularity');
sehgal=sehgal(1:end-2,:);


density=[7.86,4.87,5.2,3.77,4.62,5.86,5.37,4.36,5.30,5.27,9.16,7.37,2.65,5.37,5.33,8.67,13.68,3.29,22.53,8.22,4.43,8.15,5.19,0];
[dsa,dsb]=sort(density);
chrselect=[1,11,12,13,15,17,18,19,21,22,23, 24,34,35,36,38,40,41,42,44,45,46];

xcoordinate=[18,22,17,2,13,23,3,24,6,19,9,1];


El=sehgal(:,2);
Er=sehgal(:,3);
figure

XL=0.11;XR=0.01;XGap=0.02;Row=2;
YT=0.03;YB=0.14;YGap=0.03;Col=1;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 

set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	    marray=[XPos,YPos,Width,Height];
        subplot('Position',marray);

        if chro==1   
           
            p0=plot(gmtell(dsb),'bo-','linewidth',1,'MarkerFaceColor','b','MarkerSize',2);
            hold on            
            
           
             index=1:24;
             x=index; upperbound=gmtell(dsb)+gmvarell(dsb);lowerbound=gmtell(dsb)-gmvarell(dsb);
             xx=x(index([1:end end:-1:1 1] ));
             yy=[upperbound' lowerbound(end:-1:1)' upperbound(1)];
             h1=fill(xx,yy,'b','Edgecolor','none','facealpha',0.4);
            
             upperbound=imrtell(dsb)+imrvarell(dsb);lowerbound=imrtell(dsb)-imrvarell(dsb);
             yy=[upperbound' lowerbound(end:-1:1)' upperbound(1)];
             h1=fill(xx,yy,'g','Edgecolor','none','facealpha',0.4);
          
            
%                h=errorbar(1:24,gmtell(dsb),gmvarell(dsb),'bo','LineWidth',1, 'MarkerEdgeColor','b',...
%                  'MarkerFaceColor','b','MarkerSize',1);
%              
              p1=plot(imrtell(dsb),'go-','linewidth',1,'MarkerFaceColor','g','MarkerSize',2);            
%                h=errorbar(1:24,imrtell(dsb),imrvarell(dsb),'go','LineWidth',1, 'MarkerEdgeColor','g',...
%                  'MarkerFaceColor','g','MarkerSize',1);
             
            
             
             
            
             
             
             %  set(gca,'FontName', 'Helvetica','FontSize',10) 
            hy=ylabel('Ellipticity');
            set([hy],'FontName','Helvetica','FontSize',21);
            set(gca,'XTick',1:24)
            
            set(gca,'XTickLabel',[]);
            set(gca,'YTick',0.2:0.2:1)
            axis([0,25,0.45,1.1])
     %        var_bar=std([sehgal(:,2),tellselect],1,2);
           % p3=errorbar(xcoordinate(1),sehgal(1,2),var_bar(1),'b-','LineWidth',1.5);
             
%             p1=errorbar(xcoordinate,sehgal(:,2),var_bar,'b.','LineWidth',2, 'MarkerEdgeColor','b',...
%                  'MarkerFaceColor','b','MarkerSize',10); 
           
            p2=plot(xcoordinate,sehgal(:,2),'ro','linewidth',2,'MarkerFaceColor','r','MarkerSize',5);
            hl=legend([p0,p1,p2],'\color{blue}Sim GM12878','\color{green} Sim IMR90','\color{red} Exp.', 'Location', 'North', 'Orientation', 'horizontal');
             set([hl],'FontName','Helvetica','FontSize',18);
             legend('boxoff')
            pos=get(hl,'position');
            set(hl,'position',[pos(1) pos(2)+0.03 pos(3) pos(4)]); % set(hl,'position',[x0 y0 width height])
           

	    expected=sehgal(:,2); obsgm=gmtell(xcoordinate); obsimr=imrtell(xcoordinate);  ndof=11;
	    chi2gm=   sum(   (   (obsgm -expected ).^2             )     ./expected  );
	    chi2imr=   sum(   (   (obsimr -expected ).^2             )     ./expected  );
            pvaluegm= chi2cdf(chi2gm,ndof); pvalueimr=chi2cdf(chi2imr,ndof);      
            text(7,0.90,strcat( '\chi^2=' , sprintf('%0.3f',chi2gm), ', p-value=',sprintf('%0.1e',pvaluegm)   ),'color','b');
	    text(7,0.55,strcat( '\chi^2=',  sprintf('%0.3f',chi2imr), ', p-value=',sprintf('%0.1e',pvalueimr) ),'color','g');
            
        end
% ax = gca;
% xticks = get(ax,'XTickLabel');
% set(ax,'XTick',1:12,'XTickLabel',name)

        if chro==2
         
           
            p0=plot(gmtreg(dsb),'bo-','linewidth',1,'MarkerFaceColor','b','MarkerSize',2);
            hold on             
            
             index=1:24;
             x=index; upperbound=gmtreg(dsb)+gmvarreg(dsb);lowerbound=gmtreg(dsb)-gmvarreg(dsb);
             xx=x(index([1:end end:-1:1 1] ));
             yy=[upperbound' lowerbound(end:-1:1)' upperbound(1)];
             
             h1=fill(xx,yy,'b','Edgecolor','none','facealpha',0.4);
            
             upperbound=imrtreg(dsb)+imrvarreg(dsb);lowerbound=imrtreg(dsb)-imrvarreg(dsb);
             yy=[upperbound' lowerbound(end:-1:1)' upperbound(1)];
             h1=fill(xx,yy,'g','Edgecolor','none','facealpha',0.4);
            
            
            
%               h=errorbar(1:24,gmtreg(dsb),gmvarreg,'bo','LineWidth',1, 'MarkerEdgeColor','b',...
%                  'MarkerFaceColor','b','MarkerSize',1);
            
            p1=plot(imrtreg(dsb),'go-','linewidth',1,'MarkerFaceColor','g','MarkerSize',2);
            hold on             
%               h=errorbar(1:24,imrtreg(dsb),imrvarreg,'ko','LineWidth',1, 'MarkerEdgeColor','k',...
%                  'MarkerFaceColor','k','MarkerSize',1); 
             
            
         %    set(gca,'FontName', 'Helvetica','FontSize',10) 
             
            hy=ylabel('Regularity');
            hx=xlabel('Chromosome');
            set([hx,hy],'FontName','Helvetica','FontSize',21);
             
            
             set(gca,'YTick',[0.7,0.8,0.9])
             set(gca,'XTick',[1:24])
             set(gca,'XTickLabel',name(dsb));
           %  tickxlabel=get(gca,'XTickLabel');             
            %  set(gca,'XTickLabel',tickxlabel,'FontName', 'Helvetica','fontsize',3);
             
            axis([0,25,0.61,0.92])

            expected=sehgal(:,3); obsgm=gmtreg(xcoordinate); obsimr=imrtreg(xcoordinate);  ndof=11;
	    chi2gm=   sum(   (   (obsgm -expected ).^2             )     ./expected  );
	    chi2imr=   sum(   (   (obsimr -expected ).^2             )     ./expected  );
            pvaluegm= chi2cdf(chi2gm,ndof); pvalueimr=chi2cdf(chi2imr,ndof);      
            text(7,0.88,strcat( '\chi^2=' , sprintf('%0.3f',chi2gm), ', p-value=',sprintf('%0.1e',pvaluegm)   ),'color','b');
	    text(7,0.67,strcat( '\chi^2=',  sprintf('%0.3f',chi2imr), ', p-value=',sprintf('%0.1e',pvalueimr) ),'color','g');
            
             p2=plot(xcoordinate,sehgal(:,3),'ro','linewidth',2,'MarkerFaceColor','r','MarkerSize',4);
            %plot([((1:12)-0.2)',((1:12)+0.2)'],var_bar,'linewidth',2);
            %hl=legend([p0,p2],'Sim.','Exp.','Location','NorthWest','Orientation','horizontal');
          %   legend('boxoff')
            
            
        end
        

        % set([hl],'FontName','Palatino','FontSize',14);
      
          set(gca,'color','none')
             set(hl,'color','none')
          %set(gcf,'InvertHardCopy','off');
        
        
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'GMIMRErrorbar_iso2', 'pdf')
% print(gcf, 'GM2dErrorbar_iso2','-dpng','-r600');
% print(gcf,'GM2dErrorbar_iso2','-dsvg');
% print(gcf,'FillPageFigure','-dpdf');
