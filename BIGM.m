
clc ;
clear ;
M = -1000;
A = [5 1 -1 0 0 1 0 0 ; 6 5 0 -1 0 0 1 0 ; 1 4 0 0 -1 0 0 1];
b = [10 ; 30 ; 8];
C = [-12 -10 0 0 0 M M M];
A = [A b];
cj = [C 0];
bv = [6 7 8]; 
zj_cj = C(bv)*A - cj; 
A = [zj_cj ; A];
var = {'x1', 'x2', 's1', 's2', 's3', 'a1', 'a2', 'a3', 'sol'};

RUN = true ;
while RUN
     if any(zj_cj(1:end-1) < 0)
         [minVal pivotCol] = min(zj_cj(1:end-1)); 
         ratio = A(2:end , end)./A(2:end ,pivotCol); 

     for i = 1:size(ratio , 1)
         if ratio(i) < 0
             ratio(i) = inf;
         end
     end
     
     [minVal pivotRow] = min(ratio);
     pivotRow = pivotRow+1;
     pivot = A(pivotRow , pivotCol);
     A(pivotRow , : ) = A(pivotRow , :) / pivot;

     for i = 2:size(A,1)
         if(i ~= pivotRow)
             A(i, : ) = A(i , : ) - A(i , pivotCol).*A(pivotRow , :);
         end
     end

     bv(pivotRow-1) = pivotCol; 
     cj;
     zj_cj = C(bv)*A(2:end, :) -cj; 
     A(1 , :) = zj_cj;

     else
         array2table(A, "VariableNames", var)
         fprintf("Optimal Solution ");
         A(1 , end)
         fprintf("Since Minimization");
         -A(1 , end)
         RUN = false ;
     end
end
