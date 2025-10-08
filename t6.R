# 测验题六：热图展示血糖均值矩阵
# 功能：用热图展示3×3血糖均值矩阵，并保存为PDF

# 创建输出目录
output_dir <- "t6"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# 数据准备
blood_sampling_methods <- c("静脉", "指尖", "足跟")
anticoagulants <- c("EDTA", "肝素", "无抗凝")

# 血糖均值矩阵
glucose_matrix <- matrix(c(5.2, 5.0, 5.4,
                          5.8, 5.6, 6.0,
                          5.5, 5.3, 5.7), 
                        nrow = 3, ncol = 3, byrow = TRUE)

rownames(glucose_matrix) <- blood_sampling_methods
colnames(glucose_matrix) <- anticoagulants

# 生成热图（添加中文字体支持）
pdf(file = file.path(output_dir, "血糖均值热图.pdf"), width = 8, height = 6, family = "GB1")

# 设置图形参数
par(mar = c(5, 8, 4, 6) + 0.1)

# 创建颜色映射函数
color_palette <- colorRampPalette(c("#1ABC9C", "#E74C3C"))
colors <- color_palette(10)

# 创建热图
image(1:3, 1:3, t(glucose_matrix[3:1,]), 
      col = colors,
      xaxt = "n", yaxt = "n",
      xlab = "", ylab = "",
      main = "不同采血方式和抗凝剂下血糖均值比较")

# 添加坐标轴标签
axis(1, at = 1:3, labels = anticoagulants, cex.axis = 1.2)
axis(2, at = 1:3, labels = rev(blood_sampling_methods), las = 1, cex.axis = 1.2)

# 添加网格线
abline(h = 1.5:2.5, v = 1.5:2.5, col = "black", lwd = 1)

# 在每个格子中添加数值
for (i in 1:3) {
  for (j in 1:3) {
    text(j, 4-i, sprintf("%.1f", glucose_matrix[i,j]), 
         col = "white", cex = 1.5, font = 2)
  }
}

# 添加颜色图例
legend_image <- as.raster(matrix(rev(colors), ncol = 1))
plot(c(0, 2), c(0, 1), type = 'n', axes = F, xlab = '', ylab = '')
rasterImage(legend_image, 0, 0, 0.3, 1)
text(0.45, 0, "5.0", cex = 1)
text(0.45, 1, "6.0", cex = 1)
text(0.2, -0.1, "血糖均值", cex = 1)

dev.off()

cat("热图已保存至", file.path(output_dir, "血糖均值热图.pdf"), "\n")