% Function Jacobian
function A=jacobian(s,r,t,roa,roa1,ary)
    par = 0.1;
    r2 = r;
    for i2 = 1:length(r)
        r2(i2) = r(i2)*(1+par);
        roa2 = VES1dmod (r2,t,s,ary);
        A1(:,i2) = (roa2-roa1)/par./roa;
        r2 = r;
    end
    t2 = t;
    for i3 = 1:length(t)
        t2(i3) = t(i3)*(1+par);
        roa3 = VES1dmod (r,t2,s,ary);
        A2(:,i3) = (roa3-roa1)/par./roa;
        t2 = t;
    end
    A = [A1 A2];