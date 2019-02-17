node_hash = {}
trend = Trend.create(label: 'ハガネZ', collected:'2019-02-17')
node_hash['アニポケ'] = trend.nodes.create(word: 'アニポケ', freq: 100.00)
node_hash['ピカチュウ'] = trend.nodes.create(word: 'ピカチュウ', freq: 100.00)
node_hash['ゲット'] = trend.nodes.create(word: 'ゲット', freq:  62.96)
node_hash['アイアンテール'] = trend.nodes.create(word: 'アイアンテール', freq:  59.26)
node_hash['サトシ'] = trend.nodes.create(word: 'サトシ', freq:  59.26)
node_hash['メル'] = trend.nodes.create(word: 'メル', freq:  29.63)
node_hash['思'] = trend.nodes.create(word: '思', freq:  25.93)
node_hash['ハプウ'] = trend.nodes.create(word: 'ハプウ', freq:  25.93)
node_hash['タン'] = trend.nodes.create(word: 'タン', freq:  22.22)
node_hash['ポケモン'] = trend.nodes.create(word: 'ポケモン', freq:  22.22)
node_hash['バンバドロ'] = trend.nodes.create(word: 'バンバドロ', freq:  11.11)
node_hash['ソルガレオ'] = trend.nodes.create(word: 'ソルガレオ', freq:  11.11)
node_hash['なのか'] = trend.nodes.create(word: 'なのか', freq:  11.11)
node_hash['マーレイン'] = trend.nodes.create(word: 'マーレイン', freq:  11.11)
node_hash['かな'] = trend.nodes.create(word: 'かな', freq:  11.11)
node_hash['マーマネ'] = trend.nodes.create(word: 'マーマネ', freq:   7.41)
node_hash['可能性'] = trend.nodes.create(word: '可能性', freq:   7.41)
node_hash['はがねタイプ'] = trend.nodes.create(word: 'はがねタイプ', freq:   3.70)
node_hash['DP'] = trend.nodes.create(word: 'DP', freq:   3.70)
link = Link.create(corr: 100.00)
node_hash['ピカチュウ'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  88.89)
node_hash['アイアンテール'].links << link
node_hash['ピカチュウ'].links << link
link = Link.create(corr:  66.67)
node_hash['タン'].links << link
node_hash['メル'].links << link
link = Link.create(corr:  66.67)
node_hash['サトシ'].links << link
node_hash['ゲット'].links << link
link = Link.create(corr:  55.56)
node_hash['ハプウ'].links << link
node_hash['ピカチュウ'].links << link
link = Link.create(corr:  55.56)
node_hash['ゲット'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  55.56)
node_hash['ゲット'].links << link
node_hash['ピカチュウ'].links << link
link = Link.create(corr:  44.44)
node_hash['ハプウ'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  44.44)
node_hash['アイアンテール'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  44.44)
node_hash['ポケモン'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  33.33)
node_hash['バンバドロ'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  33.33)
node_hash['思'].links << link
node_hash['アイアンテール'].links << link
link = Link.create(corr:  33.33)
node_hash['タン'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  33.33)
node_hash['思'].links << link
node_hash['ピカチュウ'].links << link
link = Link.create(corr:  33.33)
node_hash['サトシ'].links << link
node_hash['アニポケ'].links << link
link = Link.create(corr:  33.33)
node_hash['バンバドロ'].links << link
node_hash['ピカチュウ'].links << link
node_hash = {}
trend = Trend.create(label: 'カヒリさん', collected:'2019-02-17')
node_hash['カヒリ'] = trend.nodes.create(word: 'カヒリ', freq: 100.00)
node_hash['アニポケ'] = trend.nodes.create(word: 'アニポケ', freq:  26.92)
node_hash['思'] = trend.nodes.create(word: '思', freq:   8.65)
node_hash['ドデカバシ'] = trend.nodes.create(word: 'ドデカバシ', freq:   6.73)
node_hash['ハプウ'] = trend.nodes.create(word: 'ハプウ', freq:   4.81)
node_hash['見'] = trend.nodes.create(word: '見', freq:   4.81)
node_hash['テレビ東京'] = trend.nodes.create(word: 'テレビ東京', freq:   3.85)
node_hash['笑'] = trend.nodes.create(word: '笑', freq:   3.85)
node_hash['サン'] = trend.nodes.create(word: 'サン', freq:   2.88)
node_hash['グズマ'] = trend.nodes.create(word: 'グズマ', freq:   2.88)
node_hash['ポケモン'] = trend.nodes.create(word: 'ポケモン', freq:   2.88)
node_hash['ポケ'] = trend.nodes.create(word: 'ポケ', freq:   2.88)
node_hash['ふぇぇ'] = trend.nodes.create(word: 'ふぇぇ', freq:   1.92)
node_hash['不審者'] = trend.nodes.create(word: '不審者', freq:   1.92)
node_hash['次回予告'] = trend.nodes.create(word: '次回予告', freq:   1.92)
node_hash['バンバドロ'] = trend.nodes.create(word: 'バンバドロ', freq:   1.92)
node_hash['アローラ'] = trend.nodes.create(word: 'アローラ', freq:   1.92)
node_hash['BS'] = trend.nodes.create(word: 'BS', freq:   1.92)
node_hash['テレ東'] = trend.nodes.create(word: 'テレ東', freq:   1.92)
link = Link.create(corr: 100.00)
node_hash['アニポケ'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  25.93)
node_hash['思'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  22.22)
node_hash['ドデカバシ'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  18.52)
node_hash['ハプウ'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  18.52)
node_hash['見'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  14.81)
node_hash['笑'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  11.11)
node_hash['グズマ'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  11.11)
node_hash['サン'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  11.11)
node_hash['ポケ'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  11.11)
node_hash['ポケモン'].links << link
node_hash['カヒリ'].links << link
link = Link.create(corr:  11.11)
node_hash['ドデカバシ'].links << link
node_hash['アニポケ'].links << link
