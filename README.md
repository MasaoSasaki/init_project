# init_project

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
  
## 留意点
リポジトリに使える文字（記号）には制限があるため、スクリプトの引数に指定した名前とGitHubリポジトリの名前が一部変更されることがあります。  
  
例：  
~/init_project.sh test~test  
ls  
test~test
リポジトリ名：test-test

