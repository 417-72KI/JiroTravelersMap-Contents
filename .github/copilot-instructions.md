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
- 追加位置は `twitter` の直下とし、`note` がある場合はその直前、`note` がない場合は `last_update`（ある場合）の直前に配置する。

### 7.2 定休日（regular_holiday）
- 店舗ページの「定休日」欄から変換する。
- 定休日なしは `regular_holiday: []` で表現する。
- 次の優先順位で要素ごとに判定して `regular_holiday` を作成する。
  - ① `不定休` が単独で記載されている場合は `regular_holiday: []` とし、`note` に記載する。
  - ② 曜日 + `不定休`（例: `祝日不定休`, `水曜不定休`）は、その曜日を `regular_holiday` に追加せず `note` に記載する。
  - ③ それ以外の曜日・曜日範囲（例: `日曜`, `日曜、祝日`, `月〜木`）は曜日配列に展開して `regular_holiday` に追加する。
  - ④ 複数ケースが混在する場合（例: `日曜・祝日不定休`）は、①〜③を各要素に独立して適用する。
- `無休`, `年中無休`, `定休日なし` は `regular_holiday: []`。

### 7.3 営業時間（opening_hours）
- 営業時間文字列に曜日の区別が一切なく、全曜日共通の時間帯のみが記載されている場合は、monday から sunday を同一時間帯で埋める。
- 一部の曜日のみが記載されている場合は、記載のない曜日は `[]` とする。
- 営業時間文字列に `/` 区切りで複数時間帯（例: `10:00 〜 15:00 / 17:00 ~ 21:00`）が記載されている場合は、区切られた各時間帯を個別の配列要素として展開する。
- その後、regular_holiday に該当する曜日は `[]` で上書きする。
- 曜日範囲表記（例: `月〜木`, `火-金`）がある場合は、その範囲の各曜日に営業時間を展開する。
- 祝日の営業時間が別途ある場合は `holiday` に展開する。
- ソースデータに営業時間の記載がなく、かつ `regular_holiday` にも含まれていない曜日は、`opening_hours` から省略せず `[]` を明示的にセットし、バリデーションチェック時に担当者が確認すること。

例（`10:00 〜 15:00 / 17:00 ~ 21:00` の場合）

```yml
  monday:
    - start: '10:00'
      end: '15:00'
    - start: '17:00'
      end: '21:00'
```

### 7.4 twitter
- 店舗ページの「外部リンク」から次を優先して抽出
  - `https://twitter.com/{id}`
  - `https://x.com/{id}`
- 抽出した `{id}` を `twitter` キーに保存（`@` は付けない）。
- `twitter.com` および `x.com` 以外のURLは `twitter` キーに格納しない。Instagram・Facebook等の他SNSリンクは現仕様では対象外とし、無視する。
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
