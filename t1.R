# 测验题一：3D饼图展示河蟹大眼幼体日捕获量
# 功能：生成3D饼图展示各规格占比，并保存为PDF

# 加载必要的包
library(plotrix)

# 创建输出目录
output_dir <- "t1"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# 数据准备
specifications <- c("小（<0.5g）", "中（0.5-1g）", "大（>1g）")
counts <- c(50, 30, 20)

# 自定义颜色
custom_colors <- c("#FF6B6B", "#4ECDC4", "#45B7D1")

# 设置最大扇区轻微炸开
explode_value <- 0.08

# 生成3D饼图（添加中文字体支持）
pdf(file = file.path(output_dir, "河蟹大眼幼体日捕获量饼图.pdf"), width = 8, height = 8, family = "GB1")

pie3D(counts, 
      labels = specifications,
      explode = explode_value,
      col = custom_colors,
      main = "中华绒螯蟹大眼幼体日捕获量分布",
      labelcex = 1.2)

dev.off()

cat("饼图已保存至", file.path(output_dir, "河蟹大眼幼体日捕获量饼图.pdf"), "\n")