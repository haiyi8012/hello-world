## clone 上传本地代码
```
git clone https://github.com/haiyi8012/global-region-demo.git
＃以后每次提交代码，只需重复以下命令：
$ git add .
$ git commit -m"提交描述"
$ git push
```
## ssh 上传本地代码
```
$ git config --global user.name "Your Name"
$ git config --global user.email "xxxxxxx@qq.com"

$ ssh-keygen -t rsa -C "xxxxxxx@qq.com"

按照下图步骤，依次点击Setting》SSH and GPG keys进入SSH Key设置页面
点击New SSH key新增SSH keys，title可以随意填写，Key填写刚刚复制的内容，然后保存。

git init
git remote add origin 83109357@qq.com:haiyi8012/demo.git
＃以后每次提交代码，只需重复以下命令：
$ git add .
$ git commit -m"提交描述"
$ git push origin master
```

## 常用
git commit -**a**m "new55"

git push origin master

1.查看分支
git branch -a 查看所有本地和远程分支
git branch 查看本地分支
git branch -r 查看远程分支

2.切换分支

git checkout <BranchName>

3.删除分支
git branch -d <BranchName> 删除本地分支
git push origin --delete <BranchName> 删除远程分支
git push origin : <BranchName>

4.删除文件
git clean -n 查看将会删除哪些文件（不会真正删除)
Git clean -f 删除当前目录下没有track过的文件
git clean -df 删除当前目录下没有track过的文件和文件夹
git restet --hard 重置到上次commit的记录，后面修改的文件和新增的文件不会被track ,配合 git clean -df 回到上次提交的commit时的内容。

5.取消暂存（track）

git restore --staged <FileName>

6.加入暂存
git add. 点是全部修改新增文件暂存
git add <FileName> 暂存对应文件

7.查看当前状态

git status

8.提交文件到本地

git commit

9.推送文件到远程

git push

10.更新远程分支列表
git remote update --prune
git remote update -p



## Git学习笔记
https://www.jianshu.com/p/371e3f9d0535

## 如何解决error: failed to push some refs
```
$ git push -u origin master
To github.com:a653398363/testtest.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@github.com:a653398363/testtest.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```
1、在使用git 对源代码进行push到gitHub时可能会出错

2、出现错误的主要原因是github中的README.md文件不在本地代码目录中

3、可以通过如下命令进行代码合并【注：pull=fetch+merge]

git pull --rebase origin master

4、执行上面代码后可以看到本地代码库中多了README.md文件

5、此时再执行语句 git push 即可完成代码上传到github



## 将本地项目上传到github
```
git init
git add *
git commit -m "代码提交信息"
git status
git add new_dir
git commit -m "first commit"
git remote add origin https://github.com/haiyi8012/test.git
git push -u origin master

```

## 参考该文档：https://www.bootcss.com/p/git-guide/
```
git init

git clone /path/to/repository or git clone username@host:/path/to/repository

git add <filename> or git add *

git commit -m "代码提交信息"

git push origin master

git remote add origin <server>
如果你还没有克隆现有仓库，并欲将你的仓库连接到某个远程服务器

分支：
git checkout -b feature_x
git checkout master
git branch -d feature_x
git push origin <branch>
```

如何用git将项目代码上传到github
https://www.cnblogs.com/cxscode/p/8325064.html


