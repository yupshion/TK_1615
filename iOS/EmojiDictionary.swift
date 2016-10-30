//
//  EmojiDictionary.swift
//  Unity-iPhone
//
//  Created by koooootake on 2016/10/30.
//
//

import Foundation

//辞書
class EmojiDictionary:NSObject{
    
    class var sharedInstance:EmojiDictionary{
        
        struct Singleton{
            static var instance = EmojiDictionary()
        }
        return Singleton.instance
    }
    
    func SetUp() -> [String: String]{
        
        let emojiDictionary = ["りんご":"apple",
                               "ゴリラ":"gorilla",
                               "リンゴ":"apple",
                               "ごりら":"gorilla",
                               "よくない":"emoji/-1",
                               "いいね":"emoji/1",
                               "良":"emoji/1",
                               "いかり":"emoji/angry",
                               "怒り":"emoji/angry",
                               "うわー":"emoji/astonished",
                               "うれしい":"emoji/blush",
                               "嬉しい":"emoji/blush",
                               "嬉":"emoji/blush",
                               "ごめん":"emoji/bow",
                               "謝":"emoji/bow",
                               "にかっ":"emoji/bowtie",
                               "はくしゅ":"emoji/clap",
                               "拍手":"emoji/clap",
                               "ひやあせ":"emoji/cold_sweat",
                               "冷汗":"emoji/cold_sweat",
                               "こまる":"emoji/confounded",
                               "困る":"emoji/confounded",
                               "かなしい":"emoji/cry",
                               "悲しい":"emoji/cry",
                               "悲":"emoji/cry",
                               "こまった":"emoji/disappointed_relieved",
                               "困った":"emoji/disappointed_relieved",
                               "困":"emoji/disappointed_relieved",
                               "ざんねん":"emoji/disappointed",
                               "残念":"emoji/disappointed",
                               "だめだ":"emoji/dizzy_face",
                               "きく":"emoji/ear",
                               "聞く":"emoji/ear",
                               "耳":"emoji/ear",
                               "みる":"emoji/eyes",
                               "おそろしい":"emoji/fearful",
                               "恐ろしい":"emoji/fearful",
                               "がんばれ":"emoji/fist",
                               "頑張":"emoji/fist",
                               "驚":"emoji/flushed",
                               "手":"emoji/hand",
                               "かわいい":"emoji/heart_eyes",
                               "可愛":"emoji/heart_eyes",
                               "うふふ":"emoji/innocent",
                               "たのしい":"emoji/joy",
                               "楽しい":"emoji/joy",
                               "楽":"emoji/joy",
                               "最高":"emoji/joy",
                               "きっす":"emoji/kissing_closed_eyes",
                               "きす":"emoji/kissing_heart",
                               "キス":"emoji/kissing_heart",
                               "わら":"emoji/laughing",
                               "笑":"emoji/laughing",
                               "くち":"emoji/lips",
                               "口":"emoji/lips",
                               "ますく":"emoji/mask",
                               "マスク":"emoji/mask",
                               "まがお":"emoji/neutral_face",
                               "真顔":"emoji/neutral_face",
                               "だめ":"emoji/no_good",
                               "はな":"emoji/nose",
                               "鼻":"emoji/nose",
                               "おっけー":"emoji/ok_hand",
                               "オッケー":"emoji/ok_hand",
                               "まる":"emoji/ok_woman",
                               "丸":"emoji/ok_woman",
                               "ぱあ":"emoji/open_hands",
                               "しゅん":"emoji/pensive",
                               "たすけて":"emoji/persevere",
                               "助けて":"emoji/persevere",
                               "うつむく":"emoji/person_frowning",
                               "俯":"emoji/person_frowning",
                               "ぷくー":"emoji/person_with_pouting_face",
                               "した":"emoji/point_down",
                               "下":"emoji/point_down",
                               "ひだり":"emoji/point_left",
                               "左":"emoji/point_left",
                               "みぎ":"emoji/point_right",
                               "右":"emoji/point_right",
                               "うえ":"emoji/point_up_2",
                               "上":"emoji/point_up_2",
                               "いのる":"emoji/pray",
                               "祈":"emoji/pray",
                               "ごー":"emoji/punch",
                               "げきど":"emoji/rage",
                               "激怒":"emoji/rage",
                               "わーい":"emoji/raised_hands",
                               "はい":"emoji/raising_hand",
                               "せやな":"emoji/relieved",
                               "はしる":"emoji/runner",
                               "走":"emoji/runner",
                               "きょうふ":"emoji/scream",
                               "恐怖":"emoji/scream",
                               "怖":"emoji/scream",
                               "恐":"emoji/scream",
                               "ねる":"emoji/sleepy",
                               "寝":"emoji/sleepy",
                               "にっこり":"emoji/smile",
                               "やった":"emoji/smiley",
                               "あくま":"emoji/smiling_imp",
                               "悪魔":"emoji/smiling_imp",
                               "にや":"emoji/smirk",
                               "ごうきゅう":"emoji/sob",
                               "号泣":"emoji/sob",
                               "べーだ":"emoji/stuck_out_tongue_closed_eyes",
                               "べー":"emoji/stuck_out_tongue_winking_eye",
                               "さんぐらす":"emoji/sunglasses",
                               "サングラス":"emoji/sunglasses",
                               "にがわらい":"emoji/sweat_smile",
                               "苦笑":"emoji/sweat_smile",
                               "うーん":"emoji/sweat",
                               "あちゃー":"emoji/tired_face",
                               "べろ":"emoji/tongue",
                               "舌":"emoji/tongue",
                               "ふん":"emoji/triumph",
                               "つかれ":"emoji/unamused",
                               "疲":"emoji/unamused",
                               "さようなら":"emoji/wave",
                               "がーん":"emoji/weary",
                               "ガーン":"emoji/weary",
                               "ういんく":"emoji/wink",
                               "ウインク":"emoji/wink",
                               "おいしい":"emoji/yum",
                               "美味":"emoji/yum"]
        return emojiDictionary
        
    }
    
   
    
}
