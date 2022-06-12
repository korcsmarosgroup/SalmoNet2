# PERMANOVA analysis of dendrograms for SalmoNet2
# Author: Marton Olbei
# The script reads the newick tree files of the indivdual information layers, and runs permanova on  them using adonis2 from the  vegan package.
# For any questions please contat me at m.olbei at imperial.ac.uk

# install packages
library(tidyverse)
library(ggtree)
library(ape)
library(vegan)

strains<-c('SALTI','SALPA','SALPK','SALCH','SALPC','SALDC','SALEP','SALG2','SALPB','SALNS','SALHS','SALTY','SALT1','SALTD',
           'SALT4','SALTS','SALAR','SALBC','SALSV','SALA4')
pathovar<-c('EI','EI','EI','EI','EI','EI','GI','EI','EI','GI','GI','GI','GI','GI','GI','GI','GI','GI','GI','GI')

metaPathovar<-cbind(strains,pathovar) %>% as.data.frame() %>% column_to_rownames('strains')


reg<-read.tree('reg.nwk')
met<-read.tree('met.nwk')
ppi<-read.tree('ppi.nwk')
snp<-read.tree('core_snp.nwk')

regMatrix<-cophenetic.phylo(reg)
metMatrix<-cophenetic.phylo(met)
ppiMatrix<-cophenetic.phylo(ppi)
snpMatrix<-cophenetic.phylo(snp)

#Permutation test for adonis under reduced model
#Terms added sequentially (first to last)
#Permutation: free
#Number of permutations: 999
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

adonis2(regMatrix ~ pathovar,
                    data = metaPathovar, permutations=10000, method = "bray")
#Df SumOfSqs      R2      F Pr(>F)  
#pathovar  1   0.1382 0.11061 2.2385  0.014 *
#  Residual 18   1.1113 0.88939                
#Total    19   1.2494 1.00000 

adonis2(metMatrix ~ pathovar,
        data = metaPathovar, permutations=10000, method = "bray")

#Df SumOfSqs      R2      F Pr(>F)   
#pathovar  1  0.87875 0.32658 8.7294  0.002 **
#  Residual 18  1.81197 0.67342                 
#Total    19  2.69072 1.00000    

adonis2(ppiMatrix ~ pathovar,
        data = metaPathovar, permutations=10000, method = "bray")

#Df SumOfSqs      R2      F Pr(>F)  
#pathovar  1  0.06137 0.09813 1.9584  0.075 .
#Residual 18  0.56408 0.90187                
#Total    19  0.62545 1.00000  

adonis2(snpMatrix ~ pathovar,
        data = metaPathovar, permutations=10000, method = "bray")
#Df SumOfSqs      R2      F Pr(>F)
#Residual 18   3.4918 0.96578              
##pathovar  1   0.1237 0.03422 0.6378  0.939
#Total    19   3.6155 1.00000 

