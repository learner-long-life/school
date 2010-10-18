## -*-octave-*-
## Crosstalk noise measurements

# Arguments in each tuple in this order
# 1. The number of address bits a (with 2 data bits)
# 2. The actual number of iterations needed to obtain the maximum
# 3. The calculated number of iterations
# 4. The success probability
lower_iters = [ 1, 1, 2, 2, 4, 5, 7, 10, 14 ];
upper_iters = [ 1, 1, 2, 3, 4, 7, 10, 14, 20 ];
calc_iters =  [ 2, 2, 3, 4, 6, 9, 13, 18, 25];
lower_probs = [ 1.00000,
                1.00000,
                0.94531,
                0.90845,
                0.99918,
                0.96352,
                0.94199,
                0.93518,
                0.91892 ];
upper_probs = [ 1.00000,
                1.00000,
                0.94531,
                0.96132,
                0.99918,
                0.90745,
                0.91944,
                0.94216,
                0.94268 ];
x = [1:9];
z = [1:9];

calc_iter_logs = log2(calc_iters);
upper_iter_logs = log2(upper_iters);
lower_iter_logs = log2(lower_iters);

# Set gnuplot params
#gset format xy "$%g$"
title("Grover Iterations Versus Address Width");
xlabel("Address Width (qubits)");
ylabel("Iterations (log(N))");
axis([ min(x)-1 max(x)*2 min(calc_iter_logs)-1 max(calc_iter_logs)+1], "labelx");

## Linear fit ; no semi-colon verbosity
pp = polyfit(z, calc_iters(1:9), 1)
ply = polyval(pp, calc_iter_logs(1:9));

pp2 = polyfit(z, lower_iters(1:9), 1)
ply2 = polyval(pp2, lower_iter_logs(1:9));

pp3 = polyfit(z, upper_iters(1:9), 1)
ply3 = polyval(pp3, upper_iter_logs(1:9));

hold on;
plot(x, calc_iter_logs, "+;Calculated;",  ...
    x, lower_iter_logs, "o;Lower Bound;", ...
        x, upper_iter_logs, "*;Upper Bound;");

%plot(z, ply, ";Calculated Fit;", z, ply2, "g;Lower Bound Fit;", z, ...
%    ply3, "b;Upper Bound Fit;");


%"Lower Bound ...
%    Fit",

%"Upper Bound", "Upper Bound Fit", 2);

gset output "search-addr.tex"

eepic_plot



