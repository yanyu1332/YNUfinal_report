# 整形前データのインポート
point_data_raw <- read.csv("02_raw/data/dataset_point_network.csv",header=T)
point_data_raw <- point_data_raw %>%
  select(-X)
point_data_raw[point_data_raw$exchange == "Gポイント",]
## データの整形

# 交換先が現金であるものを全て「現金」として代入する。
point_data_raw$exchange[grep("現金",point_data_raw$exchange)] <- "現金"



## データのエクスポート
# 現金に直接交換可能なデータセットのみを抽出したデータセット
point_1st_raw <- point_data_raw[grep("現金",point_data_raw$exchange),]
point_1st <- point_1st_raw %>%
  distinct(origin,.keep_all=TRUE)
write.csv(x = point_1st, file = "02_raw/data/point_1st.csv")


# 一度別のポイントを媒体すれば現金に交換可能なデータセットのみを抽出したデータセット
unique_1st_point <- unique(point_data_raw$origin[grep("現金",point_data_raw$exchange)])

point_data_raw[point_data_raw$exchange == "Gポイント",]

point_2nd_raw <- point_1st
length(unique_1st_point)
# 1rt データに2ndデータを追加
for (i in 1:length(unique_1st_point)) {
  point_2nd_raw <- rbind(point_2nd_raw,point_data_raw[point_data_raw$exchange == unique_1st_point[i],])
}

point_2nd <- point_2nd_raw %>%
  distinct(origin,exchange,.keep_all=TRUE)
write.csv(x = point_2nd, file = "02_raw/data/point_2nd.csv")
