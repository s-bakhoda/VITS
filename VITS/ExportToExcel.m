function ExportToExcel(sol,data)


nv=data.nv;
nc=data.nc;
veh=sol.info.veh;
Q=NaN(5*nv,2+nc);


for v=1:nv
    
    C=veh(v).C;
    dis=veh(v).dis;
    ucap=veh(v).ucap;
    
    if isempty(C)
        continue
    end
    
   a=[dis ucap C];
   Q(v,1:numel(a))=a; 
    
end


 xlswrite('out.xlsx',Q,1,'e8')
 
end

