# Network Analysis and Visualization with R and igraph

The aim is to create an igraph graph1 using the network of the characters
of ’A Song of Ice and Fire’ by George R. R. Martin [1]. A .csv file. After having create the graph explore its basic properties. Then I try to make a more aesthetically pleasing result when plotting the graph and make sub-graph by discarding all vertices that have less than 10 connections in the network. Then I calculate and print the top-15 nodes according to 1)closeness centrality and to 2) betweenness centrality. Finally  rank the characters of the network with regard to their PageRank value.

The dataset can be found here: https://github.com/mathbeveridge/asoiaf/blob/master/data/asoiaf-all-edges.csv
