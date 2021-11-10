# SQL Practice

## 環境構築

イメージの作成  
```
docker build -t postgres11-ja .
```

コンテナの起動  
```
docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```

ポート状態の確認
```
lsof -i:5432
```

アクセス  
```
psql -U postgres -d postgres -h localhost
```
