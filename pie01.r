# tsv
# tsv <- read.csv("~/Desktop/sample.tsv", sep = "\t")
# values <- tsv$Command
# labels <- tsv$Command
# pie(values, labels = labels)


# https://qiita.com/hachisukansw/items/3047e516ebdc55c74104

sample_data <- data.frame(
  type = c("飴菓子", "チョコレート", "チューインガム", "せんべい", "ビスケット", "米菓", "和生菓子", "洋生菓子", "スナック菓子", "油菓子", "その他"),
  n = c(2680, 5370, 970, 725, 3800, 3705, 4725, 4196, 4361, 504, 2873)
)

library(dplyr)
library(ggplot2)
library(ggrepel)
(sample_data %>% arrange(desc(n)) %>%
  mutate(ypos = cumsum(n) - n / 2) %>%
  mutate(per = n / sum(n)) %>%
  mutate(label = paste0(type, "\n", scales::percent(per, 0.1))) %>%
  ggplot(aes(x = 0, y = n, fill = factor(rev(ypos))))
  +
  geom_col(color = "black")
  +
  coord_polar("y")
  +
  geom_text(
    data = (. %>% filter(per >= 0.05)),
    aes(x = 0.1, y = ypos, label = label), lineheight = 0.9, size = 5
  )
  +
  geom_text_repel(
    data = (. %>% filter(!(per >= 0.05))),
    aes(x = 0.4, y = ypos, label = label), nudge_x = 0.2, lineheight = 0.9, size = 4
  )
  +
  scale_fill_manual(values = rep(alpha(c("#03af7a", "#fff100", "#005aff", "#ff4b00", "#4dc4ff", "#ff8082", "#f6aa00", "#990099"), 0.6), 2))
  +
  theme_void()
  +
  theme(legend.position = "none")
)
