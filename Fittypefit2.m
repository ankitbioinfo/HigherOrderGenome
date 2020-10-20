clear



% a1=load('./GM12878_CellA-/Expression_chromosome');
% b1=load('./HUVEC_Cell_A-/Expression_chromosome');
% c1=load('./IMR90CellTotalRNA/Expression_chromosome');
% d1=load('./NHEK_cell_A-/Expression_chromosome');
% e1=load('./HMEC_Cell_A-/Expression_chromosome');


a2=load('./GM12878_CellA+/Expression_chromosome');
b2=load('./HUVEC_Cell_A+/Expression_chromosome');
c2=load('./IMR90CellA+/Expression_chromosome');
d2=load('./NHEK_cell_A+/Expression_chromosome');
e2=load('./HMEC_Cell_A+/Expression_chromosome');


%name={'GM12878 A-','HUVEC A-','IMR90 Total', 'NHEK A-', 'HMEC A-', 'GM12878 A+','HUVEC A+','IMR90 A+', 'NHEK A+', 'HMEC A+'};
name={'GM12878','HUVEC','IMR90', 'NHEK', 'HMEC'};
count=ones(1,10);
for i=1:3049
%     if (a1(i,3)~=0)
%         x1(count(1))=log(a1(i,3));
%         count(1)=count(1)+1;
%     end
%     
%      if (b1(i,3)~=0) 
%         x2(count(2))=log(b1(i,3));
%         count(2)=count(2)+1;
%      end
%     
%      if (c1(i,3)~=0)
%         x3(count(3))=log(c1(i,3));
%         count(3)=count(3)+1;
%      end
%     
%       if (d1(i,3)~=0)
%         x4(count(4))=log(d1(i,3));
%         count(4)=count(4)+1;
%       end
%     
%       if (e1(i,3)~=0)
%         x5(count(5))=log(e1(i,3));
%         count(5)=count(5)+1;
%       end
    
      if (a2(i,3)~=0)
        x6(count(6))=log(a2(i,3));
        count(6)=count(6)+1;
      end
    
      if (b2(i,3)~=0)
        x7(count(7))=log(b2(i,3));
        count(7)=count(7)+1;
     end
    
     if (c2(i,3)~=0)
        x8(count(8))=log(c2(i,3));
        count(8)=count(8)+1;
     end
    
      if (d2(i,3)~=0)
        x9(count(9))=log(d2(i,3));
        count(9)=count(9)+1;
      end
    
      if (e2(i,3)~=0) 
        x10(count(10))=log(e2(i,3));
        count(10)=count(10)+1;
      end
      
      
    
        
end

%g = fittype( @(p1,p3,p4,p5,p6, x) (0.5-p1/2)*(1/(p6*sqrt(2*pi)))*exp(-((x-p5).^2)./(2*(p6.^2)))  + (0.5+p1/2)*(1/p4)*exp((x-p3)./p4).*exp(-exp((x-p3)./p4)));
g = fittype( @(p3,p4, x) (1/p4)*exp((x-p3)./p4).*exp(-exp((x-p3)./p4)));
%g1 =  @(p, x) (0.5-p(1)/2)*(1/(p(6)*sqrt(2*pi)))*exp(-((x-p(5)).^2)./(2*(p(6).^2)));
%g2 =  @(p, x) (0.5+p(1)/2)*(1/p(4))*exp((x-p(3))./p(4)).*exp(-exp((x-p(3))./p(4)));
%startingVals=[1,5.5,1.7,4.5,0.3];

% YY={a1(1:3049,3),b1(1:3049,3),c1(1:3049,3),d1(1:3049,3),e1(1:3049,3),a2(1:3049,3),b2(1:3049,3),c2(1:3049,3),d2(1:3049,3),e2(1:3049,3)};
% 
% myvar={x1,x2,x3,x4,x5,x6,x7,x8,x9,x10};


YY={a2(1:3049,3),b2(1:3049,3),c2(1:3049,3),d2(1:3049,3),e2(1:3049,3)};

myvar={x6,x7,x8,x9,x10};


figure
XL=0.09;XR=0.01;XGap=0.01;Row=2;
YT=0.08;YB=0.12;YGap=0.07;Col=3;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 
set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);

for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
%         if chro==111
%             startingVals=[0.6,mean(myvar{chro}),1.7,4.5,0.3];
%         else
%             startingVals=[0.6,mean(myvar{chro}),std(myvar{chro}),mean(myvar{chro}),0.3];
%         end
        
        marray=[XPos,YPos,Width,Height];
        if chro<=5
            
        	subplot('Position',marray);
          Bins= length(min(myvar{chro}):0.6:max(myvar{chro}));    
		[height,xrange]=histnorm(myvar{chro},Bins,'LinesVisible',false);
        [pa,pb]=sort(height,'descend');
        %startingVals=[0.6,mean(myvar{chro}),std(myvar{chro}),4.5,0.3];
        startingVals=[mean(myvar{chro}),std(myvar{chro})];
        bar(xrange,height);
        f = fit(xrange.',height.',g,'StartPoint',startingVals);
        %hold on; plot(f,xrange,height)
