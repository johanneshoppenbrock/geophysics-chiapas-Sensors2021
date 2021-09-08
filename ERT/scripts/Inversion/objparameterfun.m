function res = objparameterfun(m,s,roa,ary)
    
    lr = (length(m)+1)/2;
    r = m(1:lr);
    t = m((lr+1):end);
    
    roa1 = roa*0;
    for i = 1:length(s)
        roa1(i,:) = VES1dmod(r,t,s(i),ary);
    end
    e1 = log(roa)-log(roa1);
%     res = sum(abs(e1));
% %     e1 = roa-roa1;
    res = e1'*e1;