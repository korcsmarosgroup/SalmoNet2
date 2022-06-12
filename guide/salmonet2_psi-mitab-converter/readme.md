# SalmoNet 2.0 PSI-Mitab Converter script


**Description:**

This script takes a TSV or CSV file, which contains protein-protein
interactions and converts it to PSI-MITAB 2.7 file format.

The script will delete duplicates!

It does not matter whether the input file has header or not!

IMPORTANT: In this script the numbering of the columns starts with 0!

IMPORTANT: The script can handle only with a tab separated input file!


**Parameters:**

-i, --input-file <path>          : path to an existing tab separated file [mandatory]

-hea, --header <boolen>          : if this parameter is given, then the input file has a header, default: NULL [optional]

-t, --tax-id <int>               : taxonomy identifier of interactor A and interactor B [mandatory]

-nc, --needed-columns <list>     : comma separated list of column numbers, which columns does the user want
                                   to integrate to the output mitab file [mandatory]

-mc, --mitab-columns <list>      : comma separated list of column numbers, in which column of the mitab file
                                   does the user want to keep the informations [mandatory]

-o, --output-file <path>         : path to an output mitab file [mandatory]


**Exit codes**

Exit code 1: The specified input file does not exists!
Exit code 2: The number of the needed_columns parameter and the number of the mitab_columns parameter must be equal!
Exit code 3: The input file is not a tab separated file!


**Example:**

Input example file (example_files/text.txt)
```
PROT1	PROT2	RANK_MAJOR	RANK_MINOR	TYPE	PDB_ID	BIO_UNIT	CHAIN1	MODEL1	SEQ_IDENT1	COVERAGE1	SEQ_BEGIN1	SEQ_END1	DOMAIN1	CHAIN2	MODEL2	SEQ_IDENT2	COVERAGE2	SEQ_BEGIN2	SEQ_END2	DOMAIN2	FILENAME
A0A0A6YVN8	A0A0A6YVN8	1	0	Structure	4q7i	2	A	0	100.0	100.0	1	298	-	A	1	100.0	100.0	1	298	-	A0A0A6YVN8-A0A0A6YVN8-EXP-4q7i.pdb2-A-0-A-1.pdb
A0A0A6YVN8	A0A0A6YVN8	2	0	Structure	4q7i	1	B	0	100.0	97.3	1	290	-	A	0	100.0	100.0	1	298	-	A0A0A6YVN8-A0A0A6YVN8-EXP-4q7i.pdb1-B-0-A-0.pdb
A0A0A6YVN8	A0A0A6YVN8	3	0	Structure	4q7i	2	B	0	100.0	97.3	1	290	-	A	0	100.0	100.0	1	298	-	A0A0A6YVN8-A0A0A6YVN8-EXP-4q7i.pdb2-B-0-A-0.pdb
A0A0A6YVN8	A0A0A6YVN8	4	0	Structure	4q7i	2	B	1	100.0	97.3	1	290	-	A	1	100.0	100.0	1	298	-	A0A0A6YVN8-A0A0A6YVN8-EXP-4q7i.pdb2-B-1-A-1.pdb
O32583	P30138	1	0	Structure	1zud	1	4	0	100.0	100.0	1	66	-	3	0	98.0	97.6	1	245	-	O32583-P30138-EXP-1zud.pdb1-4-0-3-0.pdb
O32583	P30138	2	0	Structure	1zud	2	4	0	100.0	100.0	1	66	-	3	0	98.0	97.6	1	245	-	O32583-P30138-EXP-1zud.pdb2-4-0-3-0.pdb
O32583	P30138	3	0	Structure	1zud	1	2	0	100.0	98.5	2	66	-	1	0	95.5	97.6	1	245	-	O32583-P30138-EXP-1zud.pdb1-2-0-1-0.pdb
O32583	P30138	4	0	Structure	1zud	3	2	0	100.0	98.5	2	66	-	1	0	95.5	97.6	1	245	-	O32583-P30138-EXP-1zud.pdb3-2-0-1-0.pdb
```

Terminal command:
`python3 salmonet2_psi_mitab_converter.py -i example_files/test.txt -o example_files/output.mitab -hea -t 83333 -nc 0,1 -mc 0,1`

The output will be: (example_files/output.mitab)
```
A0A0A6YVN8	A0A0A6YVN8	-	-	-	-	-	-	-	taxid:83333	taxid:83333	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-
O32583	P30138	-	-	-	-	-	-	-	taxid:83333	taxid:83333	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-	-
```

In that example, we would like to put only the first two columns (-nc 0,1) from
the input file into the first two columns (-mc 0,1) of the output mitab file!
Because the script delete duplicates, the output file has only 2 interactions!