%         coefEsts=[f.p1,0,f.p3,f.p4,f.p5,f.p6];
        hold on; plot(xrange,f(xrange),'r-','Linewidth',1.8);
        %line(xrange, g1(coefEsts, xrange), 'Color','b','LineWidth',1.5);
        %line(xrange, g2(coefEsts, xrange), 'Color','k','LineWidth',1.5);
        h = findobj(gca,'Type','Patch');
        set(h,'FaceColor',[1 1 1], 'EdgeColor','b');
        rmse=rms(f(xrange)'-height);
        
        [sa,sb]=sort(log(YY{chro}),'descend');
        p95=sa(152);
        p80=sa(610);
            
       line([p95,p95],[0 0.25],'color','k','LineWidth',1)
       line([p80,p80],[0 0.25],'color','k','LineWidth',1)
            
            
        text(-8,0.20,strcat('\mu=',sprintf('%0.3f',f.p3)));
        text(-8,0.17,strcat('\sigma=',sprintf('%0.3f',f.p4)));
        
        MU(chro)=f.p3; SIGMA(chro)=f.p4;
        
        MAXY(chro)=max(myvar{chro});
        MINY(chro)=min(myvar{chro});
        TOPY(chro)=max(height);
        
        set(gca,'YTick',0:0.1:0.24)
        axis([-9.5,11,0,0.25]);
        
        title(name{chro},'Fontsize',12);
       
        
		if (j==1)
                 ylabel('P(log(expression))','Fontsize',12)
        else
                 set(gca,'YTick',[])
        end
        if (chro>=3)
              	xlabel('log(Expression)','Fontsize',12)
        else
                set(gca,'XTick',[])
        end
        else
            if chro==6
                marray=[XPos,YPos,2*Width,0.08];
                subplot('Position',marray);
                set(gca,'xtick',[]);
                set(gca,'ytick',[]);
            % text('Interpreter','LaTex','string','Blue:$\frac{1-\phi}{2}\frac{1}{\eta\sqrt2\pi}\exp(-\frac{(x-\xi)^2}{2\eta^2})  $',...
           % 'Fontsize',16,'position',[0.01,1.2])
            text('Interpreter','LaTex','string','$\frac{1}{\sigma}\exp(\frac{x-\mu}{\sigma}) \exp(-\exp(\frac{x-\mu}{\sigma}))$',...
            'Fontsize',10,'position',[0.01,0.5])
            end
        end
	XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end
 
 saveas(gcf, 'Fittypefit', 'pdf')
 
figure 
XL=0.09;XR=0.02;XGap=0.01;Row=2;
YT=0.07;YB=0.1;YGap=0.08;Col=3;
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
        if chro<=5
            subplot('Position',marray);
            [sa,sb]=sort(log(YY{chro}));
            p70=round(length(sa)*70/100);
            p75=round(length(sa)*75/100);
            p80=round(length(sa)*80/100);
            p95=round(length(sa)*95/100);
            
               
            plot(sa);
            %line([100,3100],[sa(p70) sa(p70)])
            %line([100,3100],[sa(p75) sa(p75)])
            line([100,3100],[sa(p80) sa(p80)],'color','r')
            line([100,3100],[sa(p95) sa(p95)],'color','r')
             title(name{chro},'Fontsize',12);
             text(500,sa(p95)+1,'5%','Fontsize',12);
             text(500,sa(p80)+0.5,'15%','Fontsize',12);
             text(500,sa(p80)-1,'80%','Fontsize',12);
          
%              text(500,sa(p95)+1,'T=6-12','Fontsize',12);
%              text(500,sa(p80)+0.5,'T=6','Fontsize',12);
%              text(500,2,'T=1','Fontsize',12);
%              
             
             if chro<3
                  set(gca,'xtick',[]);
             end
               
             
             
             if (j==1)
                 ylabel('log(expression)','Fontsize',12)
             else
                 set(gca,'YTick',[]);
             end
             if (chro>=3)
              	xlabel('Monomers','Fontsize',12)
             end
             
              axis([100,3100,-6,9])
        end
        XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end   
            
            
[sa1,sb1]=sort(log(YY{1}),'descend');
[sa2,sb2]=sort(log(YY{2}),'descend');
[sa3,sb3]=sort(log(YY{3}),'descend');
[sa4,sb4]=sort(log(YY{4}),'descend');
[sa5,sb5]=sort(log(YY{5}),'descend');
fid=fopen('sorted5celltype.dat','w');
for i =1:length(sa1)
    fprintf(fid,'%d %f\t%d %f\t%d %f\t%d %f\t%d %f\n',sb1(i),sa1(i),sb2(i),sa2(i),sb3(i),sa3(i),sb4(i),sa4(i),sb5(i),sa5(i));
end
 
saveas(gcf, 'SortedDist', 'pdf')
 
