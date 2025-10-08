# 第五章 数据可视化
# 基础图形绘制

# 创建输出文件夹
output_dir <- "s5"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 1. 基础散点图和线图
x <- 1:10
y <- x^2 + rnorm(10, 0, 5)

# 散点图
plot(x, y, 
     main = "散点图示例",
     xlab = "X轴", ylab = "Y轴",
     pch = 19, col = "blue", 
     xlim = c(0, 11), ylim = c(-5, 105))

# 线图
plot(x, y, type = "l",
     main = "线图示例",
     xlab = "X轴", ylab = "Y轴",
     lty = 2, col = "red")

# 2. 饼图绘制
pie_data <- c(30, 25, 20, 15, 10)
pie_labels <- c("A类", "B类", "C类", "D类", "E类")

pie(pie_data, 
    labels = pie_labels,
    main = "饼图示例",
    col = rainbow(5))

# 3D饼图（需要plotrix包）
# install.packages("plotrix")
library(plotrix)
pie3D(pie_data, 
      labels = pie_labels,
      main = "3D饼图示例",
      col = rainbow(5))

# 3. 条形图
bar_data <- c(45, 38, 52, 41)
bar_names <- c("组1", "组2", "组3", "组4")

# 基础条形图
barplot(bar_data,
        names.arg = bar_names,
        main = "条形图示例",
        xlab = "组别", ylab = "数值",
        col = "skyblue")

# 组条形图
group_data <- matrix(c(20, 25, 30, 35, 18, 22, 28, 32), nrow = 2)
barplot(group_data,
        beside = TRUE,
        names.arg = c("A", "B", "C", "D"),
        legend.text = c("组1", "组2"),
        main = "组条形图示例",
        col = c("lightblue", "lightgreen"))

# 堆积条形图
barplot(group_data,
        names.arg = c("A", "B", "C", "D"),
        legend.text = c("组1", "组2"),
        main = "堆积条形图示例",
        col = c("lightblue", "lightgreen"))

# 4. 直方图
hist_data <- rnorm(100, mean = 50, sd = 10)

hist(hist_data,
     main = "直方图示例",
     xlab = "数值",
     col = "lightblue",
     breaks = 10,
     freq = FALSE)

# 添加密度曲线
lines(density(hist_data), col = "red", lwd = 2)

# 5. 箱线图
box_data <- list(
  组1 = rnorm(50, mean = 50, sd = 5),
  组2 = rnorm(50, mean = 55, sd = 8),
  组3 = rnorm(50, mean = 52, sd = 6)
)

boxplot(box_data,
        main = "箱线图示例",
        xlab = "组别", ylab = "数值",
        col = c("lightblue", "lightgreen", "lightyellow"))

# 6. 散点图矩阵
iris_subset <- iris[1:4]
pairs(iris_subset,
      main = "散点图矩阵示例")

# 7. 保存图形为图片文件
png(file.path(output_dir, "散点图示例.png"), width = 800, height = 600)
plot(x, y, 
     main = "散点图示例",
     xlab = "X轴", ylab = "Y轴",
     pch = 19, col = "blue")
dev.off()

cat("图形已保存为:", file.path(output_dir, "散点图示例.png"), "\n")

cat("第五章 数据可视化完成！所有结果已保存到文件夹:", output_dir, "\n")