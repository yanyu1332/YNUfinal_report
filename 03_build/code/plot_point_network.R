df_of_point <- read.csv("02_raw/data/matrix_of_point.csv",row.names = "point")

df_of_point <- df_of_point %>%
  select(-X)
point <- as.matrix(df_of_point) 

library("igraph")

graph <- graph.adjacency(point, mode = "undirected",diag = FALSE)
plot(graph)
