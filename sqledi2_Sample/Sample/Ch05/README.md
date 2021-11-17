# 複雑な問い合わせ

## ビューとテーブルの違い

実際のデータを保存しているか否か  

ビューはselect文そのものであり、内部的にselect文を実行し仮想的なテーブルを作る。  

## ビューについて

ビューはselect文なので、「ビューを参照する」とは「select文を実行する」ということ。  
これにより最新状態のデータを選択することができる。 

ビューに対する検索は常に2つ以上のselect文が実行されている。  

ビューを重ねることはパフォーマンス低下につながるのでやらない。  

## ビューの制限事項

ビュー定義でorder by句は使わない。
テーブルと同様にビューについても、「行には順序がない」と定められている。  

ビューとテーブルの更新は連動して行われる。したがって集約されたビューは更新不可能。  

## ビューを削除する

postgresqlは削除対象のビューに依存するビューが存在する場合にエラーが出る。  

cascadeオプションをつけることで、依存するビューごと削除することができる。  

## サブクエリ

ビュー定義のselect文を、そのままfrom句の中に入れたのがサブクエリ。  

```sql
select shohin_bunrui, cut_shohin
  from (
    select shohin_bunrui, count(*) as cut_shohin
      from shohin
    group by shohin_bunrui
  ) as shohinsum
```

## スカラ・サブクエリ

必ず1行1列だけの戻り値を返す。  

定数や列名を書くことのできる場所全てで書くことができる。  

## 相関サブクエリ

小分けにしたグループ内での比較をするときに使う。  

```sql
select shohin_bunrui, shohin_mei, hanbai_tanka
    from shohin as s1
  where hanbai_tanka > (select avg(hanbai_tanka)
                            from shohin as s2
                          where s1.shohin_bunrui = s2.shohin_bunrui
                          group by shohin_bunrui );
```

相関サブクエリは、レコードに対して実質的に1行しか返していないとみなされる。  

結合条件は必ずサブクエリの中に書く。
```sql
where s1.shohin_bunrui = s2.shohin_bunrui
```
内から外は見えるが、外からうちは見えない。  
