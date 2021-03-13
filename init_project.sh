#!/bin/zsh

# Gitのインストールチェック
git --version
if [ $? != 0 ]; then
  echo "\033[0;31mgitが見つかりません。インストールされていることを確認してください。\033[0;39m"
  exit
fi

# プロジェクト名のチェック
if [ -z $1 ]; then
  echo "\033[0;31mプロジェクト名が指定されていません。\033[0;39m"
  exit
fi
if [ $1 = '.' -o $1 = '..' ]; then
  echo "\033[0;31mプロジェクト名'$1'は設定できません。\033[0;39m"
  exit
fi

# GitHubユーザー名の確認
username=`git config user.name`
if [ -z $1 ]; then
  echo "\033[0;31mユーザー名が見つかりませんでした。\033[0;39m"
  exit
fi

mkdir $1
if [ -z $1 ]; then
  echo "\033[0;31m$1は既に存在します。\033[0;39m"
  exit
fi
echo "# $1" >> $1/README.md ; cd $1

git init
if [ $? != 0 ]; then
  echo "\033[0;31mgit initに失敗しました。\033[0;39m"
  cd .. && rm -rf $1
  exit
fi

git add README.md
git commit -m "first commit"
if [ $? != 0 ]; then
  echo "\033[0;31mgit commitに失敗しました。\033[0;39m"
  cd .. && rm -rf $1
  exit
fi

git branch -M main
if [ $? != 0 ]; then
  echo "\033[0;31mブランチの作成に失敗しました。\033[0;39m"
  cd .. && rm -rf $1
  exit
fi

# privateリポジトリの場合はオプション'--public'を'--private'に変更'
# originから変更する場合はオプション'--confirm'を削除'
gh repo create --public --confirm $1
if [ $? != 0 ]; then
  echo "\033[0;31m新規リポジトリが作成できませんでした。\033[0;39m"
  exit
fi

exit
git remote add origin https://github.com/$username/$1.git
git push -u origin main

echo -e "\033[0;32m新規プロジェクト'$1'の作成が完了しました。\033[0;39m"
