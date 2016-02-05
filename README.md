# WeCitizens
===

This repo for the iOS Competition 2016 Spring.


## Develop with git


-  拉取自己的分支
-  需要合并时，与develop分支合并
-  版本更新时，用master版本发布
-  具体指令如下：
- 将项目clone到本地
```bash
$ git clone https://github.com/TongjiUAppleClub/WeCitizens.git
```
- 查看当前的分支
```bash
$ git branch
```
- 拉取分支(以我自己为例)
```bash
$ git fetch origin develop:develop
$ git fetch origin harold:harold
```
- 切换分支
```bash
$ git checkout harold
```
- **Merge 相关** 
```bash
$ git checkout develop
$ git pull
$ git merge harold
消除conflict 如果有的话
$ git commit -m""
$ git push origin 本地分支:远端分支
```





