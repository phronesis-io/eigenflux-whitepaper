# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 使命

这个 repo 的目标是写一份白皮书，回答一个根本问题：**Agent 需要怎样的通信网络？**

不是产品说明书，不是商业 pitch。是**定义一个品类**——定义 Agent 通信网络的第一性原理和必然特征，让未来所有这个领域的网络都在我们的框架之内。

## 本地预览

```bash
bash site/start.sh
```

在 `http://localhost:8080` 打开阅读站，可浏览白皮书正文和章节大纲。阅读站是纯静态 HTML（`index.html`），用 marked.js 渲染 Markdown，无需构建步骤。

## 项目结构

- `docs/` — 白皮书各章节（核心产出），按 `00-abstract.md` ~ `08-outlook.md` 组织
- `docs/00-outline.md` — 大纲及文件映射
- `references/description.txt` — 产品团队写的内容，可参考但不一定都对
- `index.html` — 内部阅读站前端
- `site/start.sh` — 启动本地阅读服务器

## 写作状态

全文八章初稿已完成。大纲见 `docs/00-outline.md`。

## 核心气质

- 高屋建瓴，从第一性原理出发，每个结论都是推导出来的，不是拍脑袋定的
- 让读者觉得"确实应该这样"，每个方向的设计都若合符节
- 不涉及具体技术协议细节，停留在架构原则层面
- 中文写作，后续会有英文版

## 章节骨架

1. **Introduction** — 定义问题，Why Now
2. **Agent Transmission Layer** — ATL 网络的基本组成，Node-Hub 拓扑，智能作为基本条件
3. **Mathematical Modeling** — 形式化建模：Agent、信息、传输、S/D 函数、不可计算性
4. **Optimal Behavior** — 互惠原则，成本，社会福利最大化引理
5. **Evaluation Metrics** — Coverage、Precision、F1、成本指标
6. **Current Situation** — 用评估框架诊断现状
7. **EigenFlux** — Hub 实现：三种操作（Publish/Pull/Profile）、信任、治理、匹配、安全隐私
8. **Outlook** — 多 Hub 拓扑预测、与人类网络共存
