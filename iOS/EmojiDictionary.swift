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
                               "よくない":"-1",
                               "いいね":"1",
                               "良":"1",
                               "いかり":"angry",
                               "怒り":"angry",
                               "うわー":"astonished",
                               "うれしい":"blush",
                               "嬉しい":"blush",
                               "嬉":"blush",
                               "ごめん":"bow",
                               "謝":"bow",
                               "にかっ":"bowtie",
                               "はくしゅ":"clap",
                               "拍手":"clap",
                               "ひやあせ":"cold_sweat",
                               "冷汗":"cold_sweat",
                               "こまる":"confounded",
                               "困る":"confounded",
                               "かなしい":"cry",
                               "悲しい":"cry",
                               "悲":"cry",
                               "こまった":"disappointed_relieved",
                               "困った":"disappointed_relieved",
                               "困":"disappointed_relieved",
                               "ざんねん":"disappointed",
                               "残念":"disappointed",
                               "だめだ":"dizzy_face",
                               "きく":"ear",
                               "聞く":"ear",
                               "耳":"ear",
                               "みる":"eyes",
                               "おそろしい":"fearful",
                               "がんばれ":"fist",
                               "頑張":"fist",
                               "驚":"flushed",
                               "手":"hand",
                               "かわいい":"heart_eyes",
                               "可愛":"heart_eyes",
                               "うふふ":"innocent",
                               "たのしい":"joy",
                               "楽しい":"joy",
                               "楽":"joy",
                               "きっす":"kissing_closed_eyes",
                               "きす":"kissing_heart",
                               "キス":"kissing_heart",
                               "わら":"laughing",
                               "笑":"laughing",
                               "くち":"lips",
                               "口":"lips",
                               "ますく":"mask",
                               "マスク":"mask",
                               "まがお":"neutral_face",
                               "真顔":"neutral_face",
                               "だめ":"no_good",
                               "はな":"nose",
                               "鼻":"nose",
                               "おっけー":"ok_hand",
                               "オッケー":"ok_hand",
                               "まる":"ok_woman",
                               "丸":"ok_woman",
                               "ぱあ":"open_hands",
                               "しゅん":"pensive",
                               "たすけて":"persevere",
                               "助けて":"persevere",
                               "うつむく":"person_frowning",
                               "俯":"person_frowning",
                               "ぷくー":"person_with_pouting_face",
                               "した":"point_down",
                               "下":"point_down",
                               "ひだり":"point_left",
                               "左":"point_left",
                               "みぎ":"point_right",
                               "右":"point_right",
                               "うえ":"point_up_2",
                               "上":"point_up_2",
                               "いのる":"pray",
                               "祈":"pray",
                               "ごー":"punch",
                               "げきど":"rage",
                               "激怒":"rage",
                               "わーい":"raised_hands",
                               "はい":"raising_hand",
                               "せやな":"relieved",
                               "はしる":"runner",
                               "走":"runner",
                               "きょうふ":"scream",
                               "恐怖":"scream",
                               "怖":"scream",
                               "恐":"scream",
                               "ねる":"sleepy",
                               "寝":"sleepy",
                               "にっこり":"smile",
                               "やった":"smiley",
                               "あくま":"smiling_imp",
                               "悪魔":"smiling_imp",
                               "にや":"smirk",
                               "ごうきゅう":"sob",
                               "号泣":"sob",
                               "べーだ":"stuck_out_tongue_closed_eyes",
                               "べー":"stuck_out_tongue_winking_eye",
                               "さんぐらす":"sunglasses",
                               "サングラス":"sunglasses",
                               "にがわらい":"sweat_smile",
                               "苦笑":"sweat_smile",
                               "うーん":"sweat",
                               "あちゃー":"tired_face",
                               "べろ":"tongue",
                               "舌":"tongue",
                               "ふん":"triumph",
                               "つかれ":"unamused",
                               "疲":"unamused",
                               "さようなら":"wave",
                               "がーん":"weary",
                               "ガーン":"weary",
                               "ういんく":"wink",
                               "ウインク":"wink",
                               "おいしい":"yum",
                               "美味":"yum"]
        return emojiDictionary
        
    }
    
   
    
}
