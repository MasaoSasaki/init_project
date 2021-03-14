#!/bin/sh

# Gitのインストールチェック
git --version
if [ $? != 0 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mgitが見つかりません。インストールされていることを確認してください。\033[0;39m"
  else
    echo -e "\e[31mgitが見つかりません。インストールされていることを確認してください。\e[m"
  fi
  exit
fi

# プロジェクト名のチェック
if [ -z $1 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mプロジェクト名が指定されていません。\033[0;39m"
  else
    echo -e "\e[31mプロジェクト名が指定されていません。\e[m"
  fi
  exit
fi
if [ $1 = '.' -o $1 = '..' ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mプロジェクト名'$1'は設定できません。\033[0;39m"
  else
    echo -e "\e[31mプロジェクト名'$1'は設定できません。\e[m"
  fi
  exit
fi

# GitHubユーザー名の取得
username=`git config user.name`
if [ -z $1 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mユーザー名が見つかりませんでした。\033[0;39m"
  else
    echo -e "\e[31mユーザー名が見つかりませんでした。\e[m"
  fi
  exit
fi

mkdir $1
if [ -z $1 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31m$1は既に存在します。\033[0;39m"
  else
    echo -e "\e[31m$1は既に存在します。\e[m"
  fi
  exit
fi
echo "# $1" >> $1/README.md ; cd $1

git init
if [ $? != 0 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mgit initに失敗しました。\033[0;39m"
  else
    echo -e "\e[31mgit initに失敗しました。\e[m"
  fi
  cd .. && rm -rf $1
  exit
fi

git add README.md
git commit -m ":tada:first commit"
if [ $? != 0 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mgit commitに失敗しました。\033[0;39m"
  else
    echo -e "\e[31mgit commitに失敗しました。\e[m"
  fi
  cd .. && rm -rf $1
  exit
fi

git branch -M main
if [ $? != 0 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31mブランチの作成に失敗しました。\033[0;39m"
  else
    echo -e "\e[31mブランチの作成に失敗しました。\e[m"
  fi
  cd .. && rm -rf $1
  exit
fi

# privateリポジトリの場合はオプション'--public'を'--private'に変更'
# originから変更する場合はオプション'--confirm'を削除'
gh repo create --public --confirm $1
if [ $? != 0 ]; then
  if [ $SHELL = '/bin/zsh' ]; then
    echo "\033[0;31m新規リポジトリが作成できませんでした。\033[0;39m"
  else
    echo -e "\e[31m新規リポジトリが作成できませんでした。\e[m"
  fi
  exit
fi

git remote add origin https://github.com/$username/$1.git
git push -u origin main

if [ $SHELL = '/bin/zsh' ]; then
  echo "\033[0;32m新規プロジェクト'$1'の作成が完了しました。\033[0;39m"
else
  echo -e "\e[31m新規プロジェクト'$1'の作成が完了しました。\e[m"
fi
