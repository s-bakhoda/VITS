function PlotBestSol(sol,data)

nj=data.nj;

%% 
figure()
Colors=0.5*(hsv(nj)+1);

[~,x]=sort([sol.info.ST']);

for n=x
    
    j=n;
    m=sol.info.MJ(n);
    st=sol.info.ST(n);
    ft=sol.info.FT(n);
    
    h=0.3;
        
    y1=m-h;
    y2=m+h;
        
    X=[st ft ft st];
    Y=[y1 y1 y2 y2];
    
    C=Colors(j,:);
    
    fill(X,Y,C);
    hold on;
    
    xm=(st+ft)/2;
    ym=(y1+y2)/2;
    text(xm,ym,['j' num2str(j)],...
        'FontWeight','bold',...
        'HorizontalAlignment','center',...
        'VerticalAlignment','middle');
    
end

% title(['C_{max} = ' num2str(Cmax) '   Fitness = ' num2str(fit)]);
xlabel('Time')
ylabel('Machine')

hold off;


end




