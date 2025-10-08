# 测验题三：箱型图比较酿酒酵母乙醇产量
# 功能：用箱型图比较4组乙醇产量分布，并保存为PNG

# 创建输出目录
output_dir <- "t3"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# 数据准备
sugar_concentration <- c(50, 100, 150, 200)

# 乙醇产量数据
ethanol_production <- list(
  "50g/L" = c(12, 11, 13, 12, 11, 13),
  "100g/L" = c(24, 23, 25, 26, 24, 25),
  "150g/L" = c(32, 31, 33, 34, 33, 32),
  "200g/L" = c(28, 27, 29, 28, 29, 27)
)

# 自定义颜色
custom_colors <- c("#1ABC9C", "#3498DB", "#E74C3C", "#F39C12")

# 生成箱型图
png(file = file.path(output_dir, "酿酒酵母乙醇产量箱型图.png"), 
    width = 800, height = 600, res = 100)

# 设置图形参数
par(mar = c(5, 5, 4, 2) + 0.1)

# 创建箱型图
boxplot(ethanol_production,
        col = custom_colors,
        xlab = "糖浓度 (g/L)",
        ylab = "乙醇产量 (g/L)",
        main = "不同糖浓度下酿酒酵母乙醇产量分布",
        cex.axis = 1.1,
        cex.lab = 1.2)

dev.off()

cat("箱型图已保存至", file.path(output_dir, "酿酒酵母乙醇产量箱型图.png"), "\n")