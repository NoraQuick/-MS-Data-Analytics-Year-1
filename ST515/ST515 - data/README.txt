Data sets 
   .Content 
  ALLOY data .
Attached Files:File alloy.txt (262 B) 
..When you create this data frame in R, call it something other than 'alloy', e.g., 'ALLOY'. There is a variable called 'alloy' in the data set, so it will get confusing if you use that same name for the data frame.
.  ALLOY documentation .
Attached Files:File alloydoc.txt (312 B) 
...  ANODE data .
Attached Files:File anode.txt (226 B) 
...  ANODE documentation .
Attached Files:File anodedoc.txt (597 B) 
...  BP0 data .
Attached Files:File bp0.txt (112 B) 
...  BP0 documentation .
Attached Files:File bp0doc.txt (473 B) 
...  BUILD data .
Attached Files:File build.txt (284 B) 
...  BUILD documentation .
Attached Files:File builddoc.txt (466 B) 
...  CEP3 data .
Attached Files:File cep3.txt (3.082 KB) 
...  CEP3 documentation .
Attached Files:File cep3doc.txt (610 B) 
...  CHEM data .
Attached Files:File chem.txt (235 B) 
...  CHEM documentation .
Attached Files:File chemdoc.txt (367 B) 
...  CLASS data .
Attached Files:File class.txt (103 B) 
..The example of a two-stage nested design used in class..  CLASS documentation .
Attached Files:File classdoc.txt (249 B) 
...  CONCRETE data .
Attached Files:File concrete.txt (196 B) 
..The data set used in class and in Kuehl's book to illustrate the two-factor factorial design.  See Kuehl, pp. 180-181, for a description of the experiment.
.  COTTON data .
Attached Files:File cotton.txt (170 B) 
...  COTTON documentation .
Attached Files:File cottondoc.txt (467 B) 
...  CRACKER data .
Attached Files:File cracker.txt (164 B) 
..The example used in the discussion of ANCOVA. In a completely randomized design, 15 stores were assigned three METHODs of promotion of crackers.  The response is the amount of NEW.SALES of crackers, and the covariate is the amount of OLD.SALES in the period preceding the experiment.
.  CRICKET data .
Attached Files:File cricket.txt (741 B) 
...  CRICKET documentation .
Attached Files:File cricketdoc.txt (302 B) 
...  FLUORIDE data .
Attached Files:File fluoride.txt (636 B) 
...  FLUORIDE documentation .
Attached Files:File fluoridedoc.txt (744 B) 
...  GRAVID data .
Attached Files:File gravid.txt (1.011 KB) 
...  GRAVID documentation .
Attached Files:File graviddoc.txt (449 B) 
...  LETTUCE data .
Attached Files:File lettuce.txt (180 B) 
...  LETTUCE documentation .
Attached Files:File lettucedoc.txt (403 B) 
...  MHAULS data .
Attached Files:File mhauls.txt (218 B) 
...  MHAULS documentation .
Attached Files:File mhaulsdoc.txt (478 B) 
...  ORANGE data .
Attached Files:File orange.txt (447 B) 
...  ORANGE documentation .
Attached Files:File orangedoc.txt (459 B) 
...  PHYTO data .
Attached Files:File phyto.txt (519 B) 
...  PHYTO documentation .
Attached Files:File phytodoc.txt (366 B) 
...  PLANT data .
Attached Files:File plant.txt (1.513 KB) 
...  PLANT documentation .
Attached Files:File plantdoc.txt (964 B) 
...  RESGPA data .
Attached Files:File resgpa.txt (727 B) 
...  RESGPA documentation .
Attached Files:File resgpadoc.txt (472 B) 
...  UNBAL2 data .
Attached Files:File unbal2.txt (48 B) 
..The small 'toy' data set I used to illustrate some issues with unbalanced data in two-way ANOVA.  The response is Y, and the two explanatory variables are A and B.  To get the balanced data set referred to in lecture, use bal2 <- rbind(unbal2, data.frame(y=0, A=1, B=2)) .
.  WHEAT data .
Attached Files:File wheat.txt (282 B) 
..The RCB example used by Kuehl, and described on pp. 264-265. NITRO is the nitrogen concentration of the wheat, and FERT is the fertilization method, applied in four BLOCKs.


.  WHEAT2 data .
Attached Files:File wheat2.txt (323 B) 
..The Latin square example from Kuehl, p. 283.  The response is grain yield;  the explanatory variable of interest is seeding rate (treat);  and row and column are blocking factors.


