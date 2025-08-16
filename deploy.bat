@echo off
setlocal enabledelayedexpansion

rem ===== 用户配置区域 =====
set "TARGET_DIR=./out"   rem 替换为您的目标文件夹路径
set "REMOTE_URL=https://github.com/nihaopeng/nihaopeng.github.io.git"  rem 替换为您的远程仓库URL
set "COMMIT_MSG=commit"                rem 自定义提交信息
set "BRANCH=master"                       rem 指定分支名称(main/master)
set "SRC_BRANCH=src"
set "VIR_SCRIPT_DIR=.\.venv\Scripts\"
rem =======================

echo 构建内容中
%VIR_SCRIPT_DIR%teedoc build

echo 正在初始化Git仓库...
cd /d "%TARGET_DIR%"
@REM git init
@REM if errorlevel 1 (
@REM     echo 错误: Git初始化失败
@REM     exit /b 1
@REM )

echo 添加所有文件到暂存区...
git add .
if errorlevel 1 (
    echo 错误: 添加文件失败
    exit /b 1
)

echo 提交更改...
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo 警告: 提交失败(可能是空仓库或无新文件)
)

echo 绑定远程仓库...
@REM git remote remove origin 2>nul
@REM git remote add origin "%REMOTE_URL%"
@REM if errorlevel 1 (
@REM     echo 错误: 远程仓库绑定失败
@REM     exit /b 1
@REM )

echo 强制推送到远程仓库(%BRANCH%分支)...
git push --force origin %BRANCH%
if errorlevel 1 (
    echo 错误: 推送失败
    exit /b 1
)

echo 推送源文件...
cd ..

echo 添加所有文件到暂存区...
git add .
if errorlevel 1 (
    echo 错误: 添加文件失败
    exit /b 1
)

echo 提交更改...
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo 警告: 提交失败(可能是空仓库或无新文件)
)

echo 推送到远程仓库(%SRC_BRANCH%分支)...
git push origin %SRC_BRANCH%
if errorlevel 1 (
    echo 错误: 推送失败
    exit /b 1
)

echo 操作成功完成!
timeout /t 3 >nul
endlocal