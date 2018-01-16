
clear all 



aa=linspace(-22,22,90);


bb=linspace(-22,22,250);
cc=linspace(-22,22,251);
spacing=cc(2)-cc(1);

TV= 4/3*pi*17.2^3;

isovalue=1;

for fil=1:10    
         name=strcat(strcat('singlevol',num2str(fil),'.txt'));
         a(fil,:)=load(name)*(spacing^3)/TV;
end

vol=mean(a,1);
volerr=var(a,1);

V=[mean([vol(1:22);vol(24:45)],1),vol(23),vol(46)];
VE=[mean([volerr(1:22);volerr(24:45)],1),volerr(23),volerr(46)];

dlmwrite('IMRVol.dat', [V',VE'],'\t');




% density=[7.86,4.87,5.2,3.77,4.62,5.86,5.37,4.36,5.30,5.27,9.16,7.37,2.65,5.37,5.33,8.67,13.68,3.29,22.53,8.22,4.43,8.15,5.19,0];
% [dsa,dsb]=sort(density);
% 
% 
% name={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','Xa','Xi'};
% 
% figure
% 
% XL=0.14;XR=0.01;XGap=0.02;Row=1;
% YT=0.03;YB=0.2;YGap=0.02;Col=1;
% Width=(1-XL-XR-((Col-1)*XGap))/Col;
% Height=(1-YT-YB-((Row-1)*YGap))/Row;
% YPos=1-YT-Height; 
% 
% set(gcf, 'PaperSize', [10 5]);
% set(gcf, 'PaperPosition', [0 0 10 5]);
% for i=1:Row
%     XPos=XL;
%     for j=1:Col
%         chro=j+(i-1)*Col;
% 	    marray=[XPos,YPos,Width,Height];
%         subplot('Position',marray);
%         
%          plot(V,'bo','markerfacecolor','b','markersize',5);
%         
%          hx=xlabel('Chromosome');
%          %hy=ylabel('\color{blue}Vol\color{black}/\color{red}SA');
%          hy=ylabel('Fraction of Volume')
%          set([hx],'FontName','Helvetica','FontSize',12);
%          set([hy],'FontName','Helvetica','FontSize',12);
%          set(gca, 'FontName', 'Helvetica','FontSize',8);
%          set(gca,'XTick',1:24)
%          set(gca,'YTick',0:0.02:0.08);
%          set(gca,'XTickLabel',name);
%          %set(gca,'XTickLabel',name(dsb));
%          %xticklabel_rotate();
%              
%          axis([0,25,0,0.07])
% 
%         XPos=XPos+Width+XGap;
%     end
%     YPos=YPos-YGap-Height;
% end
% 
% saveas(gcf,'Vol_isosurface', 'pdf')
% 
%         