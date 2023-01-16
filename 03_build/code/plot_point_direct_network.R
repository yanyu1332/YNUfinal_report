## --------------------------------------------------
## dataのインポート
point_data_direct <- read.csv("02_raw/data/point_direct.csv",header=T)
point_data_direct <- point_data_direct %>%
  select(-X)

## --------------------------------------------------
## dataの整形

point_direct <- point_data_direct %>%
  filter(exchange != "None")


## --------------------------------------------------
## plot
graph_direct <- graph_from_data_frame(point_direct, directed = T)
graph.pr_direct <- page.rank(graph_direct, directed=TRUE)
png("03_build/output/graph_of_direct_network.png",pointsize = 150,width = 10000, height = 10000)
plot(
  graph_direct,
  vertex.size = graph.pr_direct$vector*50, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.color = "gray80",
  vertex.frame.color = "white",
  vertex.label=V(graph_direct)$name,#ノード属性nameをノードラベルにする。
  vertex.label.color = "black",
  vertex.label.cex=0.8,
  edge.width = 5,
  edge.arrow.size = 0.3,
)
dev.off() 
graph_summary(graph_direct,"direct")


## plot 現金の影響を除外
graph.pr_direct$vector["現金"] = 0.00000
png("03_build/output/graph_of_direct_network_except_money.png",pointsize = 150,width = 10000, height = 10000)
plot(
  graph_direct,
  vertex.size = graph.pr_direct$vector*300, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.color = "gray80",
  vertex.frame.color = "white",
  vertex.label=V(graph_direct)$name,#ノード属性nameをノードラベルにする。
  vertex.label.color = "black",
  vertex.label.cex=0.8,
  edge.width = 5,
  edge.arrow.size = 0.3,
)
dev.off() 

