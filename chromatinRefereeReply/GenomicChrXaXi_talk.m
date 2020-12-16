

clear all
  csize=[249,243,199,191,182,171,160,146,139,134,136,134,115,107,102,91,84,81,59,65,47,51,157];
% for chro=1:1
%     a=load(strcat('IMR90_ContactPb/spatial/chr',num2str(chro),'contact.txt'));
% 
%     IMRSpatDist{chro} = a(:,1);
%     IMRStdDev{chro} = a(:,2);
%     
%     a=load(strcat('GM12878_ContactPb/spatial/chr',num2str(chro),'contact.txt'));
%     
%     GMSpatDist{chro} = a(:,1);
%     GMStdDev{chro} = a(:,2);
%     
%     
% end


x{1}=load('GM12878_ContactPb/cut2.5/chr1contact_cut1.txt');
x{2}=load('GM12878_ContactPb/cut2.5/chr11contact_cut1.txt');
x{3}=load('GM12878_ContactPb/cut2.5/chr12contact_cut1.txt');
x{4}=load('GM12878_ContactPb/cut2.5/chr19contact_cut1.txt');
x{5}=load('GM12878_ContactPb/cut2.5/chr23contact_cut1.txt');
x{6}=load('GM12878_ContactPb/cut2.5/chr46contact_cut1.txt');

x{7}=load('IMR90_ContactPb/cut2.5/chr1contact_cut1.txt');
x{8}=load('IMR90_ContactPb/cut2.5/chr11contact_cut1.txt');
x{9}=load('IMR90_ContactPb/cut2.5/chr12contact_cut1.txt');
x{10}=load('IMR90_ContactPb/cut2.5/chr19contact_cut1.txt');
x{11}=load('IMR90_ContactPb/cut2.5/chr23contact_cut1.txt');
x{12}=load('IMR90_ContactPb/cut2.5/chr46contact_cut1.txt');


superloop=load('GM_Superloop/cut2.5/chr46contact_cut1.txt');




index=1;
y=superloop;
            for ii=1:length(y)
                if y(ii,1)~=0
                    XS(index)=log10(ii);
                    YS(index)=log10(y(ii,1));
                    ZS(index)=log10(y(ii,2));
                    index=index+1;
                end
            end


 

% 2 = 0.5;  3 = 1.0 ;  4 =1.5; 5 =2 ; 6 = 2.5 ; 7= 3 ; 8 = 3.5 ; 9 = 4.0  

name={'GM12878','IMR90','f','f'};
name={'Chr 1','Chr 11','Chr 12','Chr 19','Chr Xa','Chr Xi'};
g1 =  fittype(@(p1,p2, x) (p1*x.^p2)) ;

%g2 =  @(p, x) (p*x.^0.24) ;


figure
XL=0.06;XR=0.01;XGap=0.01;Row=2;
YT=0.07;YB=0.14;YGap=0.02;Col=6;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 
COLOR=['b','r','k','r','b','y','g'];
LINES=['-','-','-','-','.','.'];
set(gcf, 'PaperSize', [21 8]);
set(gcf, 'PaperPosition', [0 0 21 8]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
       
        if chro<=20
             marray=[XPos,YPos,Width,Height];
             hFig=subplot('Position',marray);
            y=x{chro};
            
            clear X
            clear Y
            clear Z
            index=1;
            %[chro,length(y)]
            for ii=1:length(y)
                if y(ii,1)~=0
                    X(index)=log10(ii);
                    Y(index)=log10(y(ii,1));
                    Z(index)=log10(y(ii,2));
                    index=index+1;
                end
            end

            OF=1; OL=130;
            
            if chro==6
            plot(XS(OF:OL),YS(OF:OL),'b.','linewidth',1,'MarkerFaceColor','b');
            hold on 
            plot(X(OF:OL),Y(OF:OL),'k.','linewidth',1,'MarkerFaceColor','k','markersize',5);
            
            OF=2; OL=15;
            p=polyfit(X(OF:OL),Y(OF:OL),1);
            yfit=polyval(p,X(OF:OL));
            
            plot(X(OF:OL),polyval(p,X(OF:OL)),'k-','linewidth',1,'MarkerFaceColor','k');           
            
            coef1=sprintf('%0.2f',p(1));
            coef2=sprintf('%0.2f',p(2));
            ht=text(0.8,2.3,strcat('Y = ', num2str(coef1) ,'*x +',num2str(coef2)),'Color','k');
            set([ht],'FontName','Helvetica','FontSize',6);
            
            X=XS; Y=YS; 
            else
            plot(X,Y,'b.','linewidth',1,'MarkerFaceColor','b');    
            end
            
            
            hold on 
            h=errorbar(X,Y,Z,'b.','LineWidth',0.25, 'MarkerEdgeColor','b',...
                 'MarkerFaceColor','b',...
                 'MarkerSize',1);
            
            if (chro==6)|(chro==12)
            OF=2; OL=15; 
            else
            OF=1; OL=15; 
            end
                
            p=polyfit(X(OF:OL),Y(OF:OL),1);
            yfit=polyval(p,X(OF:OL));
            
            plot(X(OF:OL),polyval(p,X(OF:OL)),'r-','linewidth',2,'MarkerFaceColor','r');           
            
            coef1=sprintf('%0.2f',p(1));
            coef2=sprintf('%0.2f',p(2));
            ht=text(0.04,2.8,strcat('Y = ', num2str(coef1) ,'*x +',num2str(coef2)),'Color','r');
            set([ht],'FontName','Helvetica','FontSize',10);
            
          
       
            
            %set([ht],'FontName','Helvetica','FontSize',14);
             axis([-0.1 2.1,-0.2, 3.2])
            %set(gca,'yTick',1:1:3);
            set(gca,'xtick',[0,1,2])
            set(gca,'ytick',[1,3])
            if chro<=6
             ht= title(name{chro},'FontWeight','Normal');
             PP=get(ht,'Position');
             set(ht,'Position',[PP(1) PP(2)-0.05 PP(3)]);
             set([ht],'FontName','Helvetica','FontSize',14);
            end
              
           
              if (j==1)
                hy=ylabel('log(P(s))');
                set([hy],'FontName','Helvetica','FontSize',18);
            else
                set(gca,'Yticklabel',[])
            end
            if (chro>6)
                hx=xlabel('log(s)');
                %ht=text(0,0.2,'Xi'); set([ht],'FontName','Helvetica','FontSize',12);
                xh=get(gca,'xlabel');p=get(xh,'position');set(xh,'position',[p(1) 0.99*p(2)])
                set([hx],'FontName','Helvetica','FontSize',18);
            else
                set(gca,'XTicklabel',[]);
                %ht=text(0,0.2,'Xa');  set([ht],'FontName','Helvetica','FontSize',12);
            end
           
          
       
         
           
        end
               
          
             set(gca,'FontSize',14)
            set(gca,'ticklength',2*get(gca,'ticklength'));
                
            set(gca,'color','none')

        XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end


%set(gcf, 'renderer', 'painters');
%saveas(gcf,'GenomicDistance_Left8p_15p_','pdf')
%print('-dpsc2','temp','-loose')
%system('ps2pdf temp.ps temp.pdf')
print(gcf,'GenomicDistance_talk','-dpdf')

%print(gcf, '-dpdf', 'my-figure.pdf');
%print(gcf, '-dpng', 'my-figure.png');
%print(gcf, '-depsc2', 'my-figure.eps');






