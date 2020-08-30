# http://touch-sp.hatenablog.com/entry/2017/12/07/074914

# tsv
tsv <- read.csv("~/Desktop/sample.tsv", sep = "\t")
# x 軸の値
x_values <- as.POSIXct(tsv$end)
# y 軸の値
y_values <- tsv$elapsed
# 軸を書かない
par(xaxt = "n")
# グラフ描画
plot(x_values, y_values,
  ylim = c(0, 60000), xlab = "", ylab = "elapsed [ms]",
  main = substring(x_values[1], 0, 10),
  pch = "*"
)
# 通常の軸を書く
par(xaxt = "s")
# 開始位置
time_start <- as.POSIXct("2020/07/13 09:00:00", format = "%Y/%m/%d %H:%M:%S")
# 終了位置
time_end <- as.POSIXct("2020/07/13 12:00:00", format = "%Y/%m/%d %H:%M:%S")
# 10 分毎にメモリを表示
axis.POSIXct(1, at = seq(time_start, time_end, 60 * 15), format = "%H:%M")

# Days
a <- as.Date(c("2017/4/15", "2017/5/2", "2017/8/31"))
b <- c(2, 8, 7)
par(xaxt = "n")
plot(a, b, type = "b", ylim = c(0, 10), xlab = "time", ylab = "value")
par(xaxt = "s")
axis.Date(1, at = seq(min(a), max(a), "month"), format = "%m/%d")


# hours
a <- as.POSIXct(c("11:15", "13:45", "19:59"), format = "%H:%M")
b <- c(2, 8, 7)
par(xaxt = "n")
plot(a, b, type = "b", ylim = c(0, 10), xlab = "time", ylab = "value")
par(xaxt = "s")
time_start <- as.POSIXct("00:00", format = "%H:%M")
time_end <- as.POSIXct("24:00", format = "%H:%M")
axis.POSIXct(1, at = seq(time_start, time_end, "hour"), format = "%H")
