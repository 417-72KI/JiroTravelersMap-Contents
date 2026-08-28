---
name: update-shop-info
description: ラーメンデータベース（RDB）等の情報を元に、JiroTravelersMapの店舗情報YAML（resources/origin/*.yml）を抽出・変換・更新および検証する手順。店舗情報の更新を依頼された際に使用する。
---

# update-shop-info

ラーメンデータベース（RDB）等のWebページ・外部ソースの情報を元に、`resources/origin/{NN}-{店舗名}.yml` を更新・バリデーションするためのワークフローおよび手順書です。

店舗 YAML の基本的なスキーマやキー順、データフォーマット定義については `.github/copilot-instructions.md` を参照してください。

---

## 1. 事前準備・対象店舗の確認

1. **更新対象ファイルの特定**:
   - `resources/origin/{NN}-{店舗名}.yml` から対象店舗のファイルを探す。
2. **閉店（closed）店舗の除外**:
   - `status: closed` の店舗は更新対象から除外する。
   - 誤って変更した場合は当該ファイルのみ変更を取り消す（リセットする）。

---

## 2. 情報抽出・変換ルール（ラーメンデータベース等からの更新）

ソース情報（ラーメンデータベースの店舗ページ等）から各キーへ値を変換する際は、以下のルールに従う。

### 2.1 ramen_db_link
- 店舗ページURL（`https://ramendb.supleks.jp/s/{id}.html`）を `ramen_db_link` に格納する。
- 配置順は `twitter` がある場合はその直下、ない場合は `hard_noodle_enabled` の直下とし、`note` がある場合はその直前、`note` がない場合は `last_update` の直前とする。`last_update` がない場合はファイル末尾とする。
- RDBページが見つからない／404の場合は `ramen_db_link` を省略・削除せず、更新作業を中断してURLを確認する（既存値がある場合は維持する）。

### 2.2 定休日（regular_holiday）
- 店舗ページの「定休日」欄から変換する。
- 定休日なし（「無休」「年中無休」「定休日なし」など）は `regular_holiday: []` とし、`note` は追加しない（ルール1と混同しないこと）。
- 次の優先順位で要素ごとに判定して `regular_holiday` を作成する：
  1. `不定休` が単独で記載されている場合は `regular_holiday: []` とし、`note` に記載する（「定休日なし」とは異なり `note` の記載が必須）。
  2. 曜日 + `不定休`（例: `祝日不定休`, `水曜不定休`）は、その曜日を `regular_holiday` に追加せず `note` に記載する。
  3. それ以外の曜日・曜日範囲（例: `日曜`, `日曜、祝日`, `月〜木`）は曜日配列（英小文字: `monday`〜`sunday`, `holiday`）に展開して `regular_holiday` に追加する。
  4. 複数ケースが混在する場合は、1〜3を各要素に独立して適用する。
     - 例: `日曜・祝日不定休` → `日曜` はルール3を適用して `regular_holiday` に `sunday` を追加し、`祝日不定休` はルール2を適用して `holiday` は `regular_holiday` に追加せず `note` に記載する（結果: `regular_holiday: [sunday]`、`note: '祝日不定休'`）。
- 配列内の重複値は禁止。

### 2.3 営業時間（opening_hours）
- 営業時間文字列に曜日の区別がなく全曜日共通の時間帯のみが記載されている場合は、`monday` から `sunday` を同一時間帯で埋める。
- 一部の曜日のみ記載されている場合は、記載のない曜日は `[]` とする。
- 複数時間帯（例: `10:00 〜 15:00 / 17:00 ~ 21:00`）は、各時間帯を個別の配列要素（`start: 'HH:MM'`, `end: 'HH:MM'`）として展開する。
- **定休日との整合**: `regular_holiday` に該当する曜日は `opening_hours` の同曜日を必ず `[]` で上書きする。
- 曜日範囲表記（例: `月〜木`, `火-金`）がある場合は、その範囲の各曜日に営業時間を展開する。
- 祝日の営業時間が別途ある場合は `holiday` に展開する。
- ソースデータに営業時間の記載がなく、かつ `regular_holiday` にも含まれていない曜日は、省略せず明示的に `[]` をセットする。
- 営業時間が「時間未定」「要確認」など非時間文字列で記載されている曜日は `[]` をセットし、`note` に補足情報を記載する。

### 2.4 twitter
- 店舗ページの「外部リンク」から次を優先して抽出する：
  - `https://twitter.com/{id}`
  - `https://x.com/{id}`
- 抽出した `{id}` を `twitter` キーに保存する（`@` や URL は含めない）。
- `twitter.com` および `x.com` 以外のURL（Instagram, Facebook等）は `twitter` キーに格納しない（無視する）。
- アカウント情報がない場合は `twitter` キーを追加しない（既存になければ省略）。

### 2.5 note（不定休情報・補足情報）
- 定休日欄に不定休情報がある場合は `note` キーを追加する。
  - 例: `水曜不定休`, `祝日不定休`, `不定休` などの文言をそのまま `note` に記載。
- `note` の配置位置は `ramen_db_link` の直下（`last_update` の直前）とする。

### 2.6 last_update
- 情報更新を行ったファイルは、`last_update` を当日の日付（`YYYY/MM/DD`）にする。

---

## 3. 更新手順

1. **情報収集**: ラーメンデータベース等の店舗ページから、営業時間・定休日・Twitter・URL等の最新情報を確認・取得する。
2. **YAMLファイル編集**: セクション2の抽出・変換ルール、および `.github/copilot-instructions.md` のキー順・フォーマットに従って `resources/origin/{NN}-{店舗名}.yml` を編集する。
3. **バリデーション実行**: セクション4のチェックリストおよび検証ツール（`make validate`）で内容を確認する。
4. **コミット実行**: セクション5の手順に従い、ブランチの作成とコミットを行う。
5. **Push & PR作成**: セクション6の手順に従い、ユーザーに確認を取った上でリモートへ Push し、Pull Request を作成する。

---

## 4. バリデーションチェックリスト

更新後は必ず以下を確認すること：

- [ ] YAMLの文法エラー（構文崩れ、インデント不正）がないか
- [ ] 推奨キー順（`.github/copilot-instructions.md` 参照）に沿っているか
- [ ] `regular_holiday` の値が許可された英小文字曜日のみで構成され、重複がないか
- [ ] `regular_holiday` に含まれる曜日の `opening_hours` が `[]` になっているか
- [ ] `twitter` が `@` や URL なしの ID 単体になっているか
- [ ] `ramen_db_link` が `https://ramendb.supleks.jp/s/{id}.html` 形式になっているか
- [ ] 不定休情報がある場合、`note` が `ramen_db_link` の直下に設定されているか
- [ ] 更新した場合、`last_update` が当日の `YYYY/MM/DD` に更新されているか
- [ ] （利用可能な場合）バリデーションコマンド等（例: `make validate`）が通るか

---

## 5. コミット手順

店舗情報の更新・バリデーションが完了したら、以下の手順に従ってコミットを行う：

1. **ブランチの作成**:
   - 更新対象に応じたトピックブランチ（例: `update-{店舗識別名}`）を新規作成して切り替える。
   ```bash
   git checkout -b update-{shop-name}
   ```
2. **変更ファイルのステージング**:
   - 更新した店舗 YAML ファイルのみをステージングする。
   ```bash
   git add resources/origin/{NN}-{店舗名}.yml
   ```
3. **コミットの作成**:
   - コミットメッセージは**シンプルな英語**で記述する（例: `Update {Shop Name} shop info`）。
   ```bash
   git commit -m "Update {Shop Name} shop info"
   ```

---

## 6. Push & Pull Request 作成手順

コミット完了後、リモートへの Push および Pull Request 作成を行う：

1. **ユーザー確認（必須）**:
   - **`git push` を実行する前に、必ずユーザーに Push を行ってよいか確認を取る**（ユーザーの承認を得るまで Push は実行しない）。
2. **リモートへの Push**:
   - ユーザーの承認後、ブランチを Push する。
   ```bash
   git push -u origin update-{shop-name}
   ```
3. **Pull Request の作成**:
   - GitHub CLI（`gh`）を使用して `main` ブランチ宛てに PR を作成する。
   - タイトルおよび本文（Summary, Verification）は**英語**で記述する。
   ```bash
   gh pr create --base main --head update-{shop-name} \
     --title "Update {Shop Name} shop info" \
     --body "## Summary
   Updated {Shop Name} shop information (opening hours and last update).

   - Opening hours: ...
   - `last_update`: YYYY/MM/DD

   ## Verification
   - Passed `make validate`"
   ```
