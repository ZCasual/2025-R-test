# 实战4 回归分析与综合练习
# 功能：线性回归分析和多种可视化方法的综合应用

# 创建输出文件夹
output_dir <- "s7_a4"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 加载必要的包
library(plotrix)  # 用于绘制3D饼图
library(vioplot)  # 用于绘制小提琴图
library(gplots)  # 用于热图

# 函数：线性回归分析
# 输入：x - 自变量，y - 因变量，title - 图表标题
# 输出：回归模型对象和摘要信息
linear_regression_analysis <- function(x, y, title = "线性回归分析") {
  # 构建线性回归模型
  model <- lm(y ~ x)
  
  # 绘制散点图和回归线
  plot(x, y, 
       pch = 19, col = "blue",
       main = title,
       xlab = "自变量", ylab = "因变量")
  abline(model, col = "red", lwd = 2)
  
  # 添加回归方程和R²
  coef_summary <- summary(model)$coefficients
  r_squared <- summary(model)$r.squared
  
  equation_text <- sprintf("y = %.2fx + %.2f", 
                          coef_summary[2, 1], coef_summary[1, 1])
  r2_text <- sprintf("R² = %.3f", r_squared)
  
  legend("topleft", 
         legend = c(equation_text, r2_text),
         bty = "n")
  
  # 返回模型和摘要
  return(list(model = model, summary = summary(model)))
}

# 函数：预测新数据
# 输入：model - 回归模型，new_x - 新自变量值
# 输出：预测值
predict_new_data <- function(model, new_x) {
  predictions <- predict(model, newdata = data.frame(x = new_x))
  return(predictions)
}

# 示例1：对虾体长-体重回归分析
cat("示例1：对虾体长-体重回归分析\n")
# 模拟数据：对虾体长和体重
shrimp_length <- runif(40, 8, 20)
shrimp_weight <- 0.08 * shrimp_length^2.5 + rnorm(40, 0, 2)

# 进行回归分析
shrimp_result <- linear_regression_analysis(shrimp_length, shrimp_weight, 
                                           "对虾体长-体重回归分析")

# 显示模型摘要
cat("对虾体长-体重回归模型摘要：\n")
print(shrimp_result$summary)

# 预测新数据
new_lengths <- c(10, 15, 18)
predicted_weights <- predict_new_data(shrimp_result$model, new_lengths)
cat("预测体重（体长10, 15, 18cm）：", round(predicted_weights, 2), "g\n")

# 保存为PDF文件
pdf(file.path(output_dir, "shrimp_regression.pdf"), width = 8, height = 6)
shrimp_result <- linear_regression_analysis(shrimp_length, shrimp_weight, 
                                           "对虾体长-体重回归分析")
dev.off()

# 示例2：大肠杆菌生长曲线回归分析
cat("示例2：大肠杆菌生长曲线回归分析\n")
# 模拟数据：大肠杆菌生长曲线
time_points <- 0:36
e_coli_growth <- 100 / (1 + exp(-0.25 * (time_points - 18))) + rnorm(37, 0, 3)

# 进行回归分析（对数生长阶段）
growth_phase <- time_points[10:25]
growth_data <- e_coli_growth[10:25]

e_coli_result <- linear_regression_analysis(growth_phase, growth_data, 
                                            "大肠杆菌生长曲线回归分析")

# 显示模型摘要
cat("大肠杆菌生长曲线回归模型摘要：\n")
print(e_coli_result$summary)

# 保存为PDF文件
pdf(file.path(output_dir, "e_coli_growth_regression.pdf"), width = 8, height = 6)
e_coli_result <- linear_regression_analysis(growth_phase, growth_data, 
                                            "大肠杆菌生长曲线回归分析")
dev.off()

# 示例3：pH-乳酸产量回归分析
cat("示例3：pH-乳酸产量回归分析\n")
# 模拟数据：不同pH下的乳酸产量
ph_values <- seq(5.0, 7.5, by = 0.1)
lactic_acid_yield <- 50 + 20 * sin((ph_values - 5.0) * 2) + rnorm(length(ph_values), 0, 3)

# 进行回归分析
lactic_result <- linear_regression_analysis(ph_values, lactic_acid_yield, 
                                          "pH-乳酸产量回归分析")

# 显示模型摘要
cat("pH-乳酸产量回归模型摘要：\n")
print(lactic_result$summary)

# 保存为PDF文件
pdf(file.path(output_dir, "lactic_acid_regression.pdf"), width = 8, height = 6)
lactic_result <- linear_regression_analysis(ph_values, lactic_acid_yield, 
                                          "pH-乳酸产量回归分析")
dev.off()

# 综合练习：多种可视化方法
cat("综合练习：多种可视化方法\n")

# 1. 3D饼图：草鱼捕获量
cat("1. 绘制草鱼捕获量3D饼图\n")
fish_catch_data <- c(120, 85, 65, 40)
fish_catch_labels <- c("春季", "夏季", "秋季", "冬季")
fish_catch_colors <- c("#A8E6CF", "#DCEDC1", "#FFD3B6", "#FFAAA5")

