## library
library("igraph")
library(networkD3)
library(tibble)

## import dataset

# df_of_point <- read.csv("02_raw/data/matrix_of_point_edited.csv")
# df_of_point <- column_to_rownames(df_of_point, "X")

## --------------------------------------------------
# 全データの取得
df_of_point <- read.csv("02_raw/data/matrix_of_point_edited.csv",row.names = "point")
df_of_point <- df_of_point %>%
  select(-X)

point <- as.matrix(df_of_point) # convert matrix
point <- t(point) #転置
rowSums(point)

## plot
point_g<- graph.adjacency(point,mode = "directed") # グラフ用のデータを作る
point_g2 <- data.frame(as_edgelist(point_g)) # グラフ用のデータを作る
simpleNetwork(point_g2, fontSize = 10, nodeColour = "0000A2", opacity = 2, fontFamily = "Meiryo UI") 


plot(point_g)

