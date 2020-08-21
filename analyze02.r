library(ggplot2)
library(MASS)

# 選好データの読み込み
target.data <- read.csv("https://gihyo.jp/assets/files/book/2016/978-4-7741-8360-2/download/target_preference_data.csv", header = T)

# 非計量 MDS の実行
service.dist <- dist(t(target.data[, -1]))
service.map <- isoMDS(service.dist)

# 描画用のデータ整形
service.map.df <- data.frame(scale(service.map$points))
service.map.df$service_name <- names(target.data[, -1])

# 描画
ggplot(service.map.df, aes(x = X1, y = X2, label = service_name)) +
  geom_text() +
  theme_bw(16)


#選好ベクトルの推定
user.preference.data <-
  do.call(rbind,
          lapply(1:nrow(target.data),
                 function(i){
                   preference.data <- data.frame(
                                               p=as.numeric(target.data[i,-1]),
                                               X1=service.map.df$X1,
                                               X2=service.map.df$X2)
                   fit<-lm(p~.,data=preference.data)
                   b <-2 / sqrt(fit$coef["X1"]^2 + fit$coef["X2"]^2)
                   data.frame(X1 = b*fit$coef["X1"],
                              X2 = b*fit$coef["X2"],
                              service_name = i)
                 }))
#選好ベクトルの描画
ggplot(service.map.df,aes(x=X1, y=X2, label=service_name)) +
  geom_text() +
  theme_bw(16) +
  xlim(-2,2) +
  ylim(-2,2) +
  geom_point(data=user.preference.data,aes(x=X1,y=X2))


## 選好ベクトルの推定
#user.preference.data <-
#  do.call(rbind,
#          lapply(1:nrow(target.data),
#                 function(i) {
#                   preference.data <- data.frame(
#                                                 p = as.numeric(target.data[i, -1]),
#                                                 X1 = service.map.df$X1,
#                                                 X2 = service.map.df$X2
#                   )
#                   fit <- lm(p~., data = preference.data)
#                   b <- 2 / sqrt(fit$coef["X1"]^2 + fit$coef["X2"]^2)
#                   data.frame(X1 = b*fit$coef["X1"],
#                              X2 = b*fit$coef["X2"],
#                              service_name = i)
#                 }))
#
## 選好ベクトルの描画
#ggplot(service.map.df, aes(x = X1, y=X2, label=service_name)) +
#  geom_text() +
#  theme_bw(16) +
#  xlim(-2, 2) +
#  ylim(-2, 2) +
#  geom_point(data = user.preference.data, aes(x=X1, y=X2))
#
#















