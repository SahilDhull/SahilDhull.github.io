#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set xlabel "Parameters"
set ylabel "Time(Microsecs)"
set yrange[10:100000]
set xrange[100:1500000]
set ytic auto
set xtic auto

set key bottom right

set output "lineplot.eps"
plot 'lineplot.out' using 1:($2/100) title "Thread=1" with linespoints, \
     ''  using 1:($3/100) title "Thread=2" with linespoints pt 5 lc 4,\
     ''  using 1:($4/100) title "Thread=4" with linespoints lc 10,\
     ''  using 1:($5/100) title "Thread=8" with linespoints pt 3 lc 6,\
     ''  using 1:($6/100) title "Thread=16" with linespoints pt 2 lc 7
