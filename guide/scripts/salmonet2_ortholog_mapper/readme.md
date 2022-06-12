# SalmoNet 2.0 Ortholog Mapper script


**Description:**

This script takes a PSI-Mitab 2.7 file, which contains protein-protein
interactions and mapping the IDs in the first two columns to appropriate
orholog OMA identifiers.

The script maintaining relationships where both interaction partners have
orthologs in E. coli!


**Parameters:**

-i, --input-file <path>          : path to an existing mitab file [mandatory]

-m, --mapping-file <path>        : path to an existing ortholog mapping file [optional]

-of, --ortholog-file <path>      : path to an existing ortholog group file [optional]

-e, --ecoli <boolen>             : if this parameter is given, it means that the input file has information only about
                                   E. coli species, default: NULL [optional]

-o, --output-file <path>         : path to an output mitab file [mandatory]


**Exit codes**

Exit code 1: The specified input file does not exists!
Exit code 2: The specified mapping file does not exists!
Exit code 3: The specified ortholog file does not exists!


**Example:**

Input example file (text.txt)
```
intact:EBI-1124579	intact:EBI-548978	uniprotkb:P16525	uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
intact:EBI-368542	intact:EBI-370825	uniprotkb:P0AA25	uniprotkb:P33940	psi-mi:thio_ecoli|psi-mi:trxA|uniprotkb:P00274|uniprotkb:P76750|uniprotkb:Q2M889|uniprotkb:Q47674|uniprotkb:Q8XAT2|uniprotkb:trxA|uniprotkb:fipA|uniprotkb:tsnC|uniprotkb:b3781|uniprotkb:JW5856	psi-mi:mqo_ecoli|psi-mi:mqo|uniprotkb:O08017|uniprotkb:P76454|uniprotkb:mqo|uniprotkb:yojH|uniprotkb:Malate dehydrogenase [quinone]|uniprotkb:MQO|uniprotkb:b2210|uniprotkb:JW2198	psi-mi:"MI:0676"(tandem affinity purification)	Kumar et al. (2004)	pubmed:15004283	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0914"(association)	psi-mi:"MI:0469"(IntAct)	intact:EBI-371168|intact:EBI-369356	intact-miscore:0.34505215
```

Terminal command:
`python3 salmonet2_ortholog_mapper.py -i example_files/test.txt -e -o example_files/output.mitab`

The output will be: (output.mitab)
```
OMA:SALBC01286	OMA:SALBC03630	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
OMA:SALCH01466	OMA:SALCH04071	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
OMA:SALPA00444	OMA:SALPA03759	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
OMA:SALPA01280	OMA:SALPA03759	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
OMA:SALPS01195	OMA:SALPS03990	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
OMA:SALT101702	OMA:SALT104911	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
OMA:SALT401416	OMA:SALT404252	intact:EBI-1124579|uniprotkb:P16525	intact:EBI-548978|uniprotkb:P0ACB0	psi-mi:tus_ecoli|psi-mi:tus|uniprotkb:Q59400|uniprotkb:tus|uniprotkb:tau|uniprotkb:b1610|uniprotkb:JW1602	psi-mi:dnab_ecoli|psi-mi:dnaB|uniprotkb:P03005|uniprotkb:Q2M6Q2|uniprotkb:dnaB|uniprotkb:groP|uniprotkb:grpA|uniprotkb:b4052|uniprotkb:JW4012	psi-mi:"MI:0096"(pull down)|psi-mi:"MI:0411"(enzyme linked immunosorbent assay)|psi-mi:"MI:0018"(two hybrid)	Mulugu et al. (2001)	pubmed:11493686|mint:MINT-5214363	taxid:83333(ecoli)	taxid:83333(ecoli)	psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0407"(direct interaction)|psi-mi:"MI:0915"(physical association)	psi-mi:"MI:0471"(MINT)	intact:EBI-7917217|intact:EBI-7917253|intact:EBI-7917157	intact-miscore:0.60164154
```

In that example, we know that the input file has ONLY E. coli interactions,
that's why we use the "-e" parameter!
The interactor A has 8 OMA IDs from the mapping file, the interactor B
has 7 OMA IDs. The script only retains the relationships
where the IDs of the interaction partners come from the same strain!
