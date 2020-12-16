
clear all 

kalhore=load('Kalhore.dat');

a(1,:,:)=load('./GM12878/Avg_COM_errorbar.dat');

figure
XL=0.12;XR=0.01;XGap=0.03;Row=1;
YT=0.08;YB=0.15;YGap=0.07;Col=1;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 


set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);

%sizes=[250   244   198   192   181   172   160   147   142   136   135-5   134-10   116 ...
%   108   103    91    82    78    60    63    49    52   156];
sizes=[7.86,4.87,5.2,3.77,4.62,5.86,5.37,4.36,5.30,5.27,9.16,7.37,2.65,5.37,5.33,8.67,13.68,3.29,22.53,8.22,4.43,8.15,5.19];

%[dsa,dsb]=sort(density);
[dsa,dsb]=sort(sizes);

Colors={'o','p','*','s','d',    'rh','bo','bp','*','s',   'd','v','^','p','h',   ...
     'ks','kd','kh','mo','mp',          'm*','ms','md','mh'};
 
 Colors={'o','p','*','s','d',    'rh','bo','bp','o','o',   'o','o','o','o','o',   ...
     'ks','kd','kh','mo','mp',          'm*','ms','md','mh'};
 
legend_str={'1','2','3','4','5','6','7','8','9','10','11','12','13',...
           '14','15','16','17','18','19','20','21','22','Xa','Xi'};

       


