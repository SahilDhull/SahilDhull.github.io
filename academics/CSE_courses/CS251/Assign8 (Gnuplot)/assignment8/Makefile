all: App runtest analyse plot report

OBJS= scatter1.out scatter2.out scatter3.out scatter4.out scatter5.out
App:prog.o thread.o
	gcc -o App prog.o thread.o -lm -lpthread

prog.o:prog.c common.h
	gcc -c prog.c -o prog.o

thread.o:thread_function.c common.h
	gcc -c thread_function.c -o thread.o

runtest:input.py params.txt App
	./input.py >> runtest

analyse:$(OBJS) lineplot.out err.out

scatter1.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

scatter2.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

scatter3.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

scatter4.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

scatter5.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

lineplot.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

err.out:runtest params.txt p1.sh
	./p1.sh runtest params.txt threads.txt

plot:scatter1.eps scatter2.eps scatter3.eps scatter4.eps scatter5.eps line.eps bar.eps err.eps

scatter1.eps:scatter1.p scatter1.out
	gnuplot scatter1.p

scatter2.eps:scatter2.p scatter2.out
	gnuplot scatter2.p

scatter3.eps:scatter3.p scatter3.out
	gnuplot scatter3.p

scatter4.eps:scatter4.p scatter4.out
	gnuplot scatter4.p

scatter5.eps:scatter5.p scatter5.out
	gnuplot scatter5.p

line.eps:lineplot.p lineplot.out
	gnuplot lineplot.p

bar.eps:avg_speedup.p err.out
	gnuplot avg_speedup.p

err.eps:err.p err.out
	gnuplot err.p

report:report.tex scatter1.eps scatter2.eps scatter3.eps scatter4.eps scatter5.eps line.eps bar.eps err.eps
	pdflatex report.tex

clean:
	rm -f *.o *.out *.eps runtest App report.pdf report.aux report.log
