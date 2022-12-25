# 分析時に使用するmatrixデータの編集を行う

## --------------------------------------------------
## dataのインポート ver1
# df_point <- read.csv("02_raw/data/matrix_of_point.csv",row.names = "point")
# df_point <- df_point %>%
#   select(-X)

## --------------------------------------------------
## dataのインポート ver2
# create_matrix_of_point_networkから直接以降移行
df_point <- matrix_of_point #一度csvに変換すると、エンコーディングでエラーが起きるため、csv変換前のデータセットを用いる


## --------------------------------------------------
# 他ポイントと交換していないデータを削除する (plotをわかりやすくするため)
# df_exchangeable <- df_point[colSums(df_point)!=0] #他ポイントと交換していないポイントを排除したデータセット

point <- df_point$point
count_exchange <- 10

df_exchangeable <- df_point %>%
  select(-point) #一時的に列名を除外する
df_exchangeable <-df_exchangeable[colSums(df_exchangeable) >= count_exchange] #count_exchangeの数値よりも交換先が存在するデータセットを抽出
df_exchangeable <- cbind(point, df_exchangeable) #行名をもとに戻す

col_names <- colnames(df_exchangeable)
df_exchangeable_col <- data.frame(col_names)
df_exchangeable_col["temp"] =1

## --------------------------------------------------
# df <- read.csv("02_raw/data/matrix_of_point.csv")
# df <- matrix_of_point   #一度csvに変換すると、エンコーディングでエラーが起きるため、csv変換前のデータセットを用いる
df <- left_join(df_exchangeable,df_exchangeable_col,by = c("point" = "col_names"))
df[is.na(df)] <- 0

df_edited <- df %>%
  filter(df$temp == 1) %>%
  select(-temp)
colSums(df_edited)

## -----------------------
# CSV形式でエクスポート
write.csv(x = df_edited, file = "02_raw/data/matrix_of_point_edited.csv")
