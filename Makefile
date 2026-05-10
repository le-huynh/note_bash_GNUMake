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
.SECONDARY:

# Files
DATA = gnu_make/data_mtcars.csv
PROC = gnu_make/processed_$(VAR)_$(VALUE).csv
PLOT = gnu_make/plot_$(VAR)_$(VALUE).png

# Wrapper target to generate both processed data and plot
.PHONY : test_target1
test_target1 : $(PROC) $(PLOT)

# Step 1: create processed data
$(PROC):\
gnu_make/get_wdata.R\
$(DATA)
	Rscript gnu_make/get_wdata.R $(VAR) $(VALUE)

# Step 2: create plot
$(PLOT):\
gnu_make/plot.R\
$(PROC)
	Rscript gnu_make/plot.R $(VAR) $(VALUE)

# Remove generated files
clean:
	rm -f gnu_make/processed_*.csv
	rm -f gnu_make/plot_*.png

# run in terminal
# make test_target1 VAR=cyl VALUE=6
# make test_target1 VAR=gear VALUE=5
