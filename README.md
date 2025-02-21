# Materials referred to in Data Accessibility section of our paper titled "The bioinformatics of the finding that the hepatitis delta virus RNA editing mechanism by a conformational switch exists in genotype 7 in addition to genotype 3"

The archive *__HDVDB.tar__* includes raw data of the 512 HDV strains of various genotypes which appear in the HDV database in the Technical University of Munich (HDVdb).
Our research was performed over these strains after readying them to fit our search methodology as detailed in the paper (we used the files with *1_* prefix which are one-liners). 

For convenience, the below installation and execution instructions are also provided in README.pdf in the repository.

__PRELIMENARY STEP__

•	The computer used for executing the steps should conform with the system data provided in the file os-release.txt
•	Extract the archive *__HDVDB.tar__*
•	Place *__ACTAT_PERMS, newpos.sh, newpos.awk, dist.txt, sl1.sh,  sl2.awk__* and the directory gx at the same location as the untarred *__HDVDB.tar__*
•	The script sl1.sh uses *__RNAfold__* – verify ViennaRNA is installed on computer and edit the path to *__RNAfold__* in *__sl1.sh__*
•	Place *__sorted_candidates_genotypes_3_7_und.xlsx__* at a location of your convenience on a Windows computer. This spreadsheet is provided for easy reference to the Results section.

At the same Linux location of the files from this step, run:

__STEP 1__

*./newpos.sh*

__STEP 2__

*cat dist.txt | while read L; do ./sl1.sh $L; done > candidates.txt &*

__STEP 3__

•	For genotype 3:
*while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGCAG" -f sl2.awk 1_xx$id; done < ./gx/g3_44 | sort -nk10*

•	For genotype 7:

*while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2=" CCGAGG" -f sl2.awk 1_xx$id; done < ./gx/g7_44 | sort -nk10*

•	For undefined genotype:

*while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGCAG" -f sl2.awk 1_xx$id; done < ./gx/gund_44 | sort -nk10*
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2=" CCGAGG" -f sl2.awk 1_xx$id; done < ./gx/gund_44 | sort -nk10
