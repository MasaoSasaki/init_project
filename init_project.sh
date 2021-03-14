#!/bin/sh
ESC=$(printf '\033')

function ConfirmExecution() {
  echo "${ESC}[0;33mWarning: $1継続しますか？ [y/n] ${ESC}[0;39m"
  read input

  if [ $input = 'y' ]; then
    echo "${ESC}[0;33mスクリプトを継続します。${ESC}[0;39m"
  else
    echo "${ESC}[0;33mスクリプトを中止します。${ESC}[0;39m"
    exit
  fi
}
function ExistError() {
  echo "${ESC}[0;31mError: $1${ESC}[0;39m"
  if [ "$2" = "rm" ]; then cd .. && rm -rf $3; fi
  exit
}

# Gitのインストールチェック
git --version
if [ $? != 0 ]; then ExistError 'gitが見つかりません。インストールされていることを確認してください。'; fi
# GitHub CLIのインストールチェック
gh --version
if [ $? != 0 ]; then ExistError 'GitHub CLIが見つかりません。インストールされていることを確認してください。'; fi

# プロジェクト名のチェック
if [ -z $1 ]; then ExistError 'プロジェクト名が指定されていません。'; fi
if [ $1 = '.' -o $1 = '..' ]; then ExistError "プロジェクト名'$1'は指定できません。"; fi
if [ $1 = '.' -o $1 = '..' ]; then ExistError "プロジェクト名'$1'は指定できません。"; fi
if [ $SHELL = '/bin/zsh' ]; then
  if [ !`echo $1 | wc -m` -le 101 ]; then ConfirmExecution '100文字までが名前として有効になります。'; fi
fi
if [ `echo $1 | egrep "\!|\#|\%|\&|\(|\)|\=|\^|\~|\¥|\@|\[|\{|\;|\+|\:|\*|\]|\}|\,|\.|/|\?"` ]; then ConfirmExecution '名前の一部が"-(ハイフン)"に置き換わります。'; fi

# GitHubユーザー名の取得
username=`git config user.name`
if [ $? != 0 ]; then ExistError 'GitHubユーザー名が見つかりませんでした。'; fi

mkdir $1
if [ $? != 0 ]; then ExistError "$1は既に存在します。"; fi
echo "# $1" >> $1/README.md ; cd $1

git init
if [ $? != 0 ]; then ExistError 'git initに失敗しました。' 'rm' $1; fi

git add README.md
git commit -m ":tada:first commit"
if [ $? != 0 ]; then ExistError 'git commitに失敗しました。' 'rm' $1; fi

# デフォルトはmainブランチ
git branch -M main
if [ $? != 0 ]; then ExistError 'ブランチの作成に失敗しました。' 'rm' $1; fi

# privateリポジトリの場合はオプション'--public'を'--private'に変更'
# originから変更する場合はオプション'--confirm'を削除'
gh repo create --public --confirm $1
if [ $? != 0 ]; then ExistError '新規リポジトリが作成できませんでした。'; fi

git remote add origin https://github.com/$username/$1.git
git push -u origin main

echo "${ESC}[0;32mSuccess: 新規プロジェクト'$1'の作成が完了しました。${ESC}[0;39m"
