# mattermost-initializer
`mattermost-initializer` は、mattermostのチーム、チャネル、ユーザをセットアップするツールです。

## 機能概要

mattermostのコマンド[mmctl](https://docs.mattermost.com/manage/mmctl-command-line-tool.html)を利用して、チーム、チャネル、ユーザを自動登録できます。なお、データベースは、postgresql を前提としています。

## 提供機能

### ベースとなるコマンド群(binディレクトリ直下)

* mattermost サービスの起動([mm-start.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-start.bash)
* mattermost サービスの停止([mm-stop.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-stop.bash)
* mattermost のサービス状態参照([mm-status.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-status.bash))
* mattermost のデータベースの初期化([mm-reset.bash](https://github.com/tmori/mattermost-initializer/blob/main/bin/mm-reset.bash))
  * データベースを削除し、新規でデータベースを作成します

### バッチ処理群(batchディレクトリ直下)

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

### 環境変数
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
