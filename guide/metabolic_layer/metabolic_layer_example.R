# Generating enzyme - enzyme interactions from the STM 1.0 model
# Author: Marton Olbei
# The script takes a .json format metabolic model, and generates gene-gene interactions out of it, as laid out in the SalmoNet publications.
# The script is written in a verbose way on purpose, to make the individual steps easier to follow.
# To generate the metabolic layer for your own strain of interest, replace the JSON file, and run the steps below. 
# The output will be mapped to STM1234 format locustags (S. Typhimurium LT2), you can use the orthology mapper script to 
# format this to your liking further downstream.
# For any questions please contact me at m.olbei at imperial.ac.uk

# install libraries by uncommenting the two lines below
# install.packages('tidyverse')
# install.packages('jsonlite')

library(tidyverse)
library(jsonlite)

# set up your working dir below to help with paths
setwd('')

# reading the json file with the STM1.0 model
df<-read_json('STM_v1_0.json')

# handling metabolites first
pluck(df, 'metabolites' , 1)

# rectangling the tables for easier handling
metabolite<-pluck(df, 'metabolites') |> 
  enframe() |>
  select(value) |> 
  unnest_wider(value) |> 
  select(id, name, charge, compartment)

# doing the same for genes and reactions
genes<-pluck(df, 'genes') |> 
  enframe() |>
  select(value) |> 
  unnest_wider(value)|>
  as.data.frame() |> drop_na() |> 
  unnest_wider(notes) |> 
  unnest_wider(original_bigg_ids) 

reactions<-pluck(df, 'reactions') |> 
  enframe() |>
  select(value) |> 
  unnest_wider(value) |> 
  unnest_wider(notes)

# pick reactions table apart in multiple ways
# 1: count metabolites occurring in multiple reactions

reaction_metabolite_distribution <- reactions |> 
  unnest_longer(metabolites) |> 
  group_by(metabolites_id) |> tally()

# get promiscuous metabolites occurring in more than 10 reactions

banned_metabolites<- reaction_metabolite_distribution |> 
  dplyr::filter(n > 10) |> 
  pull(metabolites_id)

# shape longer by metabolites
react_longer<-reactions |> 
  unnest_longer(metabolites)

reversible<-react_longer |> 
  dplyr::filter(lower_bound == -1000 & upper_bound == 1000) |> 
  dplyr::filter(gene_reaction_rule != '') |> 
  dplyr::select("id","metabolites","metabolites_id" , "gene_reaction_rule") |> 
  dplyr::filter(!metabolites_id %in% banned_metabolites)

irreversible<-react_longer |> 
  dplyr::filter(!lower_bound == -1000 & upper_bound == 1000) |> 
  dplyr::filter(gene_reaction_rule != '') |> 
  dplyr::select("id","metabolites","metabolites_id", "gene_reaction_rule") |> 
  dplyr::filter(!metabolites_id %in% banned_metabolites)

#connect irreversible
source_reactions<-irreversible |> 
  dplyr::filter(metabolites >= 1)

sink_reactions<-irreversible |> 
  dplyr::filter(metabolites <= -1)

# join reactions 
# reaction to reaction 
source_to_sink<- source_reactions |> 
  full_join(sink_reactions, by='metabolites_id', suffix=c('_source','_sink')) |> 
  drop_na(gene_reaction_rule_source) |> drop_na(gene_reaction_rule_sink)

source_to_sink_separated<-separate_rows(source_to_sink,gene_reaction_rule_source, sep=' and ') |> 
  separate_rows(gene_reaction_rule_source, sep=' or ') |> 
  separate_rows(gene_reaction_rule_sink, sep=' and ') |> 
  separate_rows(gene_reaction_rule_sink, sep=' or ') |> unique()

s2s_locustag<- source_to_sink_separated |> left_join(genes, by = c('gene_reaction_rule_source'='id')) |> 
  left_join(genes, by = c('gene_reaction_rule_sink'='id'),suffix=c('_source','_sink'))

s2s_irreversible<-s2s_locustag |> dplyr::select(gene_reaction_rule_source,gene_reaction_rule_sink) |> mutate_all(funs(str_replace(., "\\(", ""))) |> mutate_all(funs(str_replace(., "\\)", ""))) |> unique()

# connect reversible
source_reactions_rev<-reversible |> 
  dplyr::filter(metabolites >= 1)

sink_reactions_rev<-irreversible |> 
  dplyr::filter(metabolites <= -1)

# join reactions 
# reaction to reaction 
source_to_sink_rev<- source_reactions_rev |> 
  full_join(sink_reactions_rev, by='metabolites_id', suffix=c('_source','_sink')) |> 
  drop_na(gene_reaction_rule_source) |> drop_na(gene_reaction_rule_sink)

source_to_sink_separated_rev<-separate_rows(source_to_sink_rev,gene_reaction_rule_source, sep=' and ') |> 
  separate_rows(gene_reaction_rule_source, sep=' or ') |> 
  separate_rows(gene_reaction_rule_sink, sep=' and ') |> 
  separate_rows(gene_reaction_rule_sink, sep=' or ') |> unique()

s2s_locustag_rev<- source_to_sink_separated_rev |> left_join(genes, by = c('gene_reaction_rule_source'='id')) |> 
  left_join(genes, by = c('gene_reaction_rule_sink'='id'),suffix=c('_source','_sink'))

s2s_reversible<-s2s_locustag_rev |> dplyr::select(gene_reaction_rule_source,gene_reaction_rule_sink) |> mutate_all(funs(str_replace(., "\\(", ""))) |> mutate_all(funs(str_replace(., "\\)", ""))) |> unique()

#enzyme-enzyme interactions
EE<- rbind(s2s_reversible, s2s_irreversible)

#adding locustag prefix for ortholog mapping
EE$gene_reaction_rule_source <- paste0('locustag:',EE$gene_reaction_rule_source)
EE$gene_reaction_rule_sink <- paste0('locustag:',EE$gene_reaction_rule_sink)
write_tsv(EE,'enzyme_enzyme_example.tsv')


