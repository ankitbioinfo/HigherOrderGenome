
clear

oldm=load('AvgHeatMap.dat');

geneOrder=[13,18,4,8,21,5,2,23,3,10,9,15,7,14,6,12,1,22,20,16,11,17,19];
%sizeOrder=[ 1,2,3,4, 5, 6,7, 23, 8, 9, 11, 10,12,13,14,15,16,17,18,20,19,22,21];




asize=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157];
sum(asize)
nsize=cumsum(asize);
csize=[0,nsize];

for i=1:23
    for j=1:23
             abc=         oldm(csize(i)+1     :csize(i+1)     ,csize(j)+1     :csize(j+1)) ;
             newm(i,j)= {abc}  ;         
    end    
    %newm(3043-i+1,:)=mean([oldm(i,1:3043);oldm(i+3043,1+3043:6086)]);
    %newm(i,:)=mean([oldm(i,1:3043);oldm(i+3043,1+3043:6086)]);
end

order=geneOrder;
nsize=cumsum(asize(order));
csize=[0,nsize];
for i=1:23
    labelvalue(i)= (csize(i)+1+csize(i+1))/2;
    for j=1:23 
        % [csize(i:i+1), csize(j:j+1), tt]
        
        mm(csize(i)+1:csize(i+1), csize(j)+1:csize(j+1)) =  newm{order(i),order(j)};
    end
end
 




% set(gcf, 'PaperSize', [16 13.2]);
% set(gcf, 'PaperPosition', [0 0 16 13.2]);
% 
set(gcf, 'PaperSize', [9 7.1]);
set(gcf, 'PaperPosition', [0 0 9 7.1]);

XL=0.07;XR=0.01;XGap=0.02;Row=1;
YT=0.03;YB=0.07;YGap=0.01;Col=1;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
        marray=[XPos,YPos,Width,Height];
        subplot('Position',marray);
        imagesc(mm)
        for i=1:length(asize)
             line([nsize(i),nsize(i)],[1,3043], 'LineWidth',0.01,'Color','k') 
             line([1,3043],[nsize(i),nsize(i)], 'LineWidth',0.01,'Color','k') 
        end
        XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

 set(gca, 'FontName', 'Helvetica') 

 set(gca,'YTick',labelvalue)
 set(gca,'XTick',labelvalue)
% set(gca,'FontSize',18)

% set(gca,'XTickLabel',{'3','5','8','12','16','X'},'FontName','Helvetica','FontSize',21)
% set(gca,'YTickLabel',{'17','12','9','5','3','1'},'FontName','Helvetica','FontSize',21)

 for i=1:23
     if order(i)==23
         ord{i}='X';
     else
     ord{i}=num2str(order(i));
     end
 end

  set(gca,'YTickLabel',ord,'FontName','Helvetica','FontSize',6)
  set(gca,'XTickLabel',ord,'FontName','Helvetica','FontSize',6)
  %xticklabel_rotate(labelvalue,90,ord)
xtickangle(90)


colormap(flipud(colormap));
%colormap(jet(256))
%colormap% gray 
c=colorbar;
%set(h,'fontsize',20*asize(chromosome)/249);
%h = findobj('tag', 'Colorbar');
%pos = get(h, 'position')
%set(h, 'position', [pos(1) pos(2) 0.03 pos(4)])

c.Units='centimeters';
pos=c.Position;
%c.Position=[15 pos(2) 0.03  pos(4)]

saveas(gcf,'HeatMap.pdf')
 print('HeatMap','-dpng','-r300');


