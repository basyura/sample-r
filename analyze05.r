library(conjoint)
# 構成要素
experiment <- expand.grid(
  imgA = c("ImageA1", "ImageA2"),
  imgB = c("ImageB1", "ImageB2"),
  txtA = c("TextA1", "TextA2"),
  txtB = c("TextB1", "TextB2")
)

# 直交表の作成
desig.ort <- caFactorialDesign(
  data = experiment, type = "orthogonal"
)

# 仮想のテスト結果データの読み込み
web.test.data <- read.csv("https://gihyo.jp/assets/files/book/2016/978-4-7741-8360-2/download/web_test_sample.csv", header = T)
# 上位6件だけ表示
head(web.test.data)
