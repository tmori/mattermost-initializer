# mattermost-initializer
`mattermost-initializer` は、mattermostのチーム、チャネル、ユーザをセットアップするツールです。

## 機能概要

mattermostのコマンド[mmctl](https://docs.mattermost.com/manage/mmctl-command-line-tool.html)を利用して、チーム、チャネル、ユーザを自動登録できます。なお、データベースは、postgresql を前提としています。

## 提供機能

### ベースとなるコマンド群(binディレクトリ直下)

* mattermost サービスの起動(mm-start.bash)
* mattermost サービスの停止(mm-stop.bash)
* mattermost のサービス状態参照(mm-status.bash)
* mattermost のデータベースの初期化(mm-reset.bash)
  * データベースを削除し、新規でデータベースを作成します

### バッチ処理群(batchディレクトリ直下)

* ユーザの一括登録(add-users.bash)
* チームの一括登録(add-teams.bash)
* チャネルの一括登録(add-channels.bash)
* チーム所属ユーザの一括登録(add-team-users.bash)
* チャネル所属ユーザの一括登録(add-channel-users.bash)
* チーム単位での上記の一括実行(setup-one.bash)
* 全チームに対する上記の一括実行(setup.bash)

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
git clone https://github.com/tmori/mattermost-initializer.git
```

