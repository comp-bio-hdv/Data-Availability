Materials referred to in Data Accessibility section of our paper titled "The bioinformatics of the finding that the hepatitis delta virus RNA editing mechanism by a conformational switch exists in genotype 7 in addition to genotype 3".

The archive HDVDB.tar includes raw data of the 512 HDV strains of various genotypes which appear in the HDV database in the Technical University of Munich (HDVdb). Our research was performed over these strains after readying them to fit our search methodology as detailed in the paper (we used the files with 1_ prefix which are one-liners). 

For convenience, the below installation and execution instructions are also provided in README.pdf in the repository.

<u>__PRELIMENARY STEP__</u>

•	The computer used for executing the steps should conform with the system data provided in the file os-release.txt
•	Extract the archive HDVDB.tar
•	Place ACTAT_PERMS, newpos.sh, newpos.awk, dist.txt, sl1.sh,  sl2.awk and the directory gx at the same location as the untarred HDVDB.tar
•	The script sl1.sh uses RNAfold – verify ViennaRNA is installed on computer and edit the path to RNAfold in sl1.sh
•	Place sorted_candidates_genotypes_3_7_und.xlsx at a location of your convenience on a Windows computer. This spreadsheet is provided for easy reference to the Results section.
At the same Linux location of the files from this step, run:

<u>__STEP 1__</u>
./newpos.sh

<u>__STEP 2__</u>
cat dist.txt | while read L; do ./sl1.sh $L; done > candidates.txt &

<u>__STEP 3__</u>
•	For genotype 3:
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGCAG" -f sl2.awk 1_xx$id; done < ./gx/g3_44 | sort -nk10
•	For genotype 7:
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2=" CCGAGG" -f sl2.awk 1_xx$id; done < ./gx/g7_44 | sort -nk10
•	For undefined genotype:
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGCAG" -f sl2.awk 1_xx$id; done < ./gx/gund_44 | sort -nk10
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2=" CCGAGG" -f sl2.awk 1_xx$id; done < ./gx/gund_44 | sort -nk10
