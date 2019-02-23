clear
a1=load('./GM12878/GM_SR.dat');
a2=load('./HMEC/GM_SR.dat');
a3=load('./HUVEC/GM_SR.dat');
a4=load('./IMR90/GM_SR.dat');
a5=load('./NHEK/GM_SR.dat');


name={'HMEC','HUVEC','IMR90','NHEK','GM12878'};
x={a2,a3,a4,a5,a1};
%x={a1,a4};


Ch19=load('Kreth_chr19');
Ch18=load('Kreth_chr18');
Ch12=load('Kreth_chr12');
Ch20=load('Kreth_chr20');



figure

XL=0.05;XR=0.01;XGap=0.02;Row=4;
YT=0.05;YB=0.07;YGap=0.01;Col=6;
Width=(1-XL-XR-((Col-1)*XGap))/Col;
Height=(1-YT-YB-((Row-1)*YGap))/Row;
YPos=1-YT-Height; 
COLOR=['g','k','c','r','b','g','c'];
LINETYPE={'-','-','-','-','-'};
LW=[0.5,0.5,0.5,0.5,0.5];
Msize=[4,4,4,4,4];
%symbolType={'.','.','.','.','.'};
symbolType={'','','','',''};

set(gcf, 'PaperSize', [30 20]);
set(gcf, 'PaperPosition', [0 0 30 20]);
for i=1:Row
    XPos=XL;
    for j=1:Col
        chro=j+(i-1)*Col;
        marray=[XPos,YPos,Width,Height];
        %array=get(gca,'position')
        if chro<=24
            subplot('Position',marray);
            for plz=1:length(x);
                y=x{plz};
               
                 color=strcat(COLOR(plz),symbolType{plz},LINETYPE{plz});
                if chro<23
                 z1=mean([y(:,chro+2),y(:,chro+25)],2);    
                legendarray(plz)=plot(y(:,2),z1,color,'LineWidth',LW(plz));
                  maxy(plz)=max(z1);
                elseif chro==23
                p1=plot(y(:,2),y(:,25),color,'LineWidth',LW(plz)); 
                ymax1=max(y(:,25));ymax2=max(y(:,48));
                maxy(plz)=max([ymax1,ymax2]);
                else
                %color=strcat(COLOR(plz),'--');
                p2=plot(y(:,2),y(:,48),color,'MarkerSize', 3);
               
                hold on 
                end

                
                hold on 
            end
            
             
                if chro==12
                 p5=plot(Ch12(:,1)./98,Ch12(:,2),'mo');
                end
                if chro==20
                 p5=plot(Ch20(:,1)./98,Ch20(:,2),'mo');
                end 
                
                if chro==18                
                 p5=plot(Ch18(:,1)./98,Ch18(:,2),'mo');
                end 
                
                if chro==19
                p5=plot(Ch19(:,1)./98,Ch19(:,2),'mo');
                end             
            
            
            
            set(gca,'FontSize',14)
           
            ytickmy=round(max(maxy)/2);
            %set(gca,'YTick',1:ytickmy:2*ytickmy)
            set(gca,'YTick',[1,3])
            
            if chro<23
            %ht=text(0.01,max(maxy)-0.2,strcat('',int2str(chro)));
            ht=text(0.05,3.2,strcat('',int2str(chro)));
            elseif chro==23
            ht=text(0.05,3.2,strcat('Xa'));    
            else
                ht=text(0.05,3.2,strcat('Xi'));  
            end
      
            axis([0,1.08,0,3.7])
            
            
            set([ht],'FontName','Helvetica','FontSize',21);   
            set(gca,'ticklength',3*get(gca,'ticklength'))   
            set(gca,'FontSize',18)   
            set(gca, 'FontName', 'Helvetica')  
            
            
            if (j==1)
                ;
            else
                set(gca,'Yticklabel',[]);
            end
            
                
            if (j==1)
                hy=ylabel('S(R)');
                set([hy],'FontName','Helvetica','FontSize',21);
            end
            if (chro>18)
                hx=xlabel('R');
                set([hx],'FontName','Helvetica','FontSize',21);
            else
                set(gca,'XTicklabel',[]);
            end
            
%             if chro==23
%                  kl=legend([p1,p2],'Xa','Xi','Location','NorthWest');
%                  legend('boxoff')
%                  set([kl],'FontName','Helvetica','FontSize',21);
%             end
            
       
            
            if chro==1
            hl=legend(legendarray,name,'Location','NorthWest','Orientation','horizontal');
            set([hl],'FontName','Helvetica','FontSize',20);            
             pos=get(hl,'position');
            set(hl,'position',[-0.10 0.93 pos(3:4)])%    
            legend('boxoff')
            end
            
%              %textobj=findobj(hobj,'type','text');
            %set(textobj,'Interpreter','latex','fontsize',12);
            %[hleg,hobj]=legend([p1,p2,p3],'GM12878','HUVEC','K562','Location','NorthWest');
        end
          XPos=XPos+Width+XGap;
    end
    YPos=YPos-YGap-Height;
end

saveas(gcf, 'SR', 'pdf')

