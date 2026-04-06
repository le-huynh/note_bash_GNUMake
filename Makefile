# Rule
# target : prerequisite1 prerequisite2 prerequisite3
#	(tab)recipe


#.PHONY : all
#all : phony_target1 phony_target2

#.PHONY : phony_target1
#phony_target1 : target1 target2

#.PHONY : phony_target2
#phony_target2 : target3

## Comment 1
#target1 : prereq1.R data0.csv data1.RDS
#  R CMD BATCH --no-save --no-restore prereq1.R prereq1_out.Rout

## Comment 2
#target2 : prereq2.py data2.csv
#  python prereq2.py

# Comment 3
#target3 : prereq3.qmd
#  quarto render prereq3.qmd

#############################################

# keep the intermediate files
.PRECIOUS: gnu_make/processed_cyl_%.csv

# multi-parameter pipeline
CYLS = 4 6 8
all: $(CYLS:%=gnu_make/plot_cyl_%.png)

gnu_make/processed_cyl_%.csv:\
gnu_make/get_wdata.R\
gnu_make/data_mtcars.csv
	Rscript gnu_make/get_wdata.R $*

gnu_make/plot_cyl_%.png:\
gnu_make/plot.R\
gnu_make/processed_cyl_%.csv
	Rscript gnu_make/plot.R $*

