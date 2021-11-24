# frozen_string_literal: true
# このファイルは、求人情報ページから抽出したい情報を連想配列として記入しています。
# 必要に応じて、コメントアウトしてください。
# なお、ここで指定したvalueはタイトル行として出力されるCSVの一行目にも使われます。

{
    'ID_kjNo' => '求人番号',
    'ID_uktkYmd' => '受付年月日',
    'ID_shkiKigenHi' => '紹介期限日',
    'ID_juriAtsh' => '受理安定所',
    'ID_kjKbn' => '求人区分',
    'ID_tryKoyoKibo' => 'トライアル雇用併用の希望',
    'ID_jgshNo' => '事業所番号',
    'ID_jgshMeiKana' => '事業所名(カナ)',
    'ID_jgshMei' => '事業所名',
    'ID_szciYbn' => '所在地(郵便番号)',
    'ID_szci' => '所在地',
    'ID_hp' => 'ホームページ',
    'ID_sksu' => '職種',
    'ID_shigotoNy' => '仕事内容',
    'ID_koyoKeitai' => '正社員',
    'ID_hakenUkeoiToShgKeitai' => '派遣・請負等',
    'ID_koyoKikan' => '雇用期間',
    'ID_shgBsYubinNo' => '就業場所(郵便番号)',
    'ID_shgBsJusho' => '就業場所(住所)',
    'ID_shgBsMyorEki' => '就業場所(最寄り駅)',
    'ID_shgBsKotsuShudan' => '最寄り駅からの交通手段',
    'ID_shgBsShyoJn' => '就業場所までの所要時間',
    'ID_shgBsKitsuTsak' => '就業場所(屋内の受動喫煙対策)',
    'ID_mycarTskn' => 'マイカー通勤',
    'ID_tenkinNoKnsi' => '転勤の可能性',
    'ID_tenkinNoKnsiTenkinHanni' => '転勤範囲',
    'ID_nenreiSegn' => '年齢制限',
    'ID_nenreiSegnHanni' => '年齢制限範囲',
    'ID_nenreiSegnGaitoJiyu' => '年齢制限該当理由',
    'ID_nenreiSegnNoRy' => '年齢制限の理由',
    'ID_grki' => '学歴',
    'ID_hynaKiknt' => '必要な経験',
    'ID_hynaMenkyoSkku' => '必要な免許・資格',
    'ID_trialKikan' => '試用期間の有無',
    'ID_trialKikanKikan' => '試用期間の期間',
    'ID_trialKikanChuuNoRodoJkn' => '試用期間中の労働条件',
    'ID_chgn' => '賃金(a+b+c)',
    'ID_khky' => '基本給(a)',
    'ID_tgktNiShwrTat' => '定期的に支払われる手当(b)',
    'ID_koteiZngyKbn' => '固定残業代の有無',
    'ID_koteiZngy' => '固定残業代(c)',
    'ID_koteiZngyTkjk' => '固定残業代に関する特記事項',
    'ID_sntaTatFukiJk' => 'その他の手当等付記事項(d)',
    'ID_thkinRodoNissu' => '月平均労働日数',
    'ID_tsknTat' => '通勤手当',
    'ID_tsknTatKingaku' => '通勤手当(月額)',
    'ID_chgnSkbi' => '賃金締切日',
    'ID_chgnSrbi' => '賃金支払日',
    'ID_chgnSrbiTsuki' => '支払月',
    'ID_chgnSrbiHi' => '支払日',
    'ID_shokyuSd' => '昇給制度',
    'ID_shokyuMaeNendoJisseki' => '昇給(前年度実績)',
    'ID_sokkgSkrt' => '昇給金額/昇給率',
    'ID_shoyoSdNoUmu' => '賞与制度',
    'ID_shoyoMaeNendoUmu' => '賞与(前年度実績)',
    'ID_shoyoMaeNendKaisu' => '賞与の回数(前年度実績)',
    'ID_shoyoKingaku' => '賞与金額',
    'ID_shgJn1' => '就業時間1',
    'ID_shgJiknTkjk' => '就業時間に関する特記事項',
    'ID_jkgiRodoJn' => '時間外労働時間の有無',
    'ID_thkinJkgiRodoJn' => '月平均時間外労働時間',
    'ID_sanrokuKyotei' => '36協定における特別条項',
    'ID_kyukeiJn' => '休憩時間',
    'ID_nenkanKjsu' => '年間休日数',
    'ID_kyjs' => '休日',
    'ID_shukFtskSei' => '週休二日制',
    'ID_nenjiYukyu' => '半年後の有給休暇日数',
    'ID_knyHoken' => '加入保険等',
    'ID_tskinKsi' => '退職金共済',
    'ID_tskinSd' => '退職金制度',
    'ID_tnsei' => '定年制',
    'ID_tnseiTeinenNenrei' => '定年年齢',
    'ID_saiKoyoSd' => '再雇用制度',
    'ID_saiKoyoSdJgnNenrei' => '再雇用上限年齢',
    'ID_kmec' => '勤務延長',
    'ID_nkj' => '入居可能住宅',
    'ID_nkjTkjk' => '入居可能住宅(提供時期)',
    'ID_riyoKanoTkjShst' => '利用可能託児施設',
    'ID_jgisKigyoZentai' => '従業員数(全体)',
    'ID_jgisShgBs' => '従業員数(就業場所)',
    'ID_jgisUchiJosei' => '従業員数(女性)',
    'ID_jgisUchiPart' => '従業員数(パート)',
    'ID_setsuritsuNen' => '設立年',
    'ID_shkn' => '資本金',
    'ID_rodoKumiai' => '労働組合',
    'ID_jigyoNy' => '事業内容',
    'ID_kaishaNoTokucho' => '会社の特徴',
    'ID_yshk' => '代表者の役職',
    'ID_dhshaMei' => '代表者名',
    'ID_hoNinNo' => '法人番号',
    'ID_fltmShgKisoku' => '就業規則(フルタイム)',
    'ID_partShgKisoku' => '就業規則(パートタイム)',
    'ID_ikujiKyugyoStkJisseki' => '育児休業取得実績',
    'ID_kaigoKyugyoStkJisseki' => '介護休業取得実績',
    'ID_kangoKyukaStkJisseki' => '看護休暇取得実績',
    'ID_saiyoNinsu' => '採用人数',
    'ID_boshuRy' => '募集理由',
    'ID_selectHoho' => '選考方法',
    'ID_selectKekkaTsuch' => '選考結果通知タイミング',
    'ID_shoruiSelectKekka' => '書類選考結果通知',
    'ID_mensetsuSelectKekka' => '面接選考結果通知',
    'ID_ksshEnoTsuchiHoho' => '求職者への通知方法',
    'ID_selectNichijiTo' => '選考日時等',
    'ID_selectBsYubinNo' => '選考場所(郵便番号)',
    'ID_selectBsJusho' => '選考場所(住所)',
    'ID_selectBsMyorEki' => '選考場所(最寄り駅)',
    'ID_selectBsMyorEkiKotsuShudan' => '最寄り駅からの交通手段',
    'ID_selectBsShyoJn' => '最寄り駅からの所要時間',
    'ID_oboShoruitou' => '応募書類等',
    'ID_sntaNoOboShorui' => 'その他応募書類',
    'ID_oboShoruiNoSofuHoho' => '応募書類の送付方法',
    'ID_yusoNoSofuBsYubinNo' => '郵送の送付場所(郵便番号)',
    'ID_yusoNoSofuBsJusho' => '郵送の送付場所(住所)',
    'ID_obohen' => '応募書類の返戻',
    'ID_ttsYkm' => '担当者(役職)',
    'ID_ttsTts' => '担当者',
    'ID_ttsTel' => '担当者(電話番号)',
    'ID_ttsFax' => '担当者(FAX)',
    'ID_ttsEmail' => '担当者(電子メール)',
    'ID_kjTkjk' => '求人に関する特記事項',
    'ID_shokumuKyuSd' => '職務給制度',
    'ID_fukushokuSd' => '復職制度の有無',
    'ID_fukushokuSdNoNy' => '復職制度の内容',
    'ID_knsSdNy' => '研修制度の内容'
}
