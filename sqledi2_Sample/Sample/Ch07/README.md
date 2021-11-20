# 集合演算

## 注意事項

集合演算子は重複行を排除する。  

1. 演算対象となるレコードの列数同じでないといけない。

2. 足し算の対象となるレコードの列のデータ型が一致していること。
NG例：数値型と日付型
```sql
select shohin_id, hanbai_tanka
  from shohin
union
select shohin_id, torokubi
  from shohin2;
```

3. select文はどんなものを指定してもいいが、order by句は最後に一つだけ。

## 重複行を残す集合演算

unionの後にallオプションをつける。  

## 内部結合

inner join  

```sql
select ts.tenpo_id, ts.tenpo_mei, ts.shohin_id, s.shohin_mei, s.hanbai_tanka
  from tenposhohin as ts inner join shohin as s
    on ts.shohin_id = s.shohin_id
where ts.tenpo_id = '000A';
```

結合によって新たなテーブルが作られて、それに対して新たに操作を加える。  

## 外部結合

right/left outer join

```sql
select ts.tenpo_id, ts.tenpo_mei, ts.shohin_id, s.shohin_mei, s.hanbai_tanka
  from tenposhohin as ts right outer join shohin as s
    on ts.shohin_id = s.shohin_id;
```

## クロス結合

2つのテーブルのレコードについて、全ての組み合わせを作る結合方法のことである。  

内部結合の結果は必ずクロス結合の結果に含まれる。  

## coalesce

与えられた引数のうち、NULLでない最初の引数を返してくれる。
