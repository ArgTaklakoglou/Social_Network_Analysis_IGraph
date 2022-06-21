#install the library I need to create the graphs.
install.packages("igraph")

#Task 1

#load the library igraph which is necessary for the assignment
library(igraph)

#load the data
data <- "https://raw.githubusercontent.com/mathbeveridge/asoiaf/master/data/asoiaf-all-edges.csv"

data <- read.csv(data)

#or else
#data <- read.csv("C:\\Users\\Lenovo\\OneDrive\\Υπολογιστής\\BSc_BusinessAnalytics\\Social Network Analysis\\project 1\\asoiaf-all-edges.csv")
#View(data)

#remove the columns id and Type because they are useless.
data$id <- NULL
data$Type <- NULL

#Create an undirected weighted graph.
graph <- graph_from_data_frame(data, directed=FALSE)

#plot the undirected graph I created.
plot(graph)

#Task 2

#Investigate the graph properties.
is_directed(graph)
is_igraph(graph)
is_named(graph)
is_connected(graph)
is_simple(graph)
is_hierarchical(graph)
is_dag(graph)
is_bipartite(graph)

#check that the graph is weighted.(that has automatically used the weight column as weight for the graph)
is_weighted(graph)

#plot the graph
plot(graph)

#count the nodes in the graph
gorder(graph)

#count the edges in the graph
gsize(graph)

#find the diameter of the weighted graph!The diameter in weighted graphs are the path with the max weight.
diameter(graph)

#count all the triangles:
count_triangles(graph)

sum(count_triangles(graph))
#sum(count_triangles(graph, vids = V(graph)))

#count the unique triangles:
length(triangles(graph))/3

#top-10 characters of the network as far as their degree is concerned

#create a dataframe with 2 columns. The first column contains the nodes and the second column contains the degree of each node.
degree_df <- as.data.frame(degree(graph, v = V(graph)))

#add the names-indexes in a new column and reset the indexes
degree_df <- cbind(newColName = rownames(degree_df), degree_df)
rownames(degree_df) <- 1:nrow(degree_df)
View(degree_df)

#change the column names of degree_df dataframe
colnames(degree_df) <- c('Node_Name', 'Degree')

#order the dataframe in descending order based on Degree column.
degree_df <- degree_df[order(degree_df$Degree, decreasing = TRUE),]

#Reset the indexes in ordered dataframe
rownames(degree_df) <- 1:nrow(degree_df)

#return the 10 nodes with the highest degree
head(degree_df, 10)

#create a dataframe contains the top-10 characters of the network as far as their degree is concerned
top10_degree_df <- as.data.frame(head(degree_df, 10))
View(top10_degree_df)


# top-10 characters of the network as far as their weighted degree is concerned
weighted_degree_df <- as.data.frame(strength(graph , vids = V(graph)))

#add the names-indexes in a new column and reset the indexes
weighted_degree_df <- cbind(newColName = rownames(weighted_degree_df), weighted_degree_df)
rownames(weighted_degree_df) <- 1:nrow(weighted_degree_df)
View(weighted_degree_df)

#change the column names of weighted_degree_df dataframe
colnames(weighted_degree_df) <- c('Node_Name', 'Weighted_Degree')

#order the dataframe in descending order based on Degree column.
weighted_degree_df <- weighted_degree_df[order(weighted_degree_df$Weighted_Degree, decreasing = TRUE),]

#Reset the indexes in ordered dataframe
rownames(weighted_degree_df) <- 1:nrow(weighted_degree_df)

#return the 10 nodes with the highest weighted degree
head(weighted_degree_df, 10)

#create a dataframe contains the top-10 characters of the network as far as their weighted degree is concerned
top10_weighted_degree_df <- as.data.frame(head(weighted_degree_df, 10))
View(top10_weighted_degree_df)


#Task3

#The graph with all nodes but with smaller size in order to be visible.
plot(graph, vertex.label=NA,  edge.arrow.width = 0.1, vertex.size = 2.5, vertex.label.dist=3, vertex.label.dist=0.5)


#The graph that contains the nodes with degree > 10.
LO <- layout_with_fr(graph)
less_than_ten_degree <- which(degree(graph)<10) #
graph2 <- delete.vertices(graph, less_than_ten_degree)
LO2 = LO[-less_than_ten_degree,]
plot(graph2, layout=LO2)

plot(graph2, layout=LO2, vertex.label=NA,  edge.arrow.width = 0.1, vertex.size = 4.5, vertex.label.dist=3, vertex.label.dist=0.5)

#calculate the density for the graph that contains all the nodes
edge_density(graph)

#calculate the density for the graph that contains only the nodes with degree > 10
edge_density(graph2)

#Task4

#return the closeness centrality for each node of the network
closeness(graph)

#return the betweenness centrality for each node of the network
betweenness(graph)

#The top-15 nodes according to the closeness centrality

closeness_df <- as.data.frame(closeness(graph)) #add the closeness centrlity for each node in a dataframe

closeness_df <- cbind(newColName = rownames(closeness_df), closeness_df) #add a column with the indexes because the indexes now are the names-labels of the nodes
rownames(closeness_df) <- 1:nrow(closeness_df) #reset the indexes
View(closeness_df)

betweenness_df <- as.data.frame(betweenness(graph)) #add the betweenness centrlity for each node in a dataframe

betweenness_df <- cbind(newColName = rownames(betweenness_df), betweenness_df) #add a column with the indexes because the indexes now are the names-labels of the nodes
rownames(betweenness_df) <- 1:nrow(betweenness_df) #reset the indexes
View(betweenness_df)

View(closeness_df)


colnames(betweenness_df) <- c('Names', 'Betweenness_score') #change the name of each column
colnames(closeness_df) <- c('Names', 'Closeness_score') #change the name of each column


betweenness_df <- betweenness_df[order(betweenness_df$Betweenness_score, decreasing = TRUE),] #order by Betweenness_score the dataframe descending order
rownames(betweenness_df) <- 1:nrow(betweenness_df) #reset the indexes
View(betweenness_df)


closeness_df <- closeness_df[order(closeness_df$Closeness_score, decreasing = TRUE),] #order by Closeness_score the dataframe in descending order
rownames(closeness_df) <- 1:nrow(closeness_df) #reset the indexes
View(closeness_df)

#create a dataframe contains the top-15 nodes according to the betweenness centrality
top15_betweenness_df <- as.data.frame(head(betweenness_df, 15))
View(top15_betweenness_df)

#create a dataframe contains the top-15 nodes according to the closeness centrality
top15_closeness_df <- as.data.frame(head(closeness_df, 15))
View(top15_closeness_df)

#return the index number of the row that contain Jon-Snow in both dataframes
which(closeness_df == 'Jon-Snow')
which(betweenness_df$Names == 'Jon-Snow')


#Task5
#calculate the page_rank of the graph
page_rank <- page_rank(graph)

#observe the page_rank$vector because we will use it in the plot
page_rank$vector

#plot the graph having as vertex.size the page_rank$vector * 450 (the size of each node will be equal to its page_rank$vector value * 450)
plot(graph, vertex.label=NA,  edge.arrow.width = 0.1, vertex.size = page_rank$vector * 450, vertex.label.dist=3, vertex.label.dist=0.5)

