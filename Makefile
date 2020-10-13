.PHONY: clean

clean:
				rm derived_data/*
				
				
derived_data/Defense.csv\
derived_data/Offense.csv: Source-Data/Final.csv\
 tidy_data.R
	Rscript tidy_data.R
 
