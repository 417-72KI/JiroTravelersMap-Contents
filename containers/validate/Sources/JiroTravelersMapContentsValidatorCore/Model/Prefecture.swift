import Foundation

public enum Prefecture: String, Model {
    case hokkaido
    case aomori
    case iwate
    case miyagi
    case akita
    case yamagata
    case fukushima
    case ibaraki
    case tochigi
    case gunma
    case saitama
    case chiba
    case tokyo
    case kanagawa
    case nigata
    case toyama
    case ishikawa
    case fukui
    case yamanashi
    case nagano
    case gifu
    case shizuoka
    case aichi
    case mie
    case shiga
    case kyoto
    case osaka
    case hyogo
    case nara
    case wakayama
    case tottori
    case shimane
    case okayama
    case hiroshima
    case yamaguchi
    case tokushima
    case kagawa
    case ehime
    case kochi
    case fukuoka
    case saga
    case nagasaki
    case kumamoto
    case oita
    case miyazaki
    case kagoshima
    case okinawa
}

extension Prefecture {
    var value: String {
        switch self {
        case .hokkaido: R.string.prefecture.hokkaido()
        case .aomori: R.string.prefecture.aomori()
        case .iwate: R.string.prefecture.iwate()
        case .miyagi: R.string.prefecture.miyagi()
        case .akita: R.string.prefecture.akita()
        case .yamagata: R.string.prefecture.yamagata()
        case .fukushima: R.string.prefecture.fukushima()
        case .ibaraki: R.string.prefecture.ibaraki()
        case .tochigi: R.string.prefecture.tochigi()
        case .gunma: R.string.prefecture.gunma()
        case .saitama: R.string.prefecture.saitama()
        case .chiba: R.string.prefecture.chiba()
        case .tokyo: R.string.prefecture.tokyo()
        case .kanagawa: R.string.prefecture.kanagawa()
        case .nigata: R.string.prefecture.nigata()
        case .toyama: R.string.prefecture.toyama()
        case .ishikawa: R.string.prefecture.ishikawa()
        case .fukui: R.string.prefecture.fukui()
        case .yamanashi: R.string.prefecture.yamanashi()
        case .nagano: R.string.prefecture.nagano()
        case .gifu: R.string.prefecture.gifu()
        case .shizuoka: R.string.prefecture.shizuoka()
        case .aichi: R.string.prefecture.aichi()
        case .mie: R.string.prefecture.mie()
        case .shiga: R.string.prefecture.shiga()
        case .kyoto: R.string.prefecture.kyoto()
        case .osaka: R.string.prefecture.osaka()
        case .hyogo: R.string.prefecture.hyōgo()
        case .nara: R.string.prefecture.nara()
        case .wakayama: R.string.prefecture.wakayama()
        case .tottori: R.string.prefecture.tottori()
        case .shimane: R.string.prefecture.shimane()
        case .okayama: R.string.prefecture.okayama()
        case .hiroshima: R.string.prefecture.hiroshima()
        case .yamaguchi: R.string.prefecture.yamaguchi()
        case .tokushima: R.string.prefecture.tokushima()
        case .kagawa: R.string.prefecture.kagawa()
        case .ehime: R.string.prefecture.ehime()
        case .kochi: R.string.prefecture.kōchi()
        case .fukuoka: R.string.prefecture.fukuoka()
        case .saga: R.string.prefecture.saga()
        case .nagasaki: R.string.prefecture.nagasaki()
        case .kumamoto: R.string.prefecture.kumamoto()
        case .oita: R.string.prefecture.ōita()
        case .miyazaki: R.string.prefecture.miyazaki()
        case .kagoshima: R.string.prefecture.kagoshima()
        case .okinawa: R.string.prefecture.okinawa()
        }
    }
}
