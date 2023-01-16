# function

# ネットワークグラフの指数分析
graph_summary <- function(graph,csv_name){
  cat("ノード数：",vcount(graph),"\n") 
  cat("エッジ数：",ecount(graph),"\n")
  cat("密度：",graph.density(graph),"\n")
  cat("推移性：", transitivity(graph),"\n")
  cat("相互性：", reciprocity(graph),"\n")
  inf_deg <- degree(graph)
  inf_deg_out <- degree(graph,m="out")
  inf_deg_in <- degree(graph,m="in")
  inf_close <- closeness(graph)
  inf_bet <- betweenness(graph, directed = TRUE)
  inf <- data.frame(cbind(inf_deg,inf_deg_out,inf_deg_in,inf_close,inf_bet))
  inf_top20 <- head(inf[order(inf$inf_bet, decreasing = TRUE),],20)
  colnames(inf_top20) <- c("次数","出次数","入次数","近接性","媒介性")
  write.csv(x = inf_top20, file = paste("03_build/output/inf_",csv_name,".csv"))
}
# graph_summary(graph_all,"all")
