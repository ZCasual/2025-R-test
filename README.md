# R语言数据分析与可视化项目

本项目是一个完整的R语言学习与实践项目，包含基础语法学习、数据处理、统计分析和数据可视化等多个模块。项目按照教学章节组织，每个章节都有对应的R脚本和输出结果。

## 📁 项目结构

```
R/
├── README.md                    # 项目说明文档
├── task.md                      # 章节任务说明
├── test.md                      # 测验题目
├── .gitignore                   # Git忽略文件
├── Rplots.pdf                   # R图形输出
├── s2.R ~ s6.R                  # 基础章节脚本 (第2-6章)
├── s7_a1.R ~ s7_a4.R            # 实战章节脚本 (第7章)
├── t1.R ~ t6.R                  # 测验脚本
├── s2/ ~ s6/                    # 基础章节输出文件夹
├── s7_a1/ ~ s7_a4/              # 实战章节输出文件夹
└── t1/ ~ t6/                    # 测验输出文件夹
```

## 📚 章节说明

### 基础章节 (s2-s6)

| 章节 | 文件名 | 主要内容 | 输出文件夹 |
|------|--------|----------|------------|
| 第2章 | `s2.R` | R语言入门基础 | `s2/` |
| 第3章 | `s3.R` | 数据类型与操作 | `s3/` |
| 第4章 | `s4.R` | 数据准备与导入导出 | `s4/` |
| 第5章 | `s5.R` | 基础数据可视化 | `s5/` |
| 第6章 | `s6.R` | R语言统计分析 | `s6/` |

### 实战章节 (s7_a1-s7_a4)

| 章节 | 文件名 | 主要内容 | 输出文件夹 |
|------|--------|----------|------------|
| 实战1 | `s7_a1.R` | 饼图和条形图 | `s7_a1/` |
| 实战2 | `s7_a2.R` | 箱型图和小提琴图 | `s7_a2/` |
| 实战3 | `s7_a3.R` | 散点图和热图 | `s7_a3/` |
| 实战4 | `s7_a4.R` | 回归分析与综合练习 | `s7_a4/` |

### 测验章节 (t1-t6)

| 测验 | 文件名 | 主要内容 | 输出文件夹 |
|------|--------|----------|------------|
| 测验1 | `t1.R` | 3D饼图展示河蟹捕获量 | `t1/` |
| 测验2 | `t2.R` | 条形图展示大黄鱼育苗结果 | `t2/` |
| 测验3 | `t3.R` | 箱型图比较乙醇产量 | `t3/` |
| 测验4 | `t4.R` | 小提琴图比较药物释放度 | `t4/` |
| 测验5 | `t5.R` | 散点图展示SPAD与产量关系 | `t5/` |
| 测验6 | `t6.R` | 热图展示血糖均值矩阵 | `t6/` |

## 🚀 快速开始

### 环境要求

- R语言版本：4.0+
- 操作系统：Windows/macOS/Linux

### 安装依赖包

使用清华源快速安装所有必要的R包：

```r
# 设置清华镜像源
options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))

# 安装基础包
install.packages(c("plotrix", "vioplot", "gplots", "openxlsx", "RODBC", "showtext"))

# 加载包
library(plotrix)    # 3D饼图
library(vioplot)    # 小提琴图
library(gplots)     # 热图
library(openxlsx)   # Excel文件操作
library(RODBC)      # 数据库连接
library(showtext)   # 中文字体支持
```

### 运行脚本

```r
# 运行基础章节
source("s2.R")  # 第2章：R语言入门
source("s3.R")  # 第3章：数据类型
source("s4.R")  # 第4章：数据准备
source("s5.R")  # 第5章：数据可视化
source("s6.R")  # 第6章：统计分析

# 运行实战章节
source("s7_a1.R")  # 实战1：饼图和条形图
source("s7_a2.R")  # 实战2：箱型图和小提琴图
source("s7_a3.R")  # 实战3：散点图和热图
source("s7_a4.R")  # 实战4：回归分析与综合练习

# 运行测验章节
source("t1.R")  # 测验1：3D饼图
source("t2.R")  # 测验2：条形图
source("t3.R")  # 测验3：箱型图
source("t4.R")  # 测验4：小提琴图
source("t5.R")  # 测验5：散点图
source("t6.R")  # 测验6：热图
```

## 🛠️ 技术栈

### 核心R包
- **基础包**: stats, graphics, utils
- **数据处理**: openxlsx, RODBC
- **可视化**: plotrix, vioplot, gplots
- **字体支持**: showtext

### 文件格式支持
- **数据文件**: CSV, Excel (.xlsx), 文本文件
- **图形输出**: PNG, PDF
- **配置文件**: R脚本 (.R)

## 🔧 常见问题

### Q: 如何解决中文字体显示问题？
```r
# 安装并配置showtext包
install.packages("showtext")
library(showtext)
showtext_auto()

# 在绘图函数中指定中文字体
pdf("output.pdf", family = "GB1")
# 绘图代码
dev.off()
```

### Q: 如何修改图形输出路径？
```r
# 在每个脚本开头修改output_dir变量
output_dir <- "my_output_folder"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}
```

### Q: 如何添加新的数据分析功能？
```r
# 在现有函数基础上扩展
my_analysis_function <- function(data, parameters) {
  # 添加你的分析逻辑
  result <- your_analysis_code(data, parameters)
  return(result)
}
```

## 📈 输出示例

项目包含丰富的图形输出示例：

- **基础图形**: 散点图、饼图、条形图
- **统计图形**: 箱型图、小提琴图、热图
- **分析图形**: 回归分析图、分布图

所有图形都保存在对应的输出文件夹中，格式包括PNG和PDF。
