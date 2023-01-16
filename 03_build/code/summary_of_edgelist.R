## エッジリストの情報整理
# 整形前データのインポート
point_data_raw <- read.csv("02_raw/data/dataset_point_network.csv",header=T)
point_data_raw <- point_data_raw %>%
  select(-X)

## データの整形

# 交換先が現金であるものを全て「現金」として代入する。
point_data_raw$exchange[grep("現金",point_data_raw$exchange)] <- "現金"
unique_list_origin_all <- unique(point_data_raw$origin) 
unique_list_exchange_all <- unique(point_data_raw$exchange)　
unique_list_all <- unique(append(unique_list_origin_all,unique_list_exchange_all))

cat("取得日時：","2022/12","\n")
cat("総列数：",nrow(point_data_raw),"\n")
cat("ポイントの種類数：",length(unique_list_all),"\n")
cat("交換元ポイントのユニーク数：",length(unique_list_origin_all),"\n")
cat("交換先ポイント等のユニーク数（含む通貨）：",length(unique_list_exchange_all),"\n")
