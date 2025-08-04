---
title: BLKRv
---

<html>
<head>
<meta charset="utf-8">
<style>
    .expandable-list {
        width: 300px;
        margin: 20px;
        font-family: Arial, sans-serif;
    }
    details {
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-bottom: 10px;
        padding: 10px;
        background-color: #f9f9f9;
    }
    summary {
        font-weight: bold;
        cursor: pointer;
        padding: 8px;
        list-style: none;
        position: relative; /* 为图标定位提供参考 */
    }
    summary::-webkit-details-marker {
        display: none;
    }
    summary:after {
        content: "▼";
        position: absolute;
        right: 10px;
        font-size: 12px;
        transition: transform 0.3s ease; /* 添加旋转动画 */
    }
    details:hover {
        background-color: #f5f8ff; /* 浅蓝色背景 */
        border-color: #c2d6ff;     /* 边框高亮 */
        box-shadow: 0 4px 12px rgba(0,0,0,0.1); /* 立体阴影 */
        transition: all 0.3s ease; /* 平滑过渡 */
    }
    summary:hover {
        color: #1a73e8;           /* 文字变蓝 */
        background-color: #e6eeff; /* 标题背景渐变 */
    }
    a.link {
        display: block; /* 设置为块级元素[1,2](@ref) */
        padding: 12px 15px;
        margin: 8px 0;
        background-color: #fff;
        border-radius: 4px;
        color: #1a73e8;
        text-decoration: none;
        transition: all 0.3s ease;
        border: 1px solid #eaeaea;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    a.link:hover {
        background-color: #f5f8ff; /* 悬停背景色[5](@ref) */
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-color: #c2d6ff;
    }
    a.link:active {
        background-color: #e6eeff; /* 点击效果[4](@ref) */
        transform: translateY(0);
    }
</style>
</head>
<body>
    <div class="expandable-list">
    <details>
        <summary>blkrv</summary>
        <a class="link" href="\docs\tutorial\blkrv\quickstart\quickstart.html">quickstart</a>
        <details>
            <summary>进阶</summary>
            <a class="link" href="\docs\tutorial\blkrv\进阶\寄存器\README.html">寄存器</a>
            <a class="link" href="\docs\tutorial\blkrv\进阶\外设\README.html">外设</a>
            <a class="link" href="\docs\tutorial\blkrv\进阶\MMU\README.html">MMU</a>
            <a class="link" href="\docs\tutorial\blkrv\进阶\RIB-BUS\README.html">RIB-BUS</a>
            <a class="link" href="\docs\tutorial\blkrv\进阶\wrapper\README.html">Wrapper</a>
        </details>
        <details>
            <summary>tools</summary>
                <a class="link" href="\docs\tutorial\blkrv\tools\fltk\fltk.html">fltk</a>
                <a class="link" href="\docs\tutorial\blkrv\tools\mingw\mingw.html">mingw</a>
                <a class="link" href="\docs\tutorial\blkrv\tools\riscv-elf-unknown-gcc\gcc.html">riscv交叉编译链</a>
                <a class="link" href="\docs\tutorial\blkrv\tools\verilator\verilator.html">second-Tier-memory</a>
            </details>
        </details>
    </details>
</div>
</body>
</html>
