## --------------------------------------------------
## dataのインポート
point_data_raw <- read.csv("02_raw/data/dataset_point_network.csv",header=T)
point_data_raw <- point_data_raw %>%
  select(-X)

## --------------------------------------------------
## dataの整形

point <- point_data_raw %>%
  filter(exchange != "None")


## --------------------------------------------------
## plot
graph_edge <- graph_from_data_frame(point, directed = T)
plot(graph_edge)

ba_graph.pr <- page.rank(graph_edge, directed=TRUE)
plot(graph_edge, vertex.size=ba_graph.pr$vector*300, edge.arrow.size=0.2, vertex.color="lightblue", layout=layout.fruchterman.reingold)
