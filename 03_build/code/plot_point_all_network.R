## --------------------------------------------------
## dataのインポート
point_data_all <- read.csv("02_raw/data/point_all.csv",header=T)
point_data_all <- point_data_all %>%
  select(-X)

## --------------------------------------------------
## dataの整形

point_all <- point_data_all %>%
  filter(exchange != "None")


## --------------------------------------------------
## plot
graph_all <- graph_from_data_frame(point_all, directed = T)
graph.pr_all <- page.rank(graph_all, directed=TRUE)
png("03_build/output/graph_of_all_network.png",pointsize = 100,width = 10000, height = 10000)
plot(
  graph_all,
  vertex.size = graph.pr_all$vector*50, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.color = "gray80",
  vertex.frame.color = "white",
  vertex.label=V(graph_all)$name,#ノード属性nameをノードラベルにする。
  vertex.label.color = "black",
  vertex.label.cex=0.8,
  edge.width = 0.5,
  edge.arrow.size = 0.1,
)
dev.off() 

graph_summary(graph_all,"all")


