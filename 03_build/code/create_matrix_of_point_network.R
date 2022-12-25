# ネットワーク分析を行う行列を作成する

## --------------------------------------------------
## dataのインポート
point_data_raw <- read.csv("02_raw/data/dataset_point_network.csv")


## --------------------------------------------------
## master datasetの作成
#ユニークデータのベクトルを作成する
unique_point_orgin <- unique(point_data_raw$origin)
unique_point_exchange <- unique(point_data_raw$exchange)

unique_point <- unique(append(unique_point_orgin,unique_point_exchange))

# 行列の1行目を意味するdataframeの作成
df_col_1 <- data.frame(unique_point)

## --------------------------------------------------
## 個々のpointのdataframeを作成

# 個々のdataframeを作成
df_temporary <- data.frame(unique_point)
for (i in 1:length(unique_point)) {
  df_indvisual <- point_data_raw[point_data_raw$origin == unique_point[i],] %>%
    select(-X) # 「X」列以外の列を選択
  df_indvisual_remake <- df_indvisual %>%
    mutate(hoge = 1) %>% #1を要素として持つ新たな列を追加
    select(-origin) # 「origin」列以外の列を選択
  # masterと個々のポイントのdataframeをouter_join
  df_temporary <- left_join(df_temporary,df_indvisual_remake,by = c("unique_point" = "exchange"))
}
## --------------------------------------------------
## detaframの成型
df <- full_join(df_col_1,df_temporary,by = "unique_point") %>%
  distinct(.keep_all=TRUE)
df[is.na(df)] <- 0 # NAを0に変換

colnames(df) <- c("point",unique_point) #列名をunique_pointに変更

df <- subset(df, point != "None") %>%
  select(-None)

## --------------------------------------------------
# 列名と行名が一致しているかチェック
col <- colnames(df)
row <- df$point
setdiff(col, row)

## --------------------------------------------------
# CSV形式でエクスポート
# write.csv(x = df, file = "02_raw/data/matrix_of_point.csv")
# エクスポートすると「（）」や「 」が正しくエンコーディングされないため、代替的にエクスポートせずに使用する。
matrix_of_point <- df

