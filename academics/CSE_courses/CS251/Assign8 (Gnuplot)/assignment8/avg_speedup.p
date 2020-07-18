#set terminal postscript eps enhanced color size 3.9,2.9
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "bar.eps"

set key font ",22"
set key top right
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Parameters"
set ylabel "Average Speedup"
set yrange[0:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
plot 'err.out' u ($2/$2):xticlabel(1) title "Thread 1:1",\
'' u ($3/$2) title "Thread 1:2" fillstyle pattern 7,\
'' u ($4/$2) title "Thread 1:4" fillstyle pattern 12,\
'' u ($5/$2) title "Thread 1:8" fillstyle pattern 14,\
'' u ($6/$2) title "Thread 1:16" fillstyle pattern 10

