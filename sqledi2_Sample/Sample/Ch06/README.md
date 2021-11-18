# 関数、述語、CASE式

## SQLの方言による違い

半角英字が1バイトなのに対して漢字のような日本語全角文字は2バイト以上を使って表現される。  
MySQLのlength関数はバイト数を数える。  

## 述語

「戻り値が真理値になること」という条件を満たす関数のこと。  

真理値（true/false/unknown）  

「%」は0文字以上の任意の文字列を意味する特殊な記号  
「_」は任意の1文字を意味する  

## Between

betweenは100と1000の両端を含む（100 <= hanbai_tanka <= 1000）
```sql
select * from shohin where hanabai_tanka between 100 and 1000;
```

## IN

引数にサブクエリを取ることができる。  
つまり、引数にテーブルを指定することができる。  

## NOT IN

NOT IN引数にNULLを含んではならない。

## EXISTS

常に相関サブクエリを引数に取る。  

サブクエリは常に「select *」を使う。  
レコードの存在有無しか見ないため、どんな列が返されるかを一切気にしない。  

## CASE式

ELSE句は省略可能だが、後から読む人が見落とさないように省略しないこと。  

単純CASE式  
評価した式をcase後に記述する。
```sql
select shohin_mei,
  case shohin_bunrui
    when ... then ...
    .
    .
    .
    else null
  and as abc_shohin_bunrui
from shohin;
```

検索CASE式  
when句ごとに違う列に対して条件を指定することができる。
```sql
select shohin_mei,
  case when ...
       then ...
       .
       .
       .
       .
       else null
  end as abc_shohin_bunrui
from shohin;
```
