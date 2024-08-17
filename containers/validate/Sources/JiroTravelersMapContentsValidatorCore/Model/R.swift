import Foundation

enum R {
    enum string {
        enum day {
            static func monday() -> String { "月曜日" }
            static func tuesday() -> String { "火曜日" }
            static func wednesday() -> String { "水曜日" }
            static func thursday() -> String { "木曜日" }
            static func friday() -> String { "金曜日" }
            static func saturday() -> String { "土曜日" }
            static func sunday() -> String { "日曜日" }
            static func holiday() -> String { "祝日" }
            static func monday_short() -> String { "月" }
            static func tuesday_short() -> String { "火" }
            static func wednesday_short() -> String { "水" }
            static func thursday_short() -> String { "木" }
            static func friday_short() -> String { "金" }
            static func saturday_short() -> String { "土" }
            static func sunday_short() -> String { "日" }
            static func holiday_short() -> String { "祝" }
        }

        enum symbol {
            static func separator() -> String { "、" }
        }

        enum prefecture {
            static func hokkaido() -> String { "北海道" }
            static func aomori() -> String { "青森県" }
            static func iwate() -> String { "岩手県" }
            static func miyagi() -> String { "宮城県" }
            static func akita() -> String { "秋田県" }
            static func yamagata() -> String { "山形県" }
            static func fukushima() -> String { "福島県" }
            static func ibaraki() -> String { "茨城県" }
            static func tochigi() -> String { "栃木県" }
            static func gunma() -> String { "群馬県" }
            static func saitama() -> String { "埼玉県" }
            static func chiba() -> String { "千葉県" }
            static func tokyo() -> String { "東京都" }
            static func kanagawa() -> String { "神奈川県" }
            static func nigata() -> String { "新潟県" }
            static func toyama() -> String { "富山県" }
            static func ishikawa() -> String { "石川県" }
            static func fukui() -> String { "福井県" }
            static func yamanashi() -> String { "山梨県" }
            static func nagano() -> String { "長野県" }
            static func gifu() -> String { "岐阜県" }
            static func shizuoka() -> String { "静岡県" }
            static func aichi() -> String { "愛知県" }
            static func mie() -> String { "三重県" }
            static func shiga() -> String { "滋賀県" }
            static func kyoto() -> String { "京都府" }
            static func osaka() -> String { "大阪府" }
            static func hyōgo() -> String { "兵庫県" }
            static func nara() -> String { "奈良県" }
            static func wakayama() -> String { "和歌山県" }
            static func tottori() -> String { "鳥取県" }
            static func shimane() -> String { "島根県" }
            static func okayama() -> String { "岡山県" }
            static func hiroshima() -> String { "広島県" }
            static func yamaguchi() -> String { "山口県" }
            static func tokushima() -> String { "徳島県" }
            static func kagawa() -> String { "香川県" }
            static func ehime() -> String { "愛媛県" }
            static func kōchi() -> String { "高知県" }
            static func fukuoka() -> String { "福岡県" }
            static func saga() -> String { "佐賀県" }
            static func nagasaki() -> String { "長崎県" }
            static func kumamoto() -> String { "熊本県" }
            static func ōita() -> String { "大分県" }
            static func miyazaki() -> String { "宮崎県" }
            static func kagoshima() -> String { "鹿児島県" }
            static func okinawa() -> String { "沖縄県" }
        }
    }
}
