# 实战2 数据可视化 - 箱型图和小提琴图
# 功能：绘制箱型图和小提琴图，用于数据分布分析

# 创建输出文件夹
output_dir <- "s7_a2"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 加载必要的包
library(vioplot)  # 用于小提琴图

# 函数：绘制箱型图
# 输入：data_list - 数据列表，colors - 颜色向量，title - 图表标题，notch - 是否显示中位数差异
# 输出：无返回值，直接绘制图形
plot_boxplot <- function(data_list, colors = NULL, title = "箱型图", notch = FALSE) {
  if (is.null(colors)) {
    colors <- rainbow(length(data_list))
  }
  
  # 绘制箱型图
  boxplot(data_list,
          col = colors,
          main = title,
          notch = notch,
          outline = TRUE,
          boxwex = 0.6)
}

# 函数：绘制小提琴图
# 输入：data_list - 数据列表，colors - 颜色向量，title - 图表标题
# 输出：无返回值，直接绘制图形
plot_violin <- function(data_list, colors = NULL, title = "小提琴图") {
  if (is.null(colors)) {
    colors <- rainbow(length(data_list))
  }
  
  # 绘制小提琴图
  vioplot(data_list,
          col = colors,
          main = title,
          names = names(data_list))
}

# 示例1：运输密度对大黄鱼皮质醇的影响
cat("示例1：运输密度对大黄鱼皮质醇的影响\n")
# 模拟数据：不同运输密度下的皮质醇水平
low_density <- rnorm(30, mean = 15, sd = 3)
medium_density <- rnorm(30, mean = 25, sd = 4)
high_density <- rnorm(30, mean = 35, sd = 5)

cortisol_data <- list(
  "低密度" = low_density,
  "中密度" = medium_density,
  "高密度" = high_density
)

cortisol_colors <- c("#E1F5FE", "#81D4FA", "#0288D1")

# 绘制箱型图
plot_boxplot(cortisol_data, cortisol_colors, 
             "运输密度对大黄鱼皮质醇的影响", notch = TRUE)

# 保存为PNG文件
png(file.path(output_dir, "fish_cortisol_boxplot.png"), width = 800, height = 600)
plot_boxplot(cortisol_data, cortisol_colors, 
             "运输密度对大黄鱼皮质醇的影响", notch = TRUE)
dev.off()

# 示例2：溶氧对红霉素效价的影响
cat("示例2：溶氧对红霉素效价的影响\n")
# 模拟数据：不同溶氧水平下的红霉素效价
low_oxygen <- rnorm(25, mean = 1200, sd = 150)
medium_oxygen <- rnorm(25, mean = 1800, sd = 200)
high_oxygen <- rnorm(25, mean = 2200, sd = 180)

erythromycin_data <- list(
  "低溶氧" = low_oxygen,
  "中溶氧" = medium_oxygen,
  "高溶氧" = high_oxygen
)

erythromycin_colors <- c("#FFCDD2", "#EF9A9A", "#E57373")

# 绘制箱型图
plot_boxplot(erythromycin_data, erythromycin_colors, 
             "溶氧对红霉素效价的影响", notch = FALSE)

# 保存为PDF文件
pdf(file.path(output_dir, "erythromycin_oxygen_boxplot.pdf"), width = 8, height = 6)
plot_boxplot(erythromycin_data, erythromycin_colors, 
             "溶氧对红霉素效价的影响", notch = FALSE)
dev.off()

# 示例3：土壤水分对小麦产量的影响
cat("示例3：土壤水分对小麦产量的影响\n")
# 模拟数据：不同土壤水分下的小麦产量
dry_soil <- rnorm(20, mean = 3500, sd = 300)
optimal_soil <- rnorm(20, mean = 4800, sd = 250)
wet_soil <- rnorm(20, mean = 4200, sd = 280)

wheat_yield_data <- list(
  "干燥土壤" = dry_soil,
  "适宜水分" = optimal_soil,
  "湿润土壤" = wet_soil
)

wheat_colors <- c("#D7CCC8", "#A1887F", "#5D4037")

# 绘制箱型图
plot_boxplot(wheat_yield_data, wheat_colors, 
             "土壤水分对小麦产量的影响", notch = TRUE)

# 保存为PNG文件
png(file.path(output_dir, "wheat_yield_boxplot.png"), width = 800, height = 600)
plot_boxplot(wheat_yield_data, wheat_colors, 
             "土壤水分对小麦产量的影响", notch = TRUE)
dev.off()

# 示例4：花鲈血清渗透压小提琴图
cat("示例4：花鲈血清渗透压小提琴图\n")
# 模拟数据：不同处理组的花鲈血清渗透压
control_group <- rnorm(35, mean = 320, sd = 25)
treatment_1 <- rnorm(35, mean = 350, sd = 30)
treatment_2 <- rnorm(35, mean = 380, sd = 28)

serum_osmolarity_data <- list(
  "对照组" = control_group,
  "处理组1" = treatment_1,
  "处理组2" = treatment_2
)

serum_colors <- c("#C8E6C9", "#81C784", "#4CAF50")

# 绘制小提琴图
plot_violin(serum_osmolarity_data, serum_colors, 
            "花鲈血清渗透压分布")

# 保存为PNG文件
png(file.path(output_dir, "fish_serum_violin.png"), width = 800, height = 600)
plot_violin(serum_osmolarity_data, serum_colors, 
            "花鲈血清渗透压分布")
dev.off()

# 示例5：地衣芽孢杆菌蛋白酶活性小提琴图
cat("示例5：地衣芽孢杆菌蛋白酶活性小提琴图\n")
# 模拟数据：不同培养条件下的蛋白酶活性
condition_a <- rnorm(30, mean = 45, sd = 8)
condition_b <- rnorm(30, mean = 65, sd = 10)
condition_c <- rnorm(30, mean = 55, sd = 9)

protease_activity_data <- list(
  "条件A" = condition_a,
  "条件B" = condition_b,
  "条件C" = condition_c
)

protease_colors <- c("#F8BBD0", "#F48FB1", "#EC407A")

# 绘制小提琴图
plot_violin(protease_activity_data, protease_colors, 
            "地衣芽孢杆菌蛋白酶活性分布")

# 保存为PNG文件
png(file.path(output_dir, "bacteria_protease_violin.png"), width = 800, height = 600)
plot_violin(protease_activity_data, protease_colors, 
            "地衣芽孢杆菌蛋白酶活性分布")
dev.off()

# 示例6：药物溶出度小提琴图
cat("示例6：药物溶出度小提琴图\n")
# 模拟数据：不同时间点的药物溶出度
time_15min <- rnorm(25, mean = 25, sd = 5)
time_30min <- rnorm(25, mean = 45, sd = 6)
time_45min <- rnorm(25, mean = 65, sd = 7)
time_60min <- rnorm(25, mean = 80, sd = 8)

drug_dissolution_data <- list(
  "15分钟" = time_15min,
  "30分钟" = time_30min,
  "45分钟" = time_45min,
  "60分钟" = time_60min
)

dissolution_colors <- c("#B3E5FC", "#4FC3F7", "#03A9F4", "#0288D1")

# 绘制小提琴图
plot_violin(drug_dissolution_data, dissolution_colors, 
            "药物溶出度分布")

# 保存为PNG文件
png(file.path(output_dir, "drug_dissolution_violin.png"), width = 800, height = 600)
plot_violin(drug_dissolution_data, dissolution_colors, 
            "药物溶出度分布")
dev.off()

cat("实战2数据可视化完成！所有箱型图和小提琴图已保存到文件夹:", output_dir, "\n")