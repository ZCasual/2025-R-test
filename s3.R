# 第三章 数据类型
# R语言基础数据类型操作

# 创建输出文件夹
output_dir <- "s3"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("创建文件夹:", output_dir, "\n")
}

# 变量命名与赋值
my_variable <- 42
another_variable = "Hello R"
x <- 100  # 变量赋值

# 数学运算符
a <- 10
b <- 3
cat("加法:", a + b, "\n")
cat("减法:", a - b, "\n")
cat("乘法:", a * b, "\n")
cat("除法:", a / b, "\n")
cat("整除:", a %/% b, "\n")
cat("余数:", a %% b, "\n")
cat("幂运算:", a^b, "\n")

# 关系运算符
cat("等于:", a == b, "\n")
cat("不等于:", a != b, "\n")
cat("大于:", a > b, "\n")
cat("小于:", a < b, "\n")

# 逻辑运算符
x <- TRUE
y <- FALSE
cat("逻辑与:", x & y, "\n")
cat("逻辑或:", x | y, "\n")
cat("逻辑非:", !x, "\n")

# 常量
na_value <- NA
inf_value <- Inf
neg_inf_value <- -Inf

# 向量操作
numeric_vector <- c(1, 2, 3, 4, 5)
character_vector <- c("a", "b", "c", "d", "e")
logical_vector <- c(TRUE, FALSE, TRUE, FALSE, TRUE)

cat("数值向量:", numeric_vector, "\n")
cat("字符向量:", character_vector, "\n")
cat("逻辑向量:", logical_vector, "\n")

# 矩阵创建
matrix_data <- matrix(1:12, nrow = 3, ncol = 4)
cat("矩阵:\n")
print(matrix_data)

# 数组创建
array_data <- array(1:24, dim = c(3, 4, 2))
cat("数组:\n")
print(array_data)

# 数据框创建
data_frame <- data.frame(
  name = c("张三", "李四", "王五"),
  age = c(25, 30, 28),
  score = c(85.5, 92.3, 78.9)
)
cat("数据框:\n")
print(data_frame)

# 列表创建
my_list <- list(
  numbers = 1:5,
  text = "Hello",
  logical = TRUE,
  nested = list(a = 1, b = 2)
)
cat("列表:\n")
print(my_list)

# 因子创建
category <- c("低", "中", "高", "中", "低")
factor_data <- factor(category, levels = c("低", "中", "高"))
cat("因子:\n")
print(factor_data)

# 字符串操作
text <- "Hello World"
cat("字符串长度:", nchar(text), "\n")
cat("字符串合并:", paste("Hello", "R", sep = " "), "\n")
cat("字符串分割:", strsplit("a,b,c", ",")[[1]], "\n")
cat("字符串截取:", substr("Hello World", 1, 5), "\n")
cat("字符串替换:", gsub("World", "R", "Hello World"), "\n")
cat("大写转换:", toupper("hello"), "\n")
cat("小写转换:", tolower("HELLO"), "\n")

# 常用统计函数
numbers <- c(10, 20, 30, 40, 50)
cat("求和:", sum(numbers), "\n")
cat("均值:", mean(numbers), "\n")
cat("标准差:", sd(numbers), "\n")
cat("排序:", sort(c(5, 2, 8, 1, 9)), "\n")
cat("顺序:", order(c(5, 2, 8, 1, 9)), "\n")

# 保存数据框为CSV文件
write.csv(data_frame, file.path(output_dir, "学生数据.csv"), row.names = FALSE)

# 保存向量数据
vector_data <- data.frame(
  数值向量 = numeric_vector,
  字符向量 = character_vector,
  逻辑向量 = logical_vector
)
write.csv(vector_data, file.path(output_dir, "向量数据.csv"), row.names = FALSE)

cat("第三章 数据类型完成！所有结果已保存到文件夹:", output_dir, "\n")