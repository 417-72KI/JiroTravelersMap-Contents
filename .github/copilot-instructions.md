# JiroTravelersMap 店舗 YAML 仕様

この文書は `resources/origin/*.yml` の店舗情報ファイルを更新するときの運用仕様です。

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

opening_hours:
  monday:
    - start: '11:00'
      end: '14:30'
    - start: '17:30'
      end: '21:00'
  sunday: []

## 5. regular_holiday の形式

- 配列要素は次のみ許可
  - monday, tuesday, wednesday, thursday, friday, saturday, sunday, holiday
- 重複値は禁止
- 休業日なしの場合は `regular_holiday: []`

## 6. 定休日と営業時間の整合ルール

- `regular_holiday` に含まれる曜日は、`opening_hours` の同曜日を必ず `[]` にする。
- 例: `regular_holiday` に `sunday` があるなら `opening_hours.sunday` は `[]`。

## 7. ラーメンデータベースからの更新ルール

### 7.1 ramen_db_link
- 店舗ページURLを `ramen_db_link` に格納する。
- 追加位置は `last_update` がある場合はその直前。

### 7.2 定休日（regular_holiday）
- 店舗ページの「定休日」欄から変換する。
- 定休日なしは `regular_holiday: []` で表現する。
- 「不定休」のみ記載されている場合は定休日なしと同義として `regular_holiday: []` にする。
- 複数の曜日が設定されている場合は曜日配列で表現する。
  - 例: `日曜、祝日` -> `regular_holiday: [sunday, holiday]`
- ただし、「不定休」が付いた曜日は regular_holiday に含めない。
  - 例: `祝日不定休` は `holiday` を追加しない
  - 例: `水曜不定休` は `wednesday` を追加しない
- `無休`, `年中無休`, `定休日なし` は `regular_holiday: []`。
- 曜日範囲表記（例: `月〜木`）は曜日配列に展開してよい。

### 7.3 営業時間（opening_hours）
- 営業時間文字列に曜日差分の記載がない場合は、monday から sunday を同一時間帯で埋める。
- その後、regular_holiday に該当する曜日は `[]` で上書きする。
- 曜日範囲表記（例: `月〜木`, `火-金`）がある場合は、その範囲の各曜日に営業時間を展開する。
- 祝日の営業時間が別途ある場合は `holiday` に展開する。

### 7.4 twitter
- 店舗ページの「外部リンク」から次を優先して抽出
  - `https://twitter.com/{id}`
  - `https://x.com/{id}`
- 抽出した `{id}` を `twitter` キーに保存（`@` は付けない）。
- 値が取得できない場合は `twitter` キーを追加しない。

### 7.5 last_update
- 情報更新を行ったファイルは `last_update` を更新日（`YYYY/MM/DD`）にする。

### 7.6 note（不定休情報）
- 定休日欄に不定休情報がある場合は `note` キーを追加する。
- `note` の追加位置は `ramen_db_link` の直下（`last_update` の直前）とする。
- 例: `水曜不定休`, `祝日不定休`, `不定休` などの情報をそのまま `note` に残す。

## 8. status が closed の店舗

- `status: closed` の店舗は、更新対象から除外する運用を推奨する。
- 誤って変更した場合は当該ファイルのみリセットする。

## 9. バリデーションチェックリスト

更新後は最低限、次を確認する。

1. YAMLとして壊れていない。
2. `regular_holiday` の値が許可語のみ。
3. `regular_holiday` の重複がない。
4. `regular_holiday` に含む曜日の `opening_hours` が `[]`。
5. `twitter` はIDのみ（URLや@付きでない）。
6. `ramen_db_link` が `https://ramendb.supleks.jp/s/{id}.html` 形式。
7. 不定休情報がある場合は `note` が存在し、`ramen_db_link` の直下にある。
