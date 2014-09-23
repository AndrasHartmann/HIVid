function Y = zeronegs(X)
[r, c]=find(X<0);
Y = X;
for i = 1:length(r)
    Y(r(i),c(i)) = 0;
end;
