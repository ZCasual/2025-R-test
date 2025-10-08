# 第四章 数据准备
# 数据导入导出操作

# 创建输出文件夹
output_dir <- "s4"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 安装必要的包（如未安装）
# install.packages("openxlsx")
# install.packages("RODBC")

# 加载包
library(openxlsx)

# 1. 通过edit()函数键盘输入数据
cat("使用edit()函数创建数据框:\n")
manual_data <- data.frame(
  学生姓名 = character(0),
  年龄 = numeric(0),
  成绩 = numeric(0)
)
# edit(manual_data)  # 交互式编辑，注释掉避免运行时阻塞

# 2. 创建示例数据并导出为Excel文件
sample_students <- data.frame(
  学生姓名 = c("张三", "李四", "王五", "赵六"),
  年龄 = c(20, 21, 19, 22),
  成绩 = c(85.5, 92.3, 78.9, 88.7),
  班级 = c("一班", "二班", "一班", "三班")
)

# 导出为Excel文件
write.xlsx(sample_students, file.path(output_dir, "学生数据.xlsx"))
cat("数据已导出到:", file.path(output_dir, "学生数据.xlsx"), "\n")

# 3. 从Excel文件导入数据
imported_data <- read.xlsx(file.path(output_dir, "学生数据.xlsx"))
cat("从Excel导入的数据:\n")
print(imported_data)

# 4. 创建文本文件示例
text_content <- "姓名,年龄,成绩\n张三,20,85.5\n李四,21,92.3\n王五,19,78.9"
writeLines(text_content, file.path(output_dir, "abc.txt"))
cat("文本文件已创建:", file.path(output_dir, "abc.txt"), "\n")

# 5. 读取文本文件
read_data <- read.csv(file.path(output_dir, "abc.txt"))
cat("从文本文件读取的数据:\n")
print(read_data)

# 6. 查看包信息
cat("R包安装目录:\n")
print(.libPaths())

cat("已安装的包（部分）:\n")
print(installed.packages()[1:5, c("Package", "Version")])

# 7. 数据框操作示例
# 排序
sorted_data <- sample_students[order(sample_students$成绩, decreasing = TRUE), ]
cat("按成绩排序:\n")
print(sorted_data)

# 筛选
filtered_data <- subset(sample_students, 成绩 > 85)
cat("成绩大于85的学生:\n")
print(filtered_data)

# 分组统计
class_summary <- aggregate(成绩 ~ 班级, data = sample_students, FUN = mean)
cat("各班级平均成绩:\n")
print(class_summary)

cat("第四章 数据准备完成！所有结果已保存到文件夹:", output_dir, "\n")