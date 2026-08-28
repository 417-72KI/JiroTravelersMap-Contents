# JiroTravelersMap 店舗 YAML 仕様

この文書は `resources/origin/*.yml` の店舗情報ファイルのデータ仕様です。

## 1. 対象ファイル

- パス: `resources/origin/{NN}-{店舗名}.yml`
- 1ファイル = 1店舗
- 文字コード: UTF-8

## 2. 基本スキーマ

各ファイルは次のキーを持つ。

必須キー
- id: number
- kind: string（現状は `origin` 固定）
- name: string
- status: string（`open` または `closed`）
- prefecture: string（英小文字の都道府県コード）
- address: string
- location:
  - lat: number
  - lng: number
- regular_holiday: array または []
- opening_hours: object
- has_parking: boolean
- hard_noodle_enabled: boolean
- ramen_db_link: string（`https://ramendb.supleks.jp/s/{id}.html`）

任意キー
- twitter: string（X/Twitter アカウントID。`@` なし）
- note: string（不定休など補足情報）
- last_update: string（`YYYY/MM/DD`）

## 3. 推奨キー順

キー順は次を基本とする。

1. id
2. kind
3. name
4. status
5. prefecture
6. address
7. location
8. regular_holiday
9. opening_hours
10. has_parking
11. hard_noodle_enabled
12. twitter（ある場合）
13. ramen_db_link
14. note（ある場合）
15. last_update（ある場合）

## 4. opening_hours の形式

- `opening_hours` 配下は曜日キーを使う
  - monday
  - tuesday
  - wednesday
  - thursday
  - friday
  - saturday
  - sunday
  - holiday（祝日の営業時間が別途設定されている場合のみ）
- 各曜日は次のどちらか
  - `[]`
  - 時間帯配列
    - start: 'HH:MM'
      end: 'HH:MM'

例

```yml
opening_hours:
  monday:
    - start: '11:00'
      end: '14:30'
    - start: '17:30'
      end: '21:00'
  sunday: []
```

## 5. regular_holiday の形式

- 配列要素は次のみ許可
  - monday, tuesday, wednesday, thursday, friday, saturday, sunday, holiday
- 重複値は禁止
- 休業日なしの場合は `regular_holiday: []`

## 6. 定休日と営業時間の整合ルール

- `regular_holiday` に含まれる曜日は、`opening_hours` の同曜日を必ず `[]` にする。
- 例: `regular_holiday` に `sunday` があるなら `opening_hours.sunday` は `[]`。
