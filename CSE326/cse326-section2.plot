set terminal eepic color
set output "asymptotic.tex"
plot [x=0:10] [0:200] x**2 t "$g(x) = x^2$", x**1.5 t "$h(x) = x^{1.5}$", (sin(x)**2)*x**2 + ((1-sin(x)**2)*x**1.5) t "$f(x) = x^2\sin^2{x} + x^{1.5}(1-\sin^2{x})$", exp(x) t "$j(x) = e^x$", log(x) t "$k(x) = \log{x}$"
