

 newm=load('AvgHeatMap.dat');
% 
% for i=1:3043
%     newm(i,:)=mean([oldm(i,1:3043);oldm(i+3043,1+3043:6086)]);
% end

loopfile=load('HUVEC_Final_loopList_ceil.dat');


asize=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157];
sum(asize)
nsize=cumsum(asize);

chromosome=1;
if chromosome==1
       startIndex=1;
else
       startIndex=nsize(chromosome-1)+1;
end

clear loops 
index=1;
for i=1:length(loopfile)
    if loopfile(i,1)==chromosome
    loops(index,:)=loopfile(i,2:3);
    index=index+1;
    end
end



XL=0.1;XR=0.33;XGap=0.02;Row=1;
YT=0.17;YB=0.1;YGap=0.01;Col=1;

pSR=(20-XL-XR)*asize(chromosome)/249;
pSC=(16.3-YT-YB)*asize(chromosome)/249;

set(gcf, 'PaperSize', [ pSR+XL+XR pSC+YT+YB]);
set(gcf, 'PaperPosition', [0 0 pSR+XL+XR pSC+YT+YB]);

Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
        marray=[XPos,YPos,Width,Height];
        subplot('Position',marray);
        imagesc(newm (startIndex:nsize(chromosome),startIndex:nsize(chromosome) ));
%         for i=1:length(size)
%              line([nsize(i),nsize(i)],[1,6098], 'LineWidth',0.5,'Color','k') 
%         end
        XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

hold on 

for i=1:length(loops)
     gap(i)=abs(loops(i,1)-loops(i,2))/1.5;
X = [loops(i,1) loops(i,2)];
Y = [asize(chromosome) asize(chromosome)];
Y=[0,0];
% intermediate point (you have to choose your own)
Xi = mean(X);
Yi = mean(Y) - gap(i);

Xa = [X(1) Xi X(2)];
Ya = [Y(1) Yi Y(2)];

t  = 1:numel(Xa);
ts = linspace(min(t),max(t),numel(Xa)*10); % has to be a fine grid
xx = spline(t,Xa,ts);
yy = spline(t,Ya,ts);

outside=plot(xx,yy,'k','linewidth',1);  % curve
%plot(X,Y,'or')        % end points
%plot(Xi,Yi,'xr') 

set(outside,'Clipping','off')

end

%axis([0,asize(chromosome),0,asize(chromosome)+36])

 %set(findobj(gcf, 'type','axes'), 'Visible','off')


for i=1:length(loops)
     gap(i)=abs(loops(i,1)-loops(i,2))/1.5;
Y = [loops(i,1) loops(i,2)];
X = [asize(chromosome) asize(chromosome)];

% intermediate point (you have to choose your own)
Xi = mean(X)+ gap(i);
Yi = mean(Y) ;

Xa = [X(1) Xi X(2)];
Ya = [Y(1) Yi Y(2)];

t  = 1:numel(Xa);
ts = linspace(min(t),max(t),numel(Xa)*100); % has to be a fine grid
xx = spline(t,Xa,ts);
yy = spline(t,Ya,ts);

outside=plot(xx,yy,'k','linewidth',1);  % curve
set(outside,'Clipping','off')

end



set(gca,'xtick',[]);
set(gca,'ytick',[]);

gene=load('HUVEC1.dat');

for i=startIndex:nsize(chromosome)
    if gene(i,2)>6
       outside1=plot(-7,gene(i,1),'ko','markersize',5,'markerfacecolor','k');    
       outside2=plot(gene(i,1),nsize(chromosome)+7,'ko','markersize',5,'markerfacecolor','k');    
    
    
    elseif gene(i,2)==6
       outside1=plot(-7,gene(i,1),'go','markersize',5,'markerfacecolor','g');    
       outside2=plot(gene(i,1),nsize(chromosome)+7,'go','markersize',5,'markerfacecolor','g');    
    end
    
    set(outside1,'Clipping','off');
    set(outside2,'Clipping','off');
end







% set(gca, 'FontName', 'Helvetica','FontSize',12) 

% set(gca,'XTickLabel',{'3','5','8','12','16','X'},'FontName','Palatino','FontSize',21)
% set(gca,'YTickLabel',{'17','12','9','5','3','1'},'FontName','Palatino','FontSize',21)
 
%   set(gca,'XTickLabel',{'1'},'FontName','Palatino','FontSize',21)
%  set(gca,'YTickLabel',{'1'},'FontName','Palatino','FontSize',21)






xlabel(strcat('Chromosome',sprintf(' %d', chromosome)),'FontName','Helvetica','FontSize',20*asize(chromosome)/249);
ylabel(strcat('Chromosome',sprintf(' %d', chromosome)),'FontName','Helvetica','FontSize',20*asize(chromosome)/249);
h = get(gca, 'xlabel');
oldposX = get(h, 'Position');
set(h, 'Position', oldposX + [0, 7, 0]);

h = get(gca, 'ylabel');
oldposY = get(h, 'Position');
set(h, 'Position', oldposY - [15, 0, 0]);




colormap(flipud(colormap))
colormap; %gray 
h=colorbar;
set(h,'fontsize',20*asize(chromosome)/249);
% ax=gca;
% pos=get(gca,'pos')
% hc=colorbar('location','EastOutside','position',[pos(1)+pos(3) pos(2) 0.03 pos(4)]);
% set(hc,'xaxisloc','top');
h = findobj('tag', 'Colorbar');
pos = get(h, 'position')
set(h, 'position', [0.8 pos(2) pos(3) pos(4)])

saveas(gcf,'HeatMapChr1.pdf')

