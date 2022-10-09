# TENGINEER福岡

## イベントの追加

`data/events.yaml` に追加してください。
Web ページ上には自動で開催日順にソートして表示されますが、データも開催日順に並べたほうが管理が容易になると思います。

## ブログ記事の追加

`content/activity` の中に `適当な名前.md` のようなファイルを作るか、
適当な名前でフォルダーを作り、その中の `index.md` に内容を書いてください。
他のページをコピーして始めるのが良いと思います。

後述する hugo コマンドを導入していれば、

```shell
$ hugo new activity/<適当な名前>.md
```

で自動で体裁を整えたファイルを作ってくれます。

## トップページのカスタマイズ

### 内容を増やす・減らす

`config.toml` の `[Params.home]` の `section` を書き換えることでカスタマイズ可能です。
詳しくは `config.toml` を見てください。

### メンバー

`section` で `member` を表示するようにした場合、内容は `data/members.yaml` で編集できます。

```yaml
  # 表示したいユーザ名
- name: "hoge"
  # アイコン画像の URL
  avatar: ""
  # 肩書
  title: "代表"
  # Facebook のユーザ名
  facebook: ""
  # Twitter のユーザ名
  twitter: ""
  # GitHub のユーザ名
  github: ""
```

## ローカル環境での実行

Hugo を使っています。[こちら](https://gohugo.io/)からダウンロードしてください。
Hugo にパスを通したら、コマンドラインで

```shell
$ hugo server
```

を実行すると、`http://localhost:1313/TENGINEER/` からサイトの内容が見えます。
