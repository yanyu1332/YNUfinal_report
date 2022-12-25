# 分析時に使用するmatrixデータの編集を行う

## --------------------------------------------------
## dataのインポート
df_of_point <- read.csv("02_raw/data/matrix_of_point.csv",row.names = "point")

df_of_point <- df_of_point %>%
  select(-X)

## --------------------------------------------------
# 他ポイントと交換していないデータを削除する (plotをわかりやすくするため)
df_of_point_have_exchange <- df_of_point[colSums(df_of_point)!=0]

count_exchange <- 5
df_of_point_have_exchange_over_variable <- df_of_point[colSums(df_of_point) >= count_exchange] 

## -----------------------
# CSV形式でエクスポート
write.csv(x = df, file = "02_raw/data/matrix_of_point_edited.csv")
