## --------------------------------------------------
## dataのインポート
point_data_raw <- read.csv("02_raw/data/point_2nd.csv",header=T)
point_data_raw <- point_data_raw %>%
  select(-X)

## --------------------------------------------------
## dataの整形

point <- point_data_raw %>%
  filter(exchange != "None")


## --------------------------------------------------
## plot
graph <- graph_from_data_frame(point, directed = T)
plot(
  graph,
  vertex.size = 5, #ノードの大きさ
  vertex.shape="circle", #ノードの形
  vertex.label=V(graph)$name, #ノード属性nameをノードラベルにする。
  vertex.label.cex=0.5
     )

# ba_graph.pr <- page.rank(graph, directed=TRUE)
# plot(graph, vertex.size=ba_graph.pr$vector*300, edge.arrow.size=0.2, vertex.color="lightblue", layout=layout.fruchterman.reingold)

# > plot(g,
#        + vertex.size=15, #ノードの大きさ
#        + vertex.shape="rectangle", #ノードの形
#        + vertex.label=V(g)$name, #ノード属性nameをノードラベルにする。
#        #ノード属性Factionを用いてノードに色づけ
#        + vertex.color=ifelse(V(g)$Faction==1,"Pink","Lightgreen"),
#        + vertex.label.color="gray50", #ノードのラベルの色
#        #ノードのラベルのスタイル 1: 普通, 2: 太字, 3: 斜体, 4: 太字斜体, 5: ギリシャ文字
#        + vertex.label.font=2,
#        + vertex.frame.color="white", #ノードの枠の色
#        + vertex.label.cex=0.8, #ノードラベルの文字サイズ
#        + edge.width=E(g)$weight, #エッジ属性weightをエッジの太さとする
#        + edge.color="gray80", #エッジの色
#        + layout=layout.fruchterman.reingold) #ネットワークのレイアウト手法