pdf(file.path(output_dir, "grass_carp_catch_pie3d.pdf"), width = 8, height = 6)
pie3D(fish_catch_data, 
      labels = paste(fish_catch_labels, "\n", 
                    round(fish_catch_data/sum(fish_catch_data)*100, 1), "%"),
      col = fish_catch_colors,
      main = "草鱼捕获量季节分布",
      explode = 0.1)
dev.off()

# 2. 条形图：大黄鱼仔鱼体长增量
cat("2. 绘制大黄鱼仔鱼体长增量条形图\n")
fish_length_increase <- c(2.5, 3.1, 2.8, 3.5, 2.9)
names(fish_length_increase) <- c("第1天", "第2天", "第3天", "第4天", "第5天")

png(file.path(output_dir, "large_yellow_croaker_growth_bar.png"), width = 800, height = 600)
barplot(fish_length_increase, 
        col = c("#74C476", "#41AB5D", "#238B45", "#006D2C", "#00441B"),
        main = "大黄鱼仔鱼体长增量",
        ylab = "体长增量 (cm)",
        ylim = c(0, 4))
dev.off()

# 3. 箱型图：乳酸菌活菌数
cat("3. 绘制乳酸菌活菌数箱型图\n")
lactic_bacteria_data <- list(
  "菌株A" = rnorm(25, 8.5, 0.3),
  "菌株B" = rnorm(25, 9.2, 0.4),
  "菌株C" = rnorm(25, 8.8, 0.35)
)

pdf(file.path(output_dir, "lactic_bacteria_boxplot.pdf"), width = 8, height = 6)
boxplot(lactic_bacteria_data,
        col = c("#FFCDD2", "#C8E6C9", "#BBDEFB"),
        main = "乳酸菌活菌数比较",
        ylab = "活菌数 (log CFU/mL)",
        notch = TRUE)
dev.off()

# 4. 小提琴图：药物溶出度
cat("4. 绘制药物溶出度小提琴图\n")
drug_dissolution_data <- list(
  "配方1" = rnorm(30, 75, 8),
  "配方2" = rnorm(30, 82, 7),
  "配方3" = rnorm(30, 68, 9)
)

png(file.path(output_dir, "drug_dissolution_violin.png"), width = 800, height = 600)
vioplot(drug_dissolution_data,
        col = c("#E1F5FE", "#B3E5FC", "#81D4FA"),
        main = "药物溶出度分布",
        ylab = "溶出度 (%)")
dev.off()

# 5. 热图：枯草芽孢杆菌OD值
cat("5. 绘制枯草芽孢杆菌OD值热图\n")
# 创建数据矩阵
bacillus_od_data <- matrix(
  c(0.2, 0.5, 0.8, 1.2, 1.5,  # 温度25°C
    0.3, 0.7, 1.1, 1.6, 1.9,  # 温度30°C
    0.4, 0.9, 1.4, 1.9, 2.2,  # 温度35°C
    0.3, 0.6, 1.0, 1.4, 1.7), # 温度40°C
  nrow = 4, ncol = 5, byrow = TRUE
)

rownames(bacillus_od_data) <- c("25°C", "30°C", "35°C", "40°C")
colnames(bacillus_od_data) <- c("12h", "24h", "36h", "48h", "60h")

# 自定义颜色调色板
heat_colors <- colorRampPalette(c("#2B83BA", "#ABDDA4", "#FFFFBF", 
                                  "#FDAE61", "#D7191C"))(100)

pdf(file.path(output_dir, "bacillus_od_heatmap.pdf"), width = 8, height = 6)
image(1:5, 1:4, t(bacillus_od_data[4:1, ]),
      col = heat_colors,
      main = "枯草芽孢杆菌OD值热图",
      xlab = "培养时间", ylab = "培养温度",
      axes = FALSE)
axis(1, at = 1:5, labels = colnames(bacillus_od_data))
axis(2, at = 1:4, labels = rownames(bacillus_od_data)[4:1])
box()

# 添加数值标注
for (i in 1:4) {
  for (j in 1:5) {
    text(j, 5 - i, round(bacillus_od_data[i, j], 1), cex = 0.8)
  }
}
dev.off()

# 6. 小麦产量箱型图
cat("6. 绘制小麦产量箱型图\n")
wheat_yield_data <- list(
  "品种A" = rnorm(20, 4500, 300),
  "品种B" = rnorm(20, 5200, 350),
  "品种C" = rnorm(20, 4800, 320)
)

png(file.path(output_dir, "wheat_yield_boxplot.png"), width = 800, height = 600)
boxplot(wheat_yield_data,
        col = c("#D7CCC8", "#A1887F", "#5D4037"),
        main = "小麦产量品种比较",
        ylab = "产量 (kg/ha)",
        notch = TRUE)
dev.off()

cat("实战4回归分析与综合练习完成！\n")
cat("所有回归分析结果和可视化图形已保存到文件夹:", output_dir, "\n")
cat("生成的图形文件包括：\n")
cat("- 回归分析图：shrimp_regression.pdf, e_coli_growth_regression.pdf, lactic_acid_regression.pdf\n")
cat("- 综合练习图：grass_carp_catch_pie3d.pdf, large_yellow_croaker_growth_bar.png\n")
cat("- 综合练习图：lactic_bacteria_boxplot.pdf, drug_dissolution_violin.png\n")
cat("- 综合练习图：bacillus_od_heatmap.pdf, wheat_yield_boxplot.png\n")