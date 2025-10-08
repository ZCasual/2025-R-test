# 第二章 R语言入门
# 基础程序示例

# 创建输出文件夹
output_dir <- "s2"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# Hello World程序
print("Hello, World!")

# 简单数据分析示例 - 年龄与体重
age <- c(25, 30, 35, 40, 45, 50, 55, 60)
weight <- c(65, 70, 75, 78, 80, 82, 79, 76)

# 基础统计分析
mean_age <- mean(age)
mean_weight <- mean(weight)
correlation <- cor(age, weight)

cat("平均年龄:", mean_age, "\n")
cat("平均体重:", mean_weight, "\n")
cat("年龄与体重相关系数:", correlation, "\n")

# 简单可视化
plot(age, weight, 
     main = "年龄与体重关系图",
     xlab = "年龄", ylab = "体重",
     pch = 19, col = "blue")
abline(lm(weight ~ age), col = "red")

# 基因表达数据示例
gene_data <- data.frame(
  sample = c("样本1", "样本2", "样本3", "样本4", "样本5"),
  gene_a = c(10.5, 12.3, 8.7, 15.2, 11.8),
  gene_b = c(5.2, 6.8, 4.1, 7.9, 6.3)
)

# 基因表达分析
mean_gene_a <- mean(gene_data$gene_a)
mean_gene_b <- mean(gene_data$gene_b)

cat("Gene A平均表达量:", mean_gene_a, "\n")
cat("Gene B平均表达量:", mean_gene_b, "\n")

# 基因表达可视化
png(file.path(output_dir, "gene_expression_bar.png"), width = 800, height = 600)
barplot(c(mean_gene_a, mean_gene_b),
        names.arg = c("Gene A", "Gene B"),
        main = "基因表达量对比",
        ylab = "表达量",
        col = c("green", "orange"))
dev.off()

cat("第二章 R语言入门完成！所有结果已保存到文件夹:", output_dir, "\n")