# 整形前データのインポート
point_data_raw <- read.csv("02_raw/data/dataset_point_network.csv",header=T)
point_data_raw <- point_data_raw %>%
  select(-X)
point_data_raw[point_data_raw$exchange == "Gポイント",]
## データの整形

# 交換先が現金であるものを全て「現金」として代入する。
point_data_raw$exchange[grep("現金",point_data_raw$exchange)] <- "現金"



## データのエクスポート
# =====
# all data
write.csv(x = point_data_raw, file = "02_raw/data/point_all.csv")

# =====
# 現金に直接交換可能なデータセットのみを抽出したデータセット
point_1st_raw <- point_data_raw[grep("現金",point_data_raw$exchange),]
point_1st <- point_1st_raw %>%
  distinct(origin,.keep_all=TRUE)

unique_list_origin_1st <- unique(point_1st$origin) #originのユニークな値を抽出
unique_list_exchange_1st <- unique(point_1st$exchange)　#exchangeのユニークな値を抽出
unique_list_1st <- unique(append(unique_list_origin_1st,unique_list_exchange_1st)) #両者を連結

point_data_direct <- point_data_raw %>%　#unique_listに合致するもののみ抽出
  mutate(
    orgin_flg = if_else(point_data_raw$origin %in% unique_list_1st,1,0),
    exchange_flg = if_else(point_data_raw$exchange %in% unique_list_1st,1,0),
    flg = orgin_flg + exchange_flg)

point_data_direct <- point_data_direct %>%
  filter(point_data_direct$flg == 2) %>%
  select(origin,exchange) %>%
  distinct(origin,.keep_all=TRUE)

write.csv(x = point_data_direct, file = "02_raw/data/point_direct.csv")

# =====
# 一度別のポイントを媒体すれば現金に交換可能なデータセットのみを抽出したデータセット
unique_1st_point <- unique(point_data_raw$origin[grep("現金",point_data_raw$exchange)])

point_2nd_raw <- point_1st

# 1rt データに2ndデータを追加
for (i in 1:length(unique_1st_point)) {
  point_2nd_raw <- rbind(point_2nd_raw,point_data_raw[point_data_raw$exchange == unique_1st_point[i],])
}

point_2nd <- point_2nd_raw %>%
  distinct(origin,exchange,.keep_all=TRUE)

point_data_indirect <- rbind(point_data_direct,point_2nd) %>%
  distinct(origin,exchange,.keep_all=TRUE)
# 
# unique_list_origin_2nd <- unique(point_2nd$origin) #originのユニークな値を抽出
# unique_list_exchange_2nd <- unique(point_2nd$exchange)　#exchangeのユニークな値を抽出
# unique_list_2nd <- unique(append(unique_list_origin_2nd,unique_list_exchange_2nd)) #両者を連結
# 
# point_data_indirect <- point_data_raw %>%　#unique_listに合致するもののみ抽出
#   mutate(
#     orgin_flg = if_else(point_data_raw$origin %in% unique_list_2nd,1,0),
#     exchange_flg = if_else(point_data_raw$exchange %in% unique_list_2nd,1,0),
#     flg = orgin_flg + exchange_flg
#     )
# 
# point_data_indirect <- point_data_indirect %>%
#   filter(point_data_indirect$flg == 2) %>%
#   select(origin,exchange) %>%
#   distinct(origin,.keep_all=TRUE)
# 

write.csv(x = point_data_indirect, file = "02_raw/data/point_indirect.csv")
# =====


