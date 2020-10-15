.PHONY: clean

clean:
				rm derived_data/*
				

derived_data/OLine.csv\
derived_data/QB.csv\
derived_data/TE.csv\
derived_data/RB.csv\
derived_data/WR.csv\
derived_data/FB.csv\
derived_data/LB.csv\
derived_data/DLine.csv\
derived_data/DB.csv\
derived_data/Defense.csv\
derived_data/Full.DF.csv\
derived_data/Offense.csv: Source-Data/Final.csv\
 tidy_data.R
	Rscript tidy_data.R
 
