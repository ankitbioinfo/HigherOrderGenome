
clear all 

kalhore=load('Kalhore.dat');

a(1,:,:)=load('./GM12878/Avg_COM_errorbar.dat');

figure
XL=0.12;XR=0.01;XGap=0.03;Row=1;
YT=0.08;YB=0.15;YGap=0.07;Col=1;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 


%name={ '\chi^2=0.89, Actual loop: 250, T_1=4223,T_6=1550,T_{12}=96,T_{13}=81,T_{14}=61,T_{15}=35,T_{16}=14,T_{17}=16,T_{18}=14,T_{19}=6,T_{20}=2'};

% name={'\chi^2=0.63, #loops=702',...
%       '\chi^2=0.47, #loops=587',... 
%       '\chi^2=0.50, #loops=469',...
%       '\chi^2=0.72, #loops=354',...
%       '\chi^2=0.55, #loops=248',...
%       '\chi^2=0.42, #loops=208'};

set(gcf, 'PaperSize', [15 10]);
set(gcf, 'PaperPosition', [0 0 15 10]);

sizes=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157];
[dsa,dsb]=sort(sizes);

for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
	if chro<7
        marray=[XPos,YPos,Width,Height];
       	subplot('Position',marray);
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
         
        h=errorbar(xax,yy,zz,'ro','LineWidth',0.5, 'MarkerEdgeColor','r',...
                 'MarkerFaceColor','r',...
                 'MarkerSize',1);hold on
             

        SPEP_small=[21,22,19,20,18,17,16,15,14,13,10,12,11];
        SPEP_high=setdiff([1:23],SPEP_small);     
        SPEP_small=setdiff(SPEP_small,[21,22]);
        
        
             
             
        kalhorestd=  0.5*((kalhore(:,2)-kalhore(:,3)) +  (kalhore(:,4)-kalhore(:,2)))';
	kalhoreY=kalhore(:,2)';
          upperbound=kalhoreY(dsb)+kalhorestd(dsb); lowerbound=kalhoreY(dsb)-kalhorestd(dsb); 
        fillyy=[upperbound lowerbound(end:-1:1) upperbound(1)];

	    k=fill(fillxx,fillyy,'b','Edgecolor','none','facealpha',0.2);
        k=errorbar(xax,kalhoreY,kalhorestd,'bo','LineWidth',0.5, 'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',1); 
        
	 [s_para_S,s_sig_S]=chiSquareLeastSquareFit(xax(SPEP_small),yy(SPEP_small),zz(SPEP_small));
	 s_yfx_S=s_para_S(1)*xax(SPEP_small) +s_para_S(2);
	 ss=plot(xax(SPEP_small), s_yfx_S , 'r--','linewidth',2,'MarkerFaceColor','m');


	 [h_para_S,h_sig_S]=chiSquareLeastSquareFit(xax(SPEP_high),yy(SPEP_high),zz(SPEP_high));
	 h_yfx_S=h_para_S(1)*xax(SPEP_high) +h_para_S(2);
	 sh=plot(xax(SPEP_high), h_yfx_S , 'r-','linewidth',2,'MarkerFaceColor','m');

 
        [s_para_E,s_sig_E]=chiSquareLeastSquareFit(xax(SPEP_small),kalhoreY(SPEP_small),kalhorestd(SPEP_small));
	s_yfx_E=s_para_E(1)*xax(SPEP_small) +s_para_E(2);
	es=plot(xax(SPEP_small), s_yfx_E , 'b--','linewidth',2,'MarkerFaceColor','b');
        
	 [h_para_E,h_sig_E]=chiSquareLeastSquareFit(xax(SPEP_high),kalhoreY(SPEP_high),kalhorestd(SPEP_high));
	h_yfx_E=h_para_E(1)*xax(SPEP_high) +h_para_E(2);
	eh=plot(xax(SPEP_high), h_yfx_E , 'b-','linewidth',2,'MarkerFaceColor','b');
        
    


            h_chi2=   sum(   (   (h_yfx_S -h_yfx_E).^2             )     ./h_yfx_E   );
            %chi2=  sum(   (   (yy(SPEP)-kalhoreY(SPEP)).^2  ) ./kalhoreY(SPEP)   )
            h_ndof=length(xax(SPEP_high))-1;
            %Q=(1/gamma(ndof/2))*igamma(ndof/2,chi2/2);

            s_chi2=   sum(   (   (s_yfx_S -s_yfx_E).^2             )     ./s_yfx_E   );
            s_ndof=length(xax(SPEP_small))-1;

            hpvalue= chi2cdf(h_chi2,h_ndof);
            spvalue= chi2cdf(s_chi2,s_ndof);

    
  
             
        textsymbol=[(yy+zz)' (yy-zz)' (kalhoreY-kalhorestd)'  (kalhoreY+kalhorestd)'];
	%textsymbol=[yy+zz' yy-zz' kalhore(:,2)-0.02 kalhore(:,2)+0.02];
        set(gca,'YTick',0.1:0.3:0.9)
        set(gca,'FontSize',16)
      hl=legend([sh,eh,ss,es], ...
strcat('Sim: (', sprintf('%0.1e',h_para_S(1)),'\pm',sprintf('%0.1e',h_sig_S(1)), ')*x + ( ', sprintf('%0.2f',h_para_S(2)),'\pm',sprintf('%0.2f',h_sig_S(2)) ,')'  )  ,  ...
strcat('Exp: (', sprintf('%0.1e',h_para_E(1)),'\pm',sprintf('%0.1e',h_sig_E(1)), ')*x + ( ', sprintf('%0.2f',h_para_E(2)),'\pm',sprintf('%0.2f',h_sig_E(2)) ,')'  ) ,...
strcat('Sim: (', sprintf('%0.1e',s_para_S(1)),'\pm',sprintf('%0.1e',s_sig_S(1)), ')*x + ( ', sprintf('%0.2f',s_para_S(2)),'\pm',sprintf('%0.2f',s_sig_S(2)) ,')'  )  ,  ...
strcat('Exp: (', sprintf('%0.1e',s_para_E(1)),'\pm',sprintf('%0.1e',s_sig_E(1)), ')*x + ( ', sprintf('%0.2f',s_para_E(2)),'\pm',sprintf('%0.2f',s_sig_E(2)) ,')'  ) ,...
           'Location','SouthEast','Orientation','vertical');
   
   text(50,0.92, ...
         strcat( '\chi^2=', sprintf('%0.3f',s_chi2), ', p-value=', sprintf('%0.2e',spvalue),...
                 '\chi^2=', sprintf('%0.3f',h_chi2), ', p-value=', sprintf('%0.2e',hpvalue)   ));


	set(hl,'color','none'); set(hl, 'Box', 'on');
         set([hl],'FontName','Helvetica','FontSize',9);

        for chrmo=1:23
		  cut=2;
		    if chrmo>9 
			cut=5;
		    end

            if mod(chrmo,2)==0
                ht=text(sizes(chrmo)-cut,max(textsymbol(chrmo,:))+0.035,num2str(chrmo),'Fontsize',16,'Color','k');
            elseif chrmo==23
                ht= text(sizes(chrmo)-cut,min(textsymbol(chrmo,:))-0.035,'X','Fontsize',16,'Color','k');
            else
                ht= text(sizes(chrmo)-cut,min(textsymbol(chrmo,:))-0.035,num2str(chrmo),'Fontsize',16,'Color','k');
            end
        end
        set([ht],'FontName','Helvetica','FontSize',16);
        set(gca, 'FontName', 'Helvetica') 
       axis([40,258,0.08,0.96]);
		if (j==1)
                hy=ylabel('Relative radial position');
                set([hy],'FontName','Helvetica','FontSize',16);
        end
        if (i==1)
              	hx=xlabel('Chromosome size (Mb)');
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

saveas(gcf, 'double_size_Errorbar_GM12878', 'pdf')
