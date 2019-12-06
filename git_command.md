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


