# init_project.sh

## 前提
対応Shell：bash, zsh  
*gitインストール済みであること  
*GitHub CLI設定済みであること  
※GitHubリモート接続 / GitHub CLI の初期設定はご自身でお願いします。  
  
   
## 使用方法
以下のコマンドでホームディレクトリにスクリプトを作成します。  
```curl https://raw.githubusercontent.com/MasaoSasaki/init_project/main/init_project.sh > ~/init_project.sh ; chmod 755 ~/init_project.sh```  
  
以下のコマンドでスクリプトを実行すると、カレントディレクトリにプロジェクトディレクトリとGitHubに同名の新規リポジトリが作成されます。  
```~/init_project.sh <プロジェクト名>```  
  
例:
```
$ pwd /User/username/my-project  
$ ls  
project1 project2 project3 project4  
$ ~/init_project.sh project5  
(省略)  
$ ls  
project1 project2 project3 project4 project5  
```
  
  
## 留意点
リポジトリに使える文字（記号）には制限があるため、スクリプトの引数に指定した名前とGitHubリポジトリの名前が一部変更されることがあります。  
  
例:  
```
$ ~/init_project.sh test~test  
$ ls  
test~test  
$ cd test~test
$ git remote -v  
origin  git@github.com:USER/test-test.git (fetch)  
origin  git@github.com:USER/test-test.git (push)  
```
