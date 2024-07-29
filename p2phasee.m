
clc; clear all;

a = [1 1 1 0 0 ; 1 3 0 1 0 ; 1 -1 0 0 1];
b = [2 ; 3 ; 1];
c = [3 2 0 0 -1];

c = [0 0 0 0 -1];

bv = [3 4 5];
av = [5];
a = [a b];
cj = [c 0];

zjcj = c(bv)*a - cj;
a = [zjcj ; a];

var = {'x1','x2','s1','s2', 'sol'};

run = true;
while run
    if any(zjcj(1:end-1) < 0)
        [val pivcol] = min(zjcj(1:end-1));

        ratio = a(2:end , end) ./ a(2:end  ,pivcol);
        for i = 1:size(ratio , 1)
            if ratio(i) < 0
                ratio(i) = inf;
            end
        end

        [val pivrow] = min(ratio);
        pivrow = pivrow + 1;
        pivot = a(pivrow , pivcol);
        a(pivrow , : ) = a(pivrow , :) / pivot;

        for i = 2:size(a,1)
            if(i ~= pivrow)
                a(i, :) = a(i , :) - a(i , pivcol) .* a(pivrow , :);
            end
        end

        bv(pivrow-1) = pivcol;
        zjcj = c(bv) * a(2:end, :) - cj;
        a(1 , :) = zjcj;

    else
        disp("Optimal Solution");
        a(1 , end)

        if(any(bv) == av(1))
            disp("Since Minimization , therefore ,");

        else
            c = [3 2 0 0];
            cj = [c 0];

            a(1 , :) = [];
            a(: , av) = [];
            zjcj = c(bv)*a - cj;

            a = [zjcj ; a];

            while run
                if any(zjcj(1:end-1) < 0)
                    [val pivcol] = min(zjcj(1:end-1));
                    ratio = a(2:end , end) ./ a(2:end, pivcol);
                    for i = 1:size(ratio , 1);
                        if ratio(i) < 0
                            ratio(i) = inf;
                        end
                    end
                    [val pivrow] = min(ratio);
                    pivrow = pivrow + 1;
                    pivot = a(pivrow , pivcol);
                    a(pivrow , :) = a(pivrow , :) / pivot;

                    for i = 2:size(a,1)
                        if(i ~= pivrow)
                            a(i, : ) = a(i , : ) - a(i , pivcol) .* a(pivrow , :);
                        end
                    end

                    bv(pivrow-1) = pivcol;
                    zjcj = c(bv)*a(2:end, :) -cj;
                    a(1 , :) = zjcj;

                else
                    array2table(a, "VariableNames", var)
                    disp("Optimal Solution") ;
                    a(1 , end)

                    disp("Since Minimization , therefore ,") ;
                    -a(1 , end)
                    run = false ;
                end
            end
                run = false ;
        end
    end
end
