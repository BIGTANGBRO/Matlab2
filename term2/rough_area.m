N=input('input the number of the matrix:');
M=unifrnd(-1,1,N,1);
S=unifrnd(-1,1,N,1);
L=M.^2+S.^2;
a=(L<1);
area=sum(a)*4/N;
disp(area);