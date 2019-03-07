function y=ismagic(m)
s=length(m);
is_equal1=1;
is_equal2=1;
for i=1:s-1
    if sum(m(:,i))~=sum(m(:,i+1))||sum(m(i,:))~=sum(m(i+1,:))||sum(m(i,:))~=sum(m(:,i))
        is_equal1=0;
        break
    end
end
mat_1=[];
mat_2=[];
if is_equal1==1
    for j=1:s
        mat_1=[mat_1,m(j,j)];
        mat_2=[mat_2,m(s-(j-1),j)];
    end
    if sum(mat_1)~=sum(mat_2)||sum(mat_1)~=sum(m(1,:))
        is_equal2=0;
        break
    end
end

end
if is_equal1==1&&is_equal2==1
    y=1;
else
    y=0;
end

    
        
        
        
        
    
        
