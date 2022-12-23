# ネットワーク分析を行う行列を作成する

## --------------------------------------------------
## dataのインポート
point_data_raw <- read.csv("02_raw/data/dataset_point_network.csv")

## --------------------------------------------------
## master datasetの作成
#ユニークデータのベクトルを作成する
unique_point <- unique(point_data_raw$origin)

# masterのdataframeの作成
master_df <- data.frame(unique_point)

## --------------------------------------------------
## 個々のpointのdataframeを作成

# 個々のdataframeを作成
df_indvisual <- point_data_raw[point_data_raw$origin == "JALマイレージバンク",] %>%
  select(-X) # 「X」列以外の列を選択

df_indvisual_remake <- df_indvisual %>%
  mutate(JALマイレージバンク = 1) %>% #1を要素として持つ新たな列を追加
  select(-origin) # 「origin」列以外の列を選択 

## masterと個々のポイントのdataframeをouter_join
master_df <- left_join(master_df,df_indvisual_remake,by = c("unique_point" = "exchange"))

## --------------------------------------------------
## detaframの成型
# NAを0に変換
master_df[is.na(master_df)] <- 0