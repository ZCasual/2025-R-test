# 第六章 R语言统计
# 基础统计分析

# 创建输出文件夹
output_dir <- "s6"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 1. 均值计算
data_with_na <- c(10, 20, 30, NA, 40, 50)
cat("原始数据:", data_with_na, "\n")

# 计算均值（包含NA）
mean_with_na <- mean(data_with_na)
cat("包含NA的均值:", mean_with_na, "\n")

# 计算均值（去除NA）
mean_without_na <- mean(data_with_na, na.rm = TRUE)
cat("去除NA的均值:", mean_without_na, "\n")

# 使用trim参数（去除两端值）
trimmed_mean <- mean(c(1, 2, 3, 4, 5, 100), trim = 0.1)
cat("修剪均值（trim=0.1）:", trimmed_mean, "\n")

# 2. 中位数计算
median_with_na <- median(data_with_na)
cat("包含NA的中位数:", median_with_na, "\n")

median_without_na <- median(data_with_na, na.rm = TRUE)
cat("去除NA的中位数:", median_without_na, "\n")

# 3. 线性回归分析
# 创建示例数据
set.seed(123)
x <- 1:20
y <- 2 * x + 3 + rnorm(20, 0, 5)
regression_data <- data.frame(x = x, y = y)

# 构建线性回归模型
model <- lm(y ~ x, data = regression_data)
cat("线性回归模型:\n")
print(model)

# 查看模型详细信息
cat("\n模型摘要:\n")
summary_model <- summary(model)
print(summary_model)

# 提取关键统计量
cat("\n关键统计量:\n")
cat("R-squared:", summary_model$r.squared, "\n")
cat("调整R-squared:", summary_model$adj.r.squared, "\n")
cat("p值:", summary_model$coefficients[2, 4], "\n")

# 预测新数据
new_data <- data.frame(x = c(21, 22, 23))
predictions <- predict(model, newdata = new_data)
cat("\n预测值:\n")
print(predictions)

# 可视化回归结果
png(file.path(output_dir, "线性回归分析.png"), width = 800, height = 600)
plot(x, y, 
     main = "线性回归分析",
     xlab = "X", ylab = "Y",
     pch = 19, col = "blue")
abline(model, col = "red", lwd = 2)
dev.off()

# 保存回归结果
regression_results <- data.frame(
  x = x,
  y = y,
  predicted = predict(model),
  residuals = residuals(model)
)
write.csv(regression_results, file.path(output_dir, "回归分析结果.csv"), row.names = FALSE)

# 4. 卡方检验
# 创建列联表数据
if ("MASS" %in% rownames(installed.packages())) {
  library(MASS)
  # 使用Cars93数据集
  if (exists("Cars93")) {
    # 创建2x2列联表
    contingency_table <- table(Cars93$AirBags, Cars93$Type)
    cat("\n列联表:\n")
    print(contingency_table)
    
    # 执行卡方检验
    chi_test <- chisq.test(contingency_table)
    cat("\n卡方检验结果:\n")
    print(chi_test)
    
    # 提取检验统计量
    cat("\n检验统计量:\n")
    cat("卡方值:", chi_test$statistic, "\n")
    cat("自由度:", chi_test$parameter, "\n")
    cat("p值:", chi_test$p.value, "\n")
  }
} else {
  # 如果没有Cars93数据集，使用模拟数据
  # 创建模拟数据
  airbags <- sample(c("None", "Driver only", "Driver & Passenger"), 100, replace = TRUE)
  car_type <- sample(c("Small", "Midsize", "Large"), 100, replace = TRUE)
  
  contingency_table <- table(airbags, car_type)
  cat("\n模拟列联表:\n")
  print(contingency_table)
  
  # 执行卡方检验
  chi_test <- chisq.test(contingency_table)
  cat("\n卡方检验结果:\n")
  print(chi_test)
}