# SQLの高度な処理

## ウィンドウ

PARTITION BYによって区切られたレコードの集合を、「ウィンドウ」と呼ぶ。  
「範囲」を表す。  

ウィンドウ関数は、原則としてSELECT句のみで使える。  

集約関数をウィンドウ関数として使った時は、「自分のレコード（カレントレコード）」を基準に集計対象を判断する。  

## フレーム

```sql
rows 2 preceding
```

「2行前まで」というフレーム指定となる。  
- 自分（カレントレコード）
- 自分より1行前のレコード
- 自分より2行前のレコード

## order byの2つの意味

over句内のorder byはあくまでウィンドウ関数がどういう順序で計算するかを決めるだけの役割しか持っていない。  

```sql
select shohin_mei, shohin_bunrui, hanbai_tanka,
  rank () over (order by hanbai_tanka) as ranking
from shohin;
```

上記のorder by句で指定した連番でソートして結果が表示されるのは、あくまで独自仕様である。  
順番にソートされるとは限らない。  

下記のようにselect文の結果のレコード順序を保証すのは、select文の最後でorder byを指定する。
```sql
select shohin_mei, shohin_bunrui, hanbai_tanka,
  rank () over (order by hanbai_tanka) as ranking
  from shohin;
order by ranking;
```

## ROLLUP

group by句の集約キーリストに対して、ROLLUPを使用すると以下2つの組み合わせについての集約を一度に計算している。  

- group by ()
  - 超集合というかたまり。
  - group byでは作られない合計の行のこと。
  - 集約キーはデフォルトでNULLである。
- group by (shohin_bunrui)

合計と小計を一度に求められる。  
最も粒度の細かい集約レベルから小計->合計と、集約の単位がどんどん大きくなっていくイメージ。  

## GROUPING

引数にとった列の値が超集合のため生じたNULLなら1を、それ以外なら0を返す。 

## CASE式の注意

CASE式の戻り値は、すべての分岐において一致していなければならない。
型変換
```sql
CAST(torokubi as varchar(16))
```

## CUBE

group byに与えられた集約キーの「すべての組みわせ」をごった煮のように1つの結果に含めてしまう機能。  

## COALESCE

nullではない最初の引数を返す。
```sql
coalesce(torokubi, cast('0001-01-01' as date))
```

## NULLS FIRST

NULLS FIRSTをORDER BY句で指定することで、明示的にNULLを順序付けの際に先頭に持ってくる。
ただし、先頭か最後に持ってくるかは、DBMSの実装によるところがある。  
