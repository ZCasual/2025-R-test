# 实战3 数据可视化 - 散点图和热图
# 功能：绘制散点图和热图，用于分析变量间关系和模式识别

# 创建输出文件夹
output_dir <- "s7_a3"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 加载必要的包
library(gplots)  # 用于热图绘制

# 函数：绘制散点图
# 输入：x - x轴数据，y - y轴数据，groups - 分组变量，title - 图表标题
# 输出：线性回归模型对象
plot_scatter <- function(x, y, groups = NULL, title = "散点图") {
  # 设置绘图参数
  plot(x, y, 
       pch = if (!is.null(groups)) as.numeric(factor(groups)) else 19,
       col = if (!is.null(groups)) factor(groups) else "blue",
       main = title,
       xlab = "X轴", ylab = "Y轴",
       cex = 1.2)
  
  # 添加线性回归线
  model <- lm(y ~ x)
  abline(model, col = "red", lwd = 2)
  
  # 添加分组标记（如果有分组）
  if (!is.null(groups)) {
    legend("topleft", 
           legend = levels(factor(groups)),
           pch = 1:length(levels(factor(groups))),
           col = 1:length(levels(factor(groups))),
           title = "分组")
  }
  
  # 添加均值线
  abline(h = mean(y), col = "gray", lty = 2)
  abline(v = mean(x), col = "gray", lty = 2)
  
  return(model)
}

# 函数：绘制热图
# 输入：data_matrix - 数据矩阵，color_palette - 颜色调色板，title - 图表标题
# 输出：无返回值，直接绘制图形
plot_heatmap <- function(data_matrix, color_palette = NULL, title = "热图") {
  if (is.null(color_palette)) {
    color_palette <- colorRampPalette(c("blue", "white", "red"))(100)
  }
  
  # 绘制热图
  image(1:ncol(data_matrix), 1:nrow(data_matrix), 
        t(data_matrix[nrow(data_matrix):1, ]),
        col = color_palette,
        main = title,
        xlab = "列", ylab = "行",
        axes = FALSE)
  
  # 添加坐标轴
  axis(1, at = 1:ncol(data_matrix), labels = colnames(data_matrix))
  axis(2, at = 1:nrow(data_matrix), labels = rownames(data_matrix)[nrow(data_matrix):1])
  
  # 添加边框
  box()
  
  # 添加数值标注（仅适用于小矩阵）
  if (nrow(data_matrix) <= 10 && ncol(data_matrix) <= 10) {
    for (i in 1:nrow(data_matrix)) {
      for (j in 1:ncol(data_matrix)) {
        text(j, nrow(data_matrix) - i + 1, 
             round(data_matrix[i, j], 1), 
             cex = 0.8)
      }
    }
  }
}

# 示例1：对虾体长-干重散点图
cat("示例1：对虾体长-干重散点图\n")
# 模拟数据：对虾体长和干重
shrimp_length <- runif(50, 5, 15)
shrimp_weight <- 0.05 * shrimp_length^2 + rnorm(50, 0, 0.5)

# 绘制散点图
shrimp_model <- plot_scatter(shrimp_length, shrimp_weight, 
                            title = "对虾体长-干重关系")

# 模型摘要
cat("对虾体长-干重回归模型摘要：\n")
print(summary(shrimp_model))

# 保存为PNG文件
png(file.path(output_dir, "shrimp_length_weight_scatter.png"), width = 800, height = 600)
shrimp_model <- plot_scatter(shrimp_length, shrimp_weight, 
                            title = "对虾体长-干重关系")
dev.off()

# 示例2：微生物生长曲线散点图
cat("示例2：微生物生长曲线散点图\n")
# 模拟数据：微生物生长曲线
time_points <- 0:24
growth_data <- 100 / (1 + exp(-0.3 * (time_points - 12))) + rnorm(25, 0, 5)

# 绘制散点图
growth_model <- plot_scatter(time_points, growth_data, 
                            title = "微生物生长曲线")

# 保存为PDF文件
pdf(file.path(output_dir, "microbial_growth_scatter.pdf"), width = 8, height = 6)
growth_model <- plot_scatter(time_points, growth_data, 
                            title = "微生物生长曲线")
dev.off()

# 示例3：不同pH下红霉素效价散点图
cat("示例3：不同pH下红霉素效价散点图\n")
# 模拟数据：不同pH条件下的红霉素效价
ph_levels <- rep(c(5.5, 6.0, 6.5, 7.0, 7.5), each = 10)
erythromycin_potency <- c(
  rnorm(10, 800, 50),  # pH 5.5
  rnorm(10, 1200, 60), # pH 6.0
  rnorm(10, 1800, 70), # pH 6.5
  rnorm(10, 1500, 65), # pH 7.0
  rnorm(10, 900, 55)   # pH 7.5
)

# 绘制散点图（按pH分组）
pH_model <- plot_scatter(ph_levels, erythromycin_potency, 
                        groups = factor(ph_levels),
                        title = "不同pH下红霉素效价")

