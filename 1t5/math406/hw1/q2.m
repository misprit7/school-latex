% display(ksum(3, 2))

forwarddiff(5)

function s = ksum(N, k)
    s = sum((1:N).^k);
end

function t = forwarddiff(k)
    t = zeros(k+3, k+1);
    
    t(:, 1) = arrayfun(@(x) ksum(x, k), 1:k+3);
    
    for j = 2:(k+3)
        for i = 1:(k+3-j+1)
            t(i, j) = t(i+1, j-1) - t(i, j-1);
        end
    end
    t = t';
end
