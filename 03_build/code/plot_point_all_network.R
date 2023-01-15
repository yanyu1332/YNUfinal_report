## --------------------------------------------------
## dataのインポート
point_data_raw <- read.csv("02_raw/data/point_all.csv",header=T)
point_data_raw <- point_data_raw %>%
  select(-X)

## --------------------------------------------------
## dataの整形

point <- point_data_raw %>%
  filter(exchange != "None")


## --------------------------------------------------
## plot
graph_all <- graph_from_data_frame(point, directed = T)
graph.pr_all <- page.rank(graph_all, directed=TRUE)
png("03_build/output/graph_of_all_network.png",pointsize = 50,width = 10000, height = 10000)
plot(
  graph_all,
  vertex.size = graph.pr_all$vector*50, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.color = "gray80",
  vertex.frame.color = "white",
  vertex.label=V(graph_all)$name,#ノード属性nameをノードラベルにする。
  vertex.label.color = "black",
  vertex.label.cex=0.8,
  edge.width = 0.1,
  edge.arrow.size = 0.1,
)
dev.off() 