# 保存为PNG文件
png(file.path(output_dir, "erythromycin_pH_scatter.png"), width = 800, height = 600)
pH_model <- plot_scatter(ph_levels, erythromycin_potency, 
                        groups = factor(ph_levels),
                        title = "不同pH下红霉素效价")
dev.off()

# 示例4：对虾日增重热图
cat("示例4：对虾日增重热图\n")
# 模拟数据：不同温度和时间下的对虾日增重
temperatures <- c(20, 22, 24, 26, 28)
time_periods <- c("第1周", "第2周", "第3周", "第4周")

# 创建数据矩阵
shrimp_growth_matrix <- matrix(
  c(0.8, 1.2, 1.5, 1.8,   # 20°C
    1.0, 1.5, 1.8, 2.0,   # 22°C
    1.2, 1.8, 2.2, 2.5,   # 24°C
    1.1, 1.6, 2.0, 2.3,   # 26°C
    0.9, 1.3, 1.6, 1.9),  # 28°C
  nrow = 5, ncol = 4, byrow = TRUE
)

rownames(shrimp_growth_matrix) <- paste(temperatures, "°C")
colnames(shrimp_growth_matrix) <- time_periods

# 自定义颜色调色板
growth_colors <- colorRampPalette(c("#4575B4", "#74ADD1", "#ABD9E9", 
                                    "#E0F3F8", "#FEE090", "#FDAE61", 
                                    "#F46D43", "#D73027"))(100)

# 绘制热图
plot_heatmap(shrimp_growth_matrix, growth_colors, 
             "对虾日增重热图（g/天）")

# 保存为PDF文件
pdf(file.path(output_dir, "shrimp_daily_growth_heatmap.pdf"), width = 8, height = 6)
plot_heatmap(shrimp_growth_matrix, growth_colors, 
             "对虾日增重热图（g/天）")
dev.off()

# 示例5：枯草芽孢杆菌OD值热图
cat("示例5：枯草芽孢杆菌OD值热图\n")
# 模拟数据：不同培养条件下的OD值
nutrients <- c("低营养", "中营养", "高营养")
time_points <- c("6h", "12h", "18h", "24h", "30h", "36h")

# 创建数据矩阵
bacillus_od_matrix <- matrix(
  c(0.1, 0.3, 0.5, 0.7, 0.8, 0.9,   # 低营养
    0.2, 0.5, 0.8, 1.2, 1.5, 1.7,   # 中营养
    0.3, 0.7, 1.1, 1.6, 1.9, 2.1),  # 高营养
  nrow = 3, ncol = 6, byrow = TRUE
)

rownames(bacillus_od_matrix) <- nutrients
colnames(bacillus_od_matrix) <- time_points

# 自定义颜色调色板
od_colors <- colorRampPalette(c("#2B83BA", "#ABDDA4", "#FFFFBF", 
                                "#FDAE61", "#D7191C"))(100)

# 绘制热图
plot_heatmap(bacillus_od_matrix, od_colors, 
             "枯草芽孢杆菌OD值热图")

# 保存为PDF文件
pdf(file.path(output_dir, "bacillus_od_heatmap.pdf"), width = 8, height = 6)
plot_heatmap(bacillus_od_matrix, od_colors, 
             "枯草芽孢杆菌OD值热图")
dev.off()

# 示例6：药物溶出度热图
cat("示例6：药物溶出度热图\n")
# 模拟数据：不同配方在不同时间点的溶出度
formulations <- c("配方A", "配方B", "配方C", "配方D")
dissolution_times <- c("15min", "30min", "45min", "60min", "90min", "120min")

# 创建数据矩阵
drug_dissolution_matrix <- matrix(
  c(25, 45, 65, 80, 90, 95,   # 配方A
    20, 35, 55, 70, 85, 92,   # 配方B
    30, 50, 70, 85, 93, 97,   # 配方C
    22, 40, 60, 75, 88, 94),  # 配方D
  nrow = 4, ncol = 6, byrow = TRUE
)

rownames(drug_dissolution_matrix) <- formulations
colnames(drug_dissolution_matrix) <- dissolution_times

# 自定义颜色调色板
dissolution_colors <- colorRampPalette(c("#2166AC", "#4393C3", "#92C5DE", 
                                         "#D1E5F0", "#F7F7F7", "#FDDBC7", 
                                         "#F4A582", "#D6604D", "#B2182B"))(100)

# 绘制热图
plot_heatmap(drug_dissolution_matrix, dissolution_colors, 
             "药物溶出度热图（%）")

# 保存为PDF文件
pdf(file.path(output_dir, "drug_dissolution_heatmap.pdf"), width = 8, height = 6)
plot_heatmap(drug_dissolution_matrix, dissolution_colors, 
             "药物溶出度热图（%）")
dev.off()

cat("实战3数据可视化完成！所有散点图和热图已保存到文件夹:", output_dir, "\n")