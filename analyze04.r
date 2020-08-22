library(plyr)

# A/B の真のコンバージョン率を設定
A1.CVR <- 0.09
B1.CVR <- 0.09

# サンプル数
n <- 1000
set.seed(2)

# シミュレーション
AB1 <- data.frame(
  Pattern = c(rep("A", n), rep("B", n)),
  CV = c(
    rbinom(n, 1, A1.CVR),
    rbinom(n, 1, B1.CVR)
  )
)

# コンバージョン率の算出
ddply(AB1, .(Pattern), summarize, CVR = mean(CV))

# B の方がコンバージョン率は高い
A2.CVR <- 0.095
B2.CVR <- 0.097
n <- 10000
set.seed(2)

# シミュレーション
AB2 <- data.frame(
  Pattern = c(rep("A", n), rep("B", n)),
  CV = c(rbinom(n, 1, A2.CVR), rbinom(n, 1, B2.CVR))
)

# コンバージョン率の算出
ddply(AB2, .(Pattern), summarize, CVR = mean(CV))


# カイ二乗検定の実行(シミュレーション1)
chisq.test(table(AB1))

# カイ二乗検定の実行(シミュレーション2)
chisq.test(table(AB2))


