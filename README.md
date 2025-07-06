# Materials referred to in Data Accessibility section of our paper entitled "The bioinformatics of the finding that the hepatitis delta virus RNA editing mechanism by a conformational switch exists in genotype 7 in addition to genotype 3"

The archive *__HDVDB.tar__* includes raw data of the 512 HDV strains of various genotypes which appear in HDVdb.
Our research was performed over these strains after preparing them to fit our search methodology as detailed in the paper. 

For convenience, the below installation and execution instructions are also provided in *__README.pdf__* in the repository.

### __PRELIMENARY STEP__

•	The computer used for executing the steps should conform with the system data provided in the file *__os-release.txt__*

•	Extract the archive *__HDVDB.tar__*

•	Place *__ACTAT_PERMS, newpos.sh, newpos.awk, dist.txt, sl1.sh,  sl2.awk__* and the directory *__gx__* at the same location as the untarred *__HDVDB.tar__*

•	The script *__sl1.sh__* uses *__RNAfold__* – verify ViennaRNA is installed on computer and *__RNAfold__* is located at a directory included in the machine’s *__$PATH__*

•	Place *__sorted_candidates_genotypes_3_7_und.xlsx__* and *__candidates_genotypes_1_4.xlsx__*at a location of your convenience on a Windows computer. This spreadsheet is provided for easy reference to the Results section. Please note that motif positions specified therein are *__line positions__* rather than *__genome positions__*. 

At the same Linux location of the files from this step, run:

### __STEP 1__
```bash
./newpos.sh
```
### __STEP 2__
```bash
cat dist.txt | while read L; do ./sl1.sh $L; done > candidates.txt &
```
### __STEP 3__

•	For genotype 3:
```bash
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGCAG" -f sl2.awk 1_xx$id; done < ./gx/g3_44 | sort -nk2
```
•	For genotype 7:
```bash
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGAGG" -f sl2.awk 1_xx$id; done < ./gx/g7_44 | sort -nk2
```
•	For undefined genotype:
```bash
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGCAG" -f sl2.awk 1_xx$id; done < ./gx/gund_44 | sort -nk2
while IFS=$'\t' read -r amber id _ sl1p  _; do awk -v ID="$id" -v AW="$amber" -v SL1P="$sl1p" -v SL2="CCGAGG" -f sl2.awk 1_xx$id; done < ./gx/gund_44 | sort -nk2
```
Note: the provided files g3_44, g7_44 and gund_44 are produced by running the script find_44.sh
