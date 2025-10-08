### **R 语言简约主义编码规范**
#### **一、 核心哲学：KISS (Keep It Simple, Stupid)**
我们的目标是编写能快速、直接解决问题的代码。它应该像一份清晰的草稿，而不是一本厚重的说明书。
1.  **直接性**：代码应直接反映业务逻辑，避免不必要的抽象和间接层。
2.  **简短性**：函数和脚本应尽可能短小，一眼就能看懂。
3.  **可读性优先**：代码首先是写给人看的，其次才是给机器执行的。清晰的命名和结构比巧妙的算法更重要。
4.  **放弃过度防御**：假设调用者和数据都是“友好”的。不进行繁琐的类型检查和异常处理，让 R 自然地报错即可。
---
#### **二、 命名规范：清晰即正义**
命名是为了理解，不是为了规范而规范。
*   **变量 & 函数**：使用 `snake_case`（小写字母加下划线）。
    *   函数名以动词开头，清晰地表达其功能。
    ```r
    # 好的命名
    user_data <- read.csv("users.csv")
    calculate_avg_sales <- function(data) { ... }
    # 不好的命名
    x <- read.csv("users.csv")
    do_stuff <- function(df) { ... }
    ```
*   **常量**：使用 `UPPER_SNAKE_CASE`。用于那些在脚本中基本不会改变的值。
    ```r
    MAX_RETRY_COUNT <- 3
    DEFAULT_FILE_PATH <- "/data/input/"
    ```
*   **文件名**：使用 `snake_case.R`。文件名应与其主要功能或包含的函数相关。
    ```r
    # 好的文件名
    data_cleaning.R
    plot_sales_report.R
    # 不好的文件名
    script_v1_final.R
    temp.R
    ```
---
#### **三、 代码结构与格式：整洁的视觉呈现**
1.  **缩进**：统一使用 **2个空格**，不要使用 Tab。
2.  **行长度**：建议不超过 **80-100** 字符，保持在一屏内可读。
3.  **空格**：
    *   赋值 (`<-`, `=`) 和比较 (`==`, `<`) 运算符前后加空格。
    *   逗号后加空格。
    *   函数调用的括号内侧不加空格。
    ```r
    # 好的格式
    my_data <- filter(df, category == "A" & value > 10)
    result <- my_function(arg1, arg2)
    # 不好的格式
    my_data<-filter(df,category=="A"&value>10)
    result=my_function(arg1,arg2)
    ```
4.  **花括号**：起始花括号 `{` 不换行，结束花括号 `}` 单独一行。
    ```r
    if (condition) {
      # do something
    }
    my_function <- function(x, y) {
      # do something
    }
    ```
5.  **管道操作符**：优先使用原生管道 `|>`，或 `magrittr` 的 `%>%`。每个管道操作符后换行，使逻辑流更清晰。
    ```r
    library(dplyr)
    processed_data <- raw_data |>
      filter(status == "active") |>
      group_by(region) |>
      summarise(total_sales = sum(sales))
    ```
---
#### **四、 函数设计：单一职责，小巧玲珑**
函数是封装逻辑的基本单元，保持其简单性是可维护性的关键。
1.  **单一职责原则**：一个函数只做一件事，并把它做好。
    *   如果函数名需要用 `and` 或 `or`（如 `calculate_and_plot`），说明它可能做了太多事，应该拆分。
2.  **参数**：
    *   参数数量要少，只包含必要的。
    *   为关键参数设置合理的默认值。
    *   **不要**为每个参数都编写详细的类型检查。
3.  **返回值**：
    *   函数应有明确的返回值。
    *   除非逻辑极其简单（单行函数），否则**显式使用 `return()`**，这比依赖隐式返回最后一行表达式更直接、更清晰。
```r
# 好的函数示例
# 功能：筛选出销售额高于平均值的记录
filter_above_avg_sales <- function(data, sales_col) {
  avg_sales <- mean(data[[sales_col]])
  result <- data[data[[sales_col]] > avg_sales, ]
  return(result)
}
# 不好的函数示例（过度设计）
# 功能：一个试图做所有事的“万能”函数
process_data <- function(df, col_to_filter, threshold, operation, ... ) {
  # 大量的 if-else 判断 operation
  # 大量的参数校验
  # ... 复杂的逻辑
  # return(...)
}
```
---
#### **五、 简约主义实践：有所为，有所不为**
1.  **拥抱向量化**：优先使用 R 内置的向量化操作，而不是 `for` 循环。它更简单、更快速。
    ```r
    # 好的：向量化
    squares <- x^2
    # 不好的：循环
    squares <- c()
    for (i in x) {
      squares <- c(squares, i^2)
    }
    ```
2.  **避免过度防御**：
    *   **不要**写大量的 `stopifnot()` 或 `if (!is.numeric(x)) stop(...)`。
    *   **不要**使用 `tryCatch` 来捕获并处理所有可能的错误。让代码在遇到错误时自然中断，R 的错误信息已经足够用于调试。
    *   相信输入数据是干净的，或者用简单的代码清洗即可。
3.  **注释是“为什么”，不是“是什么”**：
    *   不要注释显而易见的代码。
    *   只在代码背后有特殊原因、业务逻辑或临时解决方案时添加注释。
    ```r
    # 不好的注释
    x <- 1 # 将 x 赋值为 1
    # 好的注释
    # 使用 1 作为初始值，因为根据业务规则，新用户都从等级 1 开始
    x <- 1
    ```
---
#### **六、 代码示例对比**
**需求**：计算一个数据框中 `sales` 列的平均值，并筛选出所有高于平均值的记录。
```r
# --- 风格 A：过度工程化（不推荐） ---
analyze_sales_data <- function(df, col_name, filter_logic = "greater_than") {
  # 1. 过度的参数校验
  if (!is.data.frame(df)) {
    stop("Input must be a data frame.")
  }
  if (!col_name %in% names(df)) {
    stop("Column name not found in data frame.")
  }
  if (!is.numeric(df[[col_name]])) {
    stop("Column must be numeric.")
  }
  # 2. 过度的逻辑封装和错误处理
  tryCatch({
    avg_val <- mean(df[[col_name]], na.rm = TRUE)
    cat("The average value is:", avg_val, "\n") # 过度的调试输出
    if (filter_logic == "greater_than") {
      result <- subset(df, df[[col_name]] > avg_val)
    } else if (filter_logic == "less_than") {
      result <- subset(df, df[[col_name]] < avg_val)
    } else {
      stop("Invalid filter_logic specified.")
    }
    return(result)
  }, error = function(e) {
    message("An error occurred during analysis: ", e$message)
    return(NULL)
  })
}
# --- 风格 B：简约主义（推荐） ---
# 直接、简单的函数
filter_above_avg <- function(data, value_col) {
  avg_val <- mean(data[[value_col]])
  return(data[data[[value_col]] > avg_val, ])
}
# 使用 dplyr 管道，更清晰
filter_above_avg_dplyr <- function(data, value_col) {
  data |>
    filter(.data[[value_col]] > mean(.data[[value_col]], na.rm = TRUE))
}
# 使用
# sales_data <- read.csv("sales.csv")
# high_sales <- filter_above_avg(sales_data, "sales")
# high_sales_dplyr <- filter_above_avg_dplyr(sales_data, "sales")
```
**对比分析**：
*   风格 A 代码冗长，充满了大量“以防万一”的检查，使得核心逻辑被淹没。
*   风格 B 代码直击要害，函数名清晰，逻辑一目了然。它假设 `data` 是一个数据框，`value_col` 是存在的数值列。如果假设不成立，R 会自然报错，这足够了。
