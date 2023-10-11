
disp('midpoint')
numerical_integration(-1, 1, @(x) 1/(1+x^2)^0.5, 32, 1);
disp('trap')
numerical_integration(-1, 1, @(x) 1/(1+x^2)^0.5, 32, 2);
disp('simpson')
numerical_integration(-1, 1, @(x) 1/(1+x^2)^0.5, 32, 3);
disp('gauss_legendre')
numerical_integration(-1, 1, @(x) 1/(1+x^2)^0.5, 32, 4);
disp('real')
% -2*log(2^0.5-1)

functions = {@(x) 1/(1+x^2)^0.5, @(x) sin(2*x)^2, @(x) x^(4.0/3), @(x) x^(1.0/3), @(x) (-log(x))^0.5};
bounds = [-1,1; 0,pi; 0,1; 0,2; 0,1];
real_ans = [-2*log(2^0.5-1), pi/2, 3.0/7, 3/(2^(2.0/3)), pi^0.5/2];
Ns = [2,4,16,32];
tables = zeros(5,4,5);
for i = 1:length(functions)
    f = functions{i};
    for j = 1:length(Ns)
        N = Ns(j);
        for choice = [1,2,3,4]
            if i ~= 5 || (choice ~= 2 && choice ~= 3)
                tables(i,j,choice) = numerical_integration(bounds(i,1),bounds(i,2),f,N,choice);
            end
        end
        tables(i,j,5) = real_ans(i);
    end
end

for i = 1:5
    disp(array2table(squeeze(tables(i,:,:))))
end


% Calculate the errors
errors = abs(tables - real_ans');

methods = {'Midpoint', 'Trapezium', 'Simpson', 'Gauss-Legendre'};
colors = {'r', 'g', 'b', 'k'};

for func_idx = 1:5
    figure('Name', ['Function ' num2str(func_idx)]); % Creates a new figure for each function
    hold on;
    for choice = 1:4
        loglog(Ns, squeeze(errors(func_idx, :, choice)), '-o', 'Color', colors{choice}, 'DisplayName', methods{choice});
    end
    xlabel('N');
    ylabel('Error');
    title(['Log-Log plot of N vs Error for Function ', num2str(func_idx)]);
    
    % Ensuring that the axes are in log-log scale
    set(gca, 'XScale', 'log', 'YScale', 'log');
    
    legend('Location', 'southwest');
    grid on;
    hold off;
end

% 1. Midpoint rule with N cells
% 2. Trapezium rule with N cells
% 3. Simpson''s rule with 2N cells
% 4. Three-point Gauss-Legendre quadrature with N cells
function result = numerical_integration(a, b, f, N, choice)

    switch choice
        case 1
            result = midpoint_rule(f, a, b, N);
        case 2
            result = trapezium_rule(f, a, b, N);
        case 3
            result = simpsons_rule(f, a, b, N);
        case 4
            result = gauss_legendre(f, a, b, N);
        otherwise
            return;
    end

    % fprintf('The result of the integration is: %.5f\n', result);
end

function result = midpoint_rule(f, a, b, N)
    result = 0;
    for i = 0:(N-1)
        point = a+(i+0.5)*(b-a)/N;
        result = result + f(point);
    end

    result = result * (b-a)/N;
end


function result = trapezium_rule(f, a, b, N)
    result = 0;
    for i = 1:(N-1)
        point = a+i*(b-a)/N;
        result = result + 2*f(point);
    end
    result = result + f(a) + f(b);

    result = result * (b-a)/N/2;
end

function result = simpsons_rule(f, a, b, N)
    result = 0;
    for i = 1:N
        left = a+(i-1)*(b-a)/N;
        right = a+i*(b-a)/N;
        result = result + 1/3*(b-a)/N/2*(f(left)+4*f((left+right)/2)+f(right));
    end
end

function result = gauss_legendre(f, a, b, N)
    x = [-sqrt(3/5), 0, sqrt(3/5)];
    w = [5/9, 8/9, 5/9];

    result = 0;
    for i = 1:N
        left = a + (i-1)*(b-a) / N;
        right = a + i*(b-a)/N;
        for j = 1:3
            xi = 0.5*(left+right + (right-left) * x(j));
            result = result+w(j)*f(xi);
        end
    end
    result = 0.5 * (b-a)/N*result;
end


