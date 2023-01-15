# function

# ネットワークグラフの指数分析
graph_summary <- function(graph){
  cat("ノード数：",vcount(graph),"\n") 
  cat("エッジ数：",ecount(graph),"\n")
  cat("密度：",graph.density(graph),"\n")
  cat("推移性：", transitivity(graph),"\n")
  cat("相互性：", reciprocity(graph),"\n")
  # top_10<- head(sort(degree(graph),decreasing = T),n = 10) 
  top_10<- data.frame(head(sort(degree(graph),decreasing = T),n = 10))
  colnames(top_10) <- "エッジ総数"
  print(top_10)
  # cat("ノードごとの次数上位10ノード（名称）：",names(top_10),"\n")
  # cat("ノードごとのエッジ数上位10ノード（エッジ総数）：",top_10,"\n")
}
