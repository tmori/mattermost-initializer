# mattermost-initializer
`mattermost-initializer` は、mattermostのチーム、チャネル、ユーザをセットアップするツールです。

## 機能概要

mattermostのコマンド[mmctl](https://docs.mattermost.com/manage/mmctl-command-line-tool.html)を利用して、チーム、チャネル、ユーザを自動登録できます。なお、データベースは、postgresql を前提としています。

## 提供機能

### ベースとなるコマンド群(binディレクトリ直下)

* mattermost サービスの起動([mm-start.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-start.bash))
* mattermost サービスの停止([mm-stop.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-stop.bash))
* mattermost のサービス状態参照([mm-status.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-status.bash))
* mattermost のデータベースの初期化([mm-reset.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-reset.bash))
  * データベースを削除し、新規でデータベースを作成します

### バッチ処理群(batchディレクトリ直下)
以下のバッチ処理を用意しています。
それぞれ独立して実行できますが、setup.bash を利用すると一括して全チーム/チャネル/ユーザを一括登録できるので便利です。
ただし、バッチ処理の入力情報は、特定の書式で記載れたファイルを用意する必要があります（後述）。

* ユーザの一括登録([add-users.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/add-users.bash))
* チームの一括登録([add-teams.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/add-teams.bash))
* チャネルの一括登録([add-channels.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/add-channels.bash))
* チーム所属ユーザの一括登録([add-team-users.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/add-team-users.bash))
* チャネル所属ユーザの一括登録([add-channel-users.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/add-channel-users.bash))
* チーム単位での上記の一括実行([setup-one.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/setup-one.bash))
* 全チームに対する上記の一括実行([setup.bash](https://github.com/tmori/mattermost-initializer/blob/main/batch/setup.bash))


## 前提とする環境

* OS: Ubuntu 20.0.4
* mattermost: v7.2
  * インストール手順は[こちら](https://qiita.com/kanetugu2018/items/51cdab279d81ae06aa70)を参照ください。
* その他
  * テスト自動化するためには、mattermost ユーザアカウントへの su をパスワードなしで実行できるように設定が必要です
  * 参考：https://ja.linux-console.net/?p=599#gsc.tab=0


## インストール手順

本リポジトリをクローンするだけです。

```
git clone --recursive https://github.com/tmori/mattermost-initializer.git
```

## バッチ処理向け入力データの構成/種類/書式/簡易設定ツール

### 構成
バッチ処理向けの入力データは以下の構成でファイル配置する必要があります。

```
input/base-data/
├── teams
│   └── <チーム名1>
│   :   ├── channel
│   :   │   └── <チャネル名1>.txt
|   :   :   :
│   :   │   └── <チャネル名N>.txt
│   :   ├── channels.txt
│   :   ├── <チーム名1>.txt
│   :   ├── team-users.txt
│   :   └── team.txt
:   :
│   └── <チーム名N>
│       ├── channel
│       │   └── <チャネル名1>.txt
|       :   :
│       │   └── <チャネル名M>.txt
│       ├── channels.txt
│       ├── <チーム名N>.txt
│       ├── team-users.txt
│       └── team.txt
└── user
    ├── <ユーザ名1>.txt
    │      :
    └── <ユーザ名N>.txt
```

### 種類
バッチ処理向けの入力データの種類としては以下があります。

* teams/<チーム名>
  * team.txt
    * チーム情報を設定します
  * channels.txt
    * チーム内のチャネル情報を設定します
  * team-users.txt
    * チーム所属ユーザを設定します
  * channel
    * <チャネル名>.txt
      * チャネル所属ユーザを設定します
* user
  * <ユーザ名>.txt
    * ユーザ情報を設定します

### 書式

#### teams/<チーム名>/team.txt
以下の書式でチーム情報を設定します。


```
<チーム名>:<UI表記名>:<公開/非公開>
```

* <チーム名>
  * mattermostのチーム名
* <UI表記名>
  * チーム名のUI表記名
* <公開/非公開>
  * 公開：public
  * 非公開：private


#### teams/<チーム名>/channels.txt

以下の書式でチームに所属するチャネル情報を設定します。

```
<チーム名>:<チャネル名>:<UI表記名>:<公開/非公開>
 :
```

* <チーム名>
  * mattermostのチーム名
* <チャネル名>
  * mattermostのチャネル名
* <UI表記名>
  * チャネル名のUI表記名
* <公開/非公開>
  * 公開：public
  * 非公開：private


#### teams/<チーム名>/team-users.txt

以下の書式でチームに所属するユーザ情報を設定します。

```
<ユーザ名>:<パスワード>:<email>:<権限>[:<ファーストネーム>[:<ラストネーム>]]
 :
```

* <ユーザ名>
  * username
  * mattermostのログインアカウント名
* <パスワード>
  * ログイン時のパスワード
  * 大文字、小文字、記号、数字が混じっていること
* <email>
  * email
  * メールアドレス
* <権限>
  * 一般ユーザ：member
  * 管理者：system_admin
* <ファーストネーム>
  * firstname
* <ラストネーム>
  * lastname

参考情報：

https://docs.mattermost.com/manage/mmctl-command-line-tool.html#mmctl-user-create


 #### <チーム名>.txt
 
以下の書式でチームに所属するユーザ情報を設定します。
 
```
user/<ユーザ名>.txt
 :
```

* <ユーザ名>
  * mattermostのログインアカウント名

#### teams/<チーム名>/channels/<チャネル名>.txt
 
以下の書式でチャネルに所属するユーザ情報を設定します。
 
```
user/<ユーザ名>.txt
 :
```

* <ユーザ名>
  * mattermostのログインアカウント名

 
#### user/<ユーザ名>.txt

以下の書式でmattermostに登録するユーザ情報を設定します。

```
<ユーザ名>:<パスワード>:<email>:<権限>
```

* <ユーザ名>
  * mattermostのログインアカウント名
* <パスワード>
  * ログイン時のパスワード
  * 大文字、小文字、記号、数字が混じっていること
* <email>
  * メールアドレス
* <権限>
  * 一般ユーザ：member
  * 管理者：system_admin

 ### 簡易設定ツール
 
 上記ファイル群を簡単に設定するためのツールを、`input/tools` 配下に用意しています。
 
 * [create-team.bash](https://github.com/tmori/mattermost-initializer/blob/main/input/tools/create-team.bash)
   * チーム追加します
 * [create-channel.bash](https://github.com/tmori/mattermost-initializer/blob/main/input/tools/create-channel.bash)
   * チャネル追加します
 * [add-user.bash](https://github.com/tmori/mattermost-initializer/blob/main/input/tools/add-user.bash)
   * ユーザ追加します
 * [reset.bash](https://github.com/tmori/mattermost-initializer/blob/main/input/tools/reset.bash)
   * 設定ファイルを一括削除します

使い方例は、以下を参照ください。
 
 https://github.com/tmori/mattermost-initializer/blob/main/test-data/create.bash
 
 
## 環境変数
本ツールを実行するためには、mattermost向けのパラメータとDB向けのパラメータを設定する必要があります。

### mattermost 向けのパラメータ
env/env.bash の以下のパラメータを設定する必要があります。

* DB_TOOL_PATH(変更不要)
  * DB向けのツールの配置パスです。
* MATTERMOST_CMD_PATH
  * mmctl コマンドパスです。
  * デフォルトと異なる場合は変更してください。
* MATTERMOST_DBNAME
  * mattermost用のデータベース名です。
  * デフォルトと異なる場合は変更してください。
* MATTERMOST_ACCOUNT_NAME
  * mattermostのアカウント名です。
  * デフォルトと異なる場合は変更してください。
* MATTERMOST_USER_PASSWD
  * mattermostに登録するユーザの初期パスワードです。
  * デフォルトと異なるものにしたい場合は変更してください。
* MATTERMOST_BATCH_INPUT_DIR
  * バッチ処理の入力データ配置ディレクトリパスです。
  * デフォルトと異なるものにしたい場合は変更してください。

### DB 向けのパラメータ
db-backup-restore/env/env.bash の以下のパラメータを設定する必要があります。
* DB_IMPL_TYPE
  * DBの種類です。postgresql としてください。
* PSQL_DB_PORT
  * DBのポート番号です。
  * デフォルトと異なる場合は変更してください。
* PSQL_DB_HOST
  * DBのIPアドレスです。
  * デフォルトと異なる場合は変更してください。
* PSQL_DB_USERNAME
  * mattermostのデータベースのユーザ名です。
  * デフォルトと異なる場合は変更してください。
* PSQL_DB_PGPASSWORD
  * mattermostのデータベースのユーザパスワードです。
  * デフォルトと異なる場合は変更してください。
* PSQL_DB_POSTGRES_USERNAME(変更不要)
  * postgresql のアカウント名です。
* PSQL_DB_POSTGRES_PGPASSWORD
  * postgresのパスワードです。
  * デフォルトと異なる場合は変更してください。
