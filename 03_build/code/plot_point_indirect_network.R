## --------------------------------------------------
## dataのインポート
point_data_indirect <- read.csv("02_raw/data/point_indirect.csv",header=T)
point_data_indirect <- point_data_indirect %>%
  select(-X)

## --------------------------------------------------
## dataの整形

point_indirect <- point_data_indirect %>%
  filter(exchange != "None")


## --------------------------------------------------
## plot
graph_indirect <- graph_from_data_frame(point_indirect, directed = T)
graph.pr_indirect <- page.rank(graph_indirect, directed=TRUE)
png("03_build/output/graph_of_indirect_network.png",pointsize = 80,width = 10000, height = 10000)
plot(
  graph_indirect,
  vertex.size = graph.pr_indirect$vector*60, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.color = "gray80",
  vertex.frame.color = "white",
  vertex.label=V(graph_indirect)$name,#ノード属性nameをノードラベルにする。
  vertex.label.color = "black",
  vertex.label.cex=0.8,
  edge.width = 3,
  edge.arrow.size = 0.3,
)
dev.off()
graph_summary(graph_indirect)

## plot 現金の影響を除外
graph.pr_indirect$vector["現金"] = 0.00000
png("03_build/output/graph_of_indirect_network_except_money.png",pointsize = 110,width = 10000, height = 10000)
plot(
  graph_indirect,
  vertex.size = graph.pr_indirect$vector*200, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.color = "gray80",
  vertex.frame.color = "white",
  vertex.label=V(graph_indirect)$name,#ノード属性nameをノードラベルにする。
  vertex.label.color = "black",
  vertex.label.cex=0.8,
  edge.width = 5,
  edge.arrow.size = 0.3,
)
dev.off() 

graph_summary(graph_indirect)

