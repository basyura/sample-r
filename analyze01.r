library(ggplot2)
library(fmsb)

url <- "https://gihyo.jp/assets/files/book/2016/978-4-7741-8360-2/download/sp_user_research_data.csv"
sp.user.data <- read.csv(url, header=T)
sp.user.pca <- prcomp(sp.user.data[,-1], scale = T)
biplot(sp.user.pca)

# k-means 法によるクラスタリング
sp.user.km <- kmeans(sp.user.data[, -1], 4)

# 主成分分析の結果にクラスターの情報を付与
sp.user.pca.df <- data.frame(sp.user.pca$x)
sp.user.pca.df$id <- sp.user.data$id
sp.user.pca.df$cluster <- as.factor(sp.user.km$cluster)

# 描画
ggplot(sp.user.pca.df, aes(x = PC1, y = PC2, label = id, col = cluster)) +
  geom_text() +
  theme_bw(16)

# レーダーチャート用にデータを整形
df <- data.frame(scale(sp.user.km$centers))
dfmax <- apply(df, 2, max) + 1
dfmin <- apply(df, 2, min) - 1
df <- rbind(dfmax, dfmin, df)

# レーダーチャートの描画
radarchart(df, seg = 5, plty = 1, pcol = rainbow(4))
legend("topright", legend = 1:4, col = rainbow(4), lty = 1)
