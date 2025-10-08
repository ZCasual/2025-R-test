# 测验题五：散点图展示SPAD与产量关系
# 功能：用散点图展示SPAD与产量的关系，添加一元线性回归线，并保存为PDF

# 创建输出目录
output_dir <- "t5"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# 数据准备
spad_values <- c(38, 40, 42, 45, 47, 50, 52, 55, 48, 46, 44, 49, 51, 53, 56, 54, 50, 48, 52, 55, 
                 57, 59, 60, 58, 61, 63, 60, 58, 62, 64, 65, 63, 66, 68, 67, 64, 69, 70, 72, 71)

yield <- c(8.2, 8.5, 8.8, 9.1, 9.4, 9.7, 10.0, 10.3, 9.0, 8.9, 8.7, 9.3, 9.6, 9.9, 10.2, 10.1, 9.8, 
           9.5, 9.8, 10.0, 10.4, 10.6, 10.8, 10.5, 10.9, 11.1, 10.7, 10.4, 10.8, 11.2, 11.4, 11.0, 
           11.5, 11.7, 11.6, 11.3, 11.8, 12.0, 12.2, 12.1)

# 线性回归分析
lm_model <- lm(yield ~ spad_values)
regression_line <- predict(lm_model)

# 生成散点图
pdf(file = file.path(output_dir, "SPAD与产量关系散点图.pdf"), width = 8, height = 8)

# 设置图形参数
par(mar = c(5, 5, 4, 2) + 0.1)

# 创建散点图
plot(spad_values, yield, 
     pch = 19,  # 实心圆点
     col = "#2980B9",  # 自定义颜色
     xlab = "SPAD值（叶绿素相对含量）",
     ylab = "籽粒产量 (t/ha)",
     main = "玉米灌浆中期SPAD值与籽粒产量关系",
     cex = 1.2,
     cex.axis = 1.1,
     cex.lab = 1.2)

# 添加回归线
abline(lm_model, col = "#E74C3C", lwd = 2)

# 添加图例
legend("topleft", 
       legend = c("观测点", "回归线"),
       pch = c(19, NA),
       lty = c(NA, 1),
       col = c("#2980B9", "#E74C3C"),
       lwd = c(NA, 2))

dev.off()

# 输出回归统计信息
cat("线性回归结果：\n")
cat("回归方程：产量 =", round(coef(lm_model)[1], 3), "+", round(coef(lm_model)[2], 3), "× SPAD\n")
cat("R² =", round(summary(lm_model)$r.squared, 3), "\n")
cat("散点图已保存至", file.path(output_dir, "SPAD与产量关系散点图.pdf"), "\n")