---
# 記事のタイトル
title: "{{ replace .Name "-" " " | title }}"
# 書いた日
date: {{ .Date | time.Format "2006-01-02"  }}
# 書いた人
author: ""
# イベント名
event-name: ""
# イベント開催日 "yyyy-mm-dd"
event-date: {{ .Date | time.Format "2006-01-02" }}
# イベント一覧での挙動を変更します。
#  "" => ページにジャンプ (デフォルト)
#  "none" => リンクを無効化
#  任意のURL => URLにジャンプ
custom-link: ""
---

