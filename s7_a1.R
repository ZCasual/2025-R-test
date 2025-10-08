# 实战1 数据可视化 - 饼图和条形图
# 功能：绘制2D/3D饼图和条形图，包含误差棒等高级设置

# 创建输出文件夹
output_dir <- "s7_a1"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 加载必要的包
library(plotrix)  # 用于绘制3D饼图

# 函数：绘制2D饼图
# 输入：data - 数据向量，labels - 标签向量，colors - 颜色向量，title - 图表标题
# 输出：无返回值，直接绘制图形
plot_2d_pie <- function(data, labels, colors = NULL, title = "2D饼图") {
  if (is.null(colors)) {
    colors <- rainbow(length(data))
  }
  
  # 计算百分比
  percentages <- round(data / sum(data) * 100, 1)
  labels_with_percent <- paste(labels, "\n", percentages, "%")
  
  # 绘制2D饼图
  pie(data, 
      labels = labels_with_percent,
      col = colors,
      main = title)
}

# 函数：绘制3D饼图
# 输入：data - 数据向量，labels - 标签向量，colors - 颜色向量，title - 图表标题，explode - 炸开效果
# 输出：无返回值，直接绘制图形
plot_3d_pie <- function(data, labels, colors = NULL, title = "3D饼图", explode = 0.1) {
  if (is.null(colors)) {
    colors <- rainbow(length(data))
  }
  
  # 计算百分比
  percentages <- round(data / sum(data) * 100, 1)
  labels_with_percent <- paste(labels, "\n", percentages, "%")
  
  # 绘制3D饼图
  pie3D(data, 
        labels = labels_with_percent,
        col = colors,
        main = title,
        explode = explode,
        labelcex = 0.8)
}

# 函数：绘制条形图（含误差棒）
# 输入：data - 数据向量或矩阵，errors - 误差向量，colors - 颜色向量，title - 图表标题
# 输出：无返回值，直接绘制图形
plot_bar_with_error <- function(data, errors = NULL, colors = NULL, title = "条形图") {
  if (is.null(colors)) {
    colors <- rainbow(length(data))
  }
  
  # 绘制条形图
  bar_positions <- barplot(data, 
                          col = colors,
                          main = title,
                          ylim = c(0, max(data) * 1.2),
                          names.arg = names(data))
  
  # 添加误差棒（如果提供）
  if (!is.null(errors)) {
    arrows(bar_positions, data - errors, 
           bar_positions, data + errors, 
           angle = 90, code = 3, length = 0.1)
  }
}

# 示例1：抗菌药物处方类别饼图
cat("示例1：抗菌药物处方类别饼图\n")
prescription_data <- c(25, 35, 20, 15, 5)
prescription_labels <- c("青霉素类", "头孢菌素", "大环内酯", "喹诺酮", "其他")
prescription_colors <- c("#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4", "#FECA57")

# 绘制2D饼图
plot_2d_pie(prescription_data, prescription_labels, prescription_colors, 
            "抗菌药物处方类别分布")

# 保存为PNG文件
png(file.path(output_dir, "drug_prescription_pie.png"), width = 800, height = 600)
plot_2d_pie(prescription_data, prescription_labels, prescription_colors, 
            "抗菌药物处方类别分布")
dev.off()

# 示例2：作物产量3D饼图
cat("示例2：作物产量3D饼图\n")
crop_yield_data <- c(120, 85, 65, 40, 25)
crop_yield_labels <- c("水稻", "小麦", "玉米", "大豆", "其他")
crop_yield_colors <- c("#A8E6CF", "#DCEDC1", "#FFD3B6", "#FFAAA5", "#FF8B94")

# 绘制3D饼图
plot_3d_pie(crop_yield_data, crop_yield_labels, crop_yield_colors, 
            "作物产量构成", explode = 0.1)

# 保存为PDF文件
pdf(file.path(output_dir, "crop_yield_pie3d.pdf"), width = 8, height = 6)
plot_3d_pie(crop_yield_data, crop_yield_labels, crop_yield_colors, 
            "作物产量构成", explode = 0.1)
dev.off()

# 示例3：大黄鱼仔鱼体长增量条形图
cat("示例3：大黄鱼仔鱼体长增量条形图\n")
fish_length_data <- c(2.5, 3.1, 2.8, 3.5, 2.9)
names(fish_length_data) <- c("第1天", "第2天", "第3天", "第4天", "第5天")
fish_length_errors <- c(0.2, 0.15, 0.18, 0.12, 0.16)

# 绘制条形图（含误差棒）
plot_bar_with_error(fish_length_data, fish_length_errors, 
                    colors = c("#74C476", "#41AB5D", "#238B45", "#006D2C", "#00441B"),
                    title = "大黄鱼仔鱼体长增量")

# 保存为PNG文件
png(file.path(output_dir, "fish_length_increase_bar.png"), width = 800, height = 600)
plot_bar_with_error(fish_length_data, fish_length_errors, 
                    colors = c("#74C476", "#41AB5D", "#238B45", "#006D2C", "#00441B"),
                    title = "大黄鱼仔鱼体长增量")
dev.off()

# 示例4：仔猪肠道菌群Shannon指数条形图
cat("示例4：仔猪肠道菌群Shannon指数条形图\n")
shannon_data <- c(3.2, 3.8, 4.1, 3.5, 3.9)
names(shannon_data) <- c("对照组", "处理组1", "处理组2", "处理组3", "处理组4")
shannon_errors <- c(0.25, 0.18, 0.22, 0.19, 0.16)

# 绘制条形图（含误差棒）
plot_bar_with_error(shannon_data, shannon_errors, 
                    colors = c("#6BAED6", "#4292C6", "#2171B5", "#08519C", "#08306B"),
                    title = "仔猪肠道菌群Shannon指数")

# 保存为PDF文件
pdf(file.path(output_dir, "pig_shannon_bar_error.pdf"), width = 8, height = 6)
plot_bar_with_error(shannon_data, shannon_errors, 
                    colors = c("#6BAED6", "#4292C6", "#2171B5", "#08519C", "#08306B"),
                    title = "仔猪肠道菌群Shannon指数")
dev.off()

cat("实战1数据可视化完成！所有图形已保存到文件夹:", output_dir, "\n")