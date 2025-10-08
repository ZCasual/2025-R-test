# 测验题四：小提琴图比较缓控释片剂释放度
# 功能：用小提琴图比较4处方释放度分布，并保存为PNG

# 加载必要的包
library(vioplot)

# 创建输出目录
output_dir <- "t4"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# 数据准备
prescription_A <- c(78,80,82,79,81,83,80,78,82,81,79,80,83,81,79,80,82,78,81,80)
prescription_B <- c(65,68,70,66,69,67,68,66,70,69,67,68,70,66,68,69,67,70,68,66)
prescription_C <- c(72,75,74,73,76,74,73,75,74,76,73,74,75,73,76,74,75,73,74,75)
prescription_D <- c(58,60,59,57,61,59,60,58,59,60,57,59,61,58,60,59,57,60,58,59)

# 手动设定4种颜色区分原研/仿制
custom_colors <- c("#2ECC71", "#E74C3C", "#3498DB", "#F39C12")  # 原研绿色，仿制其他颜色

# 生成小提琴图
png(file = file.path(output_dir, "缓控释片剂释放度小提琴图.png"), 
    width = 800, height = 600, res = 100)

# 设置图形参数
par(mar = c(5, 5, 4, 2) + 0.1)

# 创建小提琴图
vioplot(prescription_A, prescription_B, prescription_C, prescription_D,
        names = c("A(原研)", "B(仿制1)", "C(仿制2)", "D(仿制3)"),
        col = custom_colors,
        xlab = "处方",
        ylab = "8h累积释放百分比 (%)",
        main = "不同处方缓控释片剂8h累积释放度分布")

dev.off()

cat("小提琴图已保存至", file.path(output_dir, "缓控释片剂释放度小提琴图.png"), "\n")