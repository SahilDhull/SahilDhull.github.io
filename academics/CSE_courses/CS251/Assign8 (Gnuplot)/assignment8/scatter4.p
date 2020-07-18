set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set logscale x 10
set logscale y 10

#set format y "10^{%L}"
set xlabel "Parameters"
set ylabel "Time(Microsecs)"
set yrange[10:70000]
set xrange[1000:1000000]
set ytic auto
set xtic auto


set output "scatter4.eps"
plot 'scatter4.out' using 1:2 notitle with points pt 1 ps 1.5

