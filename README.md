# KONBIST
『KONBIST』はコンビニ食品をよく利用する方の為のコンビニ食品用レビュー＆ヘルスケアアプリです！  
 基本機能はログイン無しで閲覧可能ですのでお気軽にご覧下さい。(ゲストログインも用意しています！)  
### [リンク]：( https://konbist.com )  
<br>  

#### トップページ
![トップページ](https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/top.png "トップ画像")  
<br>
## 特に見ていただきたい点
- インフラ
  - Dockerを使い、ECS(FARGATE)/ECRで本番環境をサーバーレスで運用している点。
  - AWSを使い、ALBを通すことで常時SSL通信を行っている点。
  - Terraformを使い、本番環境インフラをコードで管理している点。
  - CircleCIを使い、CD/CDパイプラインを構築している点。
- バックエンド面
  - Ruby on RailsのAPIモードを利用し、APIサーバーとしてフロントエンドからのリクエストに対して<br>JSONデータを返している点
  - トークン認証を利用したログインを実装してる点。
- フロントエンド面
  - Nuxt.jsを採用し、SPA（シングルページアプリケーション）で配信している点。
  - UIフレームワークにVuetifyを使用し、整ったUIを意識している点
- その他
  - フロント側ではESLint/Prettier、バック側でrubcopといったコード解析ツールを採用し<br>読みやすいコードを意識している点
  - チーム開発を意識し、issueやブランチを活用した開発手法を取り入れている点。

<br>

## 使用した技術
* フロントエンド  
  * HTML/CSS
  * Javascript
  * Nuxt.js（SPAモード）
  * Vuetify（UIフレームワーク）
  * Jest（テスト）
  * ESLint/Prettier（コード解析ツール）
* バックエンド  
  * Ruby 2.7.2
  * Ruby on Rails 6.0.3 （APIモード）
  * Rubocop（コード解析ツール）
  * RSpec（テスト）
* インフラ・開発環境  
  * Docker/Docker-compose
  * AWS（ECR,ECS,VPC,S3,Route53,ALB,RDS,ACM,SSM）
  * Terraform（インフラのコード管理）
  * CircleCI（CI/CD）

<br>

## ER図

<br>

![ER](https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/ER1.png "ER図")  
<br>

## AWS構成図

<br>

![AWS](https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/AWS.png "インフラ構成図")  
<br>

<br>

## 機能一覧
* 基本機能
  * ホーム画面表示
  * 新規会員登録
  * ログイン機能
  * ランキング機能（総合・いいね・評価順）
  * 新発売一覧（1ヶ月前までの商品を表示）
  * 発売予定一覧（1ヶ月後までの商品を表示）
  * トピック閲覧
  * フード詳細情報閲覧
  * ユーザーマイページ表示（フードいいね・口コミいいね・フォロー・フォロワー表示）
  * フード口コミ閲覧
* ログイン後機能
  * フード選択機能
  * フードいいね機能（いいね後はフード横アイコンが♡に変わる）
  * 口コミ投稿・編集・削除
  * 口コミいいね機能
  * ユーザーフォロー機能
  * ユーザー登録情報変更（アイコン画像・プロフィール・メールアドレス・パスワード）
  * ユーザー削除



