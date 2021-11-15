# 集約と並べ替え

## 集約関数

集約関数はNULLを除外する。  
そのためNULLがある列でSUM(hanbai_tanka)などとしても問題ない。  
四則演算にNULLが含まれると問答無用でNULLとなるが、そもそもNULLを含んでいない。  

## 最大値・最小値

MAX/MIN関数はほとんど全てのデータ型に適用できる。  
SUM/AVG関数は数値のみにしか使えない。  

## 実行順序

SQLは見た目の並び順とDBMS内部の実行順序が一致しない。  
FROM -> WHERE -> GROUP BY -> SELECT  

## GROUP BY句のよくある間違い

GROUP BY句を使うときは、SELECT句に集約キー以外の列名をかけない。  

GROUP BY句にSELECT句でつけた別名は使えない。  

GROUP BY句を使っても結果の表示順序はソートされない。  

COUNT(*)などの集約関数を書ける場所はSELECT句とHAVING句とORDER BY句だけ。  

## WHERE句とHAVIGN句の役割の違い

WHERE句：行に対する条件指定  
HAVING句：グループに対する条件指定  

集約キーに対する条件は、HAVING句ではなくWHERE句に書く。  

WHERE句の方がHAVING句より実行速度が速い  
ソートという処理はマシンにかなりの負荷をかけるため、このソートする行数が少ない方がいい。  
そのため、ソートの前にWHERE句で条件を絞ると、ソート対象の行数を少なくすることができる。  

WHERE句の条件で指定する列にインデックスを作成することで、処理を高速化できる。

## ORDER BY句
ORDER BY句は常にSELECT文の最後尾に書く。  
結果を返す直前で行う必要がある。  

ORDER BYは複数ソートキーを指定することができる。  
左のキーから優先的に使用される。  

ソートキーにNULLが含まれる場合、先頭か末尾にまとめられる。  

ORDER BYでは、SELECT句でつけた別名を利用できる。  

列番号は使わない。  
将来消されるべき機能として扱われている。  
```sql
select shohin_id, shohin_mei, hanbai_tanka, shiire_tanka from shohin oreder by 3 desc 1;
```
