# 测验题二：条形图展示大黄鱼育苗试验结果
# 功能：用条形图展示各组数值±标准误，并保存为PNG

# 创建输出目录
output_dir <- "t2"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# 数据准备
groups <- c("A组", "B组", "C组", "D组", "E组")
length_increase <- c(4.8, 6.2, 5.5, 7.1, 5.0)
standard_errors <- c(0.25, 0.30, 0.22, 0.28, 0.20)

# 自定义颜色
custom_colors <- c("#E74C3C", "#3498DB", "#2ECC71", "#F39C12", "#9B59B6")

# 生成条形图
png(file = file.path(output_dir, "大黄鱼育苗试验结果.png"), 
    width = 800, height = 600, res = 100)

# 设置图形参数
par(mar = c(5, 5, 4, 2) + 0.1)

# 创建条形图
bar_positions <- barplot(length_increase, 
                        names.arg = groups,
                        col = custom_colors,
                        ylim = c(0, max(length_increase + standard_errors) * 1.1),
                        ylab = "平均体长增量 (mm)",
                        main = "大黄鱼不同微藻饵料组合育苗试验结果",
                        cex.names = 1.2,
                        cex.axis = 1.1,
                        cex.lab = 1.2)

# 添加误差线
arrows(bar_positions, length_increase - standard_errors,
       bar_positions, length_increase + standard_errors,
       angle = 90, code = 3, length = 0.1, lwd = 2)

dev.off()

cat("条形图已保存至", file.path(output_dir, "大黄鱼育苗试验结果.png"), "\n")