library(ggplot2)
library(scales)

# GRP と売上データの読み込み
url <- "https://gihyo.jp/assets/files/book/2016/978-4-7741-8360-2/download/grp.csv"
grp.data <- read.csv(url, header = T)

# 上位6件を表示
head(grp.data)

# 散布図の描画
ggplot(grp.data, aes(x = grp, y = amount)) +
  geom_point() +
  scale_y_continuous(label = comma, limits = c(0, 360000)) +
  ylab("売上") +
  xlab("GRP") +
  theme_bw(16)

# 線形モデルの可視化は、geom_smooth関数ですぐにできる
ggplot(grp.data, aes(x = grp, y = amount)) +
  geom_point() +
  scale_y_continuous(label = comma, limits = c(0, 360000)) +
  ylab("売上") +
  xlab("GRP") +
  geom_smooth(method = "lm") +
  theme_bw(16)

# モデル構築
fit <- lm(amount ~ grp, data = grp.data)

# モデルの概要の表示
summary(fit)

# 逓減型モデルの構築
fit <- lm(log(amount) ~ log(grp), data = grp.data)

# モデルの概要
summary(fit)

# 予測結果を描画
fit.data <- data.frame(grp = grp.data$grp, amount = exp(fit$fitted.values))
ggplot(grp.data, aes(x = grp, y = amount)) +
  geom_point() +
  geom_line(data = fit.data, aes(x = grp, y = amount)) +
  scale_y_continuous(label = comma, limits = c(0, 360000)) +
  ylab("売上") +
  xlab("GRP") +
  theme_bw(16)