for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	if chro<7
        marray=[XPos,YPos,Width,Height];
       	hfigure=subplot('Position',marray);
        t=a(chro,:,:);    
        xax=sizes(t(:,1:23,1));
        [t(:,1:23,3)',t(:,24:46,3)'];
        zz=max([t(:,1:23,3)',t(:,24:46,3)']');
	yy=mean([t(:,1:23,2)',t(:,24:46,2)'],2)';
      index=1:23; orderedXaxis=xax(dsb); fillxx=orderedXaxis(index([1:end end:-1:1 1] ));
	    upperbound=yy(dsb)+zz(dsb); lowerbound=yy(dsb)-zz(dsb); 
        fillyy=[upperbound lowerbound(end:-1:1) upperbound(1)];

	    h=fill(fillxx,fillyy,'r','Edgecolor','none','facealpha',0.3);
	    hold on 
    
	h=errorbar(xax,yy,zz,'ro','LineWidth',0.5, 'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',1);hold on   

	 SPEP=setdiff([1:23],[25]);
	 [para_S,sig_S]=chiSquareLeastSquareFit(xax(SPEP),yy(SPEP),zz(SPEP));
	 yfx_S = para_S(1)*xax(SPEP) +para_S(2);
	hp= plot(xax(SPEP), yfx_S, 'r-','linewidth',2,'MarkerFaceColor','m');
             
        chi2=  sum(( (yy(SPEP)-yfx_S)./zz(SPEP) ).^2);
	ndof=length(xax(SPEP))-2;
	Q=(1/gamma(ndof/2))*igamma(ndof/2,chi2/2);
        [ndof, chi2/ndof, Q];     
             
        kalhorestd=  0.5*((kalhore(:,2)-kalhore(:,3)) +  (kalhore(:,4)-kalhore(:,2)))';
        kalhoreY=kalhore(:,2)';
          upperbound=kalhoreY(dsb)+kalhorestd(dsb); lowerbound=kalhoreY(dsb)-kalhorestd(dsb); 
        fillyy=[upperbound lowerbound(end:-1:1) upperbound(1)];

	    k=fill(fillxx,fillyy,'b','Edgecolor','none','facealpha',0.2);
        
        k=errorbar(xax,kalhoreY,kalhorestd,'bo','LineWidth',0.5, 'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',1); 

	 [para_E,sig_E]=chiSquareLeastSquareFit(xax(SPEP),kalhoreY(SPEP),kalhorestd(SPEP));
	 yfx_E=para_E(1)*xax(SPEP) +para_E(2);
	kq= plot(xax(SPEP),yfx_E , 'b-','linewidth',2,'MarkerFaceColor','b');
        
        chi2=  sum(( (kalhoreY(SPEP) -yfx_E)./kalhorestd(SPEP) ).^2);
	ndof=length(xax(SPEP))-2;
	Q=(1/gamma(ndof/2))*igamma(ndof/2,chi2/2);
        [ndof, chi2/ndof, Q] ;  


        %exp_the=std([yy(SPEP);kalhoreY(SPEP)]);
	%exp_the=sum([kalhorestd(SPEP); zz(SPEP)]);
	%exp_the= sqrt(kalhoreY(SPEP));
	%chi2=  sum(( (yfx_S -yfx_E)./exp_the ).^2);
	%chi2=   sum(  ((yy(SPEP)-kalhoreY(SPEP)).^2)./kalhoreY(SPEP))
    chi2=   sum(   (   (yfx_S -yfx_E).^2             )     ./yfx_E   )
	ndof=length(xax(SPEP))-1
	%Q=(1/gamma(ndof/2))*igamma(ndof/2,chi2/2);
	%Q=chi2cdf(chi2,ndof)
        %[ndof, chi2, Q]   
     pvalue= chi2cdf(chi2,ndof)
		text(12,0.75, strcat( '\chi^2=', sprintf('%0.3f',chi2), ', p-value=', sprintf('%0.2e',pvalue)    ));
	



             

	textsymbol=[yy'+zz' yy'-zz' kalhore(:,2) kalhore(:,2)];
        set(gca,'YTick',0.1:0.3:0.9)
        set(gca,'FontSize',16)
        
        axis([2,23,0.08,0.94]);
	 hl=legend([hp,kq], strcat('Sim: (', sprintf('%0.1e',para_S(1)),'\pm',sprintf('%0.1e',sig_S(1)), ')*x + ( ', sprintf('%0.2f',para_S(2)),'\pm',sprintf('%0.2f',sig_S(2)) ,')'  )  ,  ...
strcat('Exp: (', sprintf('%0.1e',para_E(1)),'\pm',sprintf('%0.1e',sig_E(1)), ')*x + ( ', sprintf('%0.2f',para_E(2)),'\pm',sprintf('%0.2f',sig_E(2)) ,')'  ) ,...
             'Location','NorthEast','Orientation','vertical');

        set(hl,'color','none'); set(hl, 'Box', 'on');
        set([hl],'FontName','Helvetica','FontSize',9);
         

	chromosome=[1:5,6,7,8, 14:23];
	for chrmo=chromosome
		    cut=0.25;
		    if dsb(chrmo)>9 
			cut=0.4;
            end
            
            
            if dsb(chrmo)==23
                 name='X';
                 cut=0.25;
            else
                 name=num2str(dsb(chrmo));
                 %name=num2str((chrmo));
            end
            
           
            if (chrmo==2)|(chrmo==5)|(chrmo==7)|(chrmo==20)|(chrmo==18)|(chrmo==16)|(chrmo==15)       
            ht=text(dsa(chrmo)-cut,max(textsymbol(dsb(chrmo),:))+0.03,name,'Fontsize',12,'Color','k');
            else
            ht=text(dsa(chrmo)-cut,min(textsymbol(dsb(chrmo),:))-0.03,name,'Fontsize',12,'Color','k');
            [chrmo,min(textsymbol(dsb(chrmo),:))-0.03];
            end
            
           
               
            
            

%             if mod(chrmo,2)==0
%                 ht=text(sizes(chrmo)-cut,max(textsymbol(chrmo,:))+0.035,num2str(chrmo),'Fontsize',12,'Color','k');
%             elseif chrmo==8
% 		       ht= text(sizes(chrmo)-cut,min(textsymbol(chrmo,:))-0.035,'X','Fontsize',12,'Color','k');
% 	  
%             else
%                 ht= text(sizes(chrmo)-cut,min(textsymbol(chrmo,:))-0.035,num2str(chrmo),'Fontsize',12,'Color','k');
%             end
        end
       % set([ht],'FontName','Helvetica','FontSize',18);
        set(gca, 'FontName', 'Helvetica') 
       
		if (j==1)
                hy=ylabel('Relative radial position');
                set([hy],'FontName','Helvetica','FontSize',16);
        end
        if (i==1)
              	hx=xlabel('Chromosome gene density per Mb');
                set([hx],'FontName','Helvetica','FontSize',16);
        end
        
        
        
        
        
	end
	XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

ht=title('GM12878','fontweight','normal');
PP=get(ht,'Position');
set(ht,'Position',[PP(1) PP(2)-0.01 PP(3)])
set([ht;],'FontName','Helvetica','FontSize',16);
%plot([45,45,55,55,45],[0.5,0.83,0.83,0.5,0.5],'k--','linewidth',1)

% ht=title('\chi^2=0.6983') ;
%  PP=get(ht,'Position');
%  set(ht,'Position',[PP(1) PP(2)-0.03 PP(3)])
%  set([ht],'FontName','Helvetica','FontSize',18);

saveas(gcf, 'Density_Errorbar_GM12878', 'pdf')
