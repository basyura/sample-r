library(dplyr)
library(ggplot2)


# https://www.datanovia.com/en/blog/how-to-create-a-pie-chart-in-r-using-ggplot2/

count.data <- data.frame(
  class = c("1st", "2nd", "3rd", "Crew"),
  n = c(325, 285, 706, 885),
  prop = c(14.8, 12.9, 32.1, 40.2)
)
mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF")

# Add label position
count.data <- count.data %>%
  arrange(desc(class)) %>%
  mutate(lab.ypos = cumsum(prop) - 0.5 * prop)
count.data

ggplot(count.data, aes(x = "", y = prop, fill = class)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(y = lab.ypos, label = prop), color = "white") +
  scale_fill_manual(values = mycols) +
  theme_void()



# tsv <- read.csv("~/Desktop/sample.tsv", sep = "\t")

# mart <- aggregate(x = tsv[c("elapsed")], by = list(tsv$Command), FUN = sum)

# pie(mart$elapsed,
# labels = mart$Group.1,
# cex = 0.5,
# clockwise = TRUE, col = rainbow(6), radius = 1
# )
