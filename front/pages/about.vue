<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="7" lg="9" sm="11" cols="12">
        <v-card class="mx-auto">
          <v-card-text class="mt-7 display-3 font-weight-black text-center">
            KONBISTとは？
          </v-card-text>
          <v-col cols="12">
            <h3 class="mt-7 text-center">
              KONBISTはコンビニ食品をよく利用する方の為の
            </h3>
            <h3 class="mt-3 text-center">
              コンビニ食品用レビュー＆ヘルスケアアプリです。
            </h3>
            <h4 class="mt-16 text-center">
              基本機能はログイン無しで閲覧可能ですのでお気軽にご覧下さい。
            </h4>
          </v-col>
          <div class="ml-8">
            <h2 class="mt-16">◎基本機能</h2>
            <ul class="ml-3 mt-3">
              <li>ホーム画面表示</li>
              <li>新規会員登録</li>
              <li>ログイン機能</li>
              <li>ランキング機能（総合・いいね・評価順）</li>
              <li>新発売一覧（1ヶ月前までの商品を表示）</li>
              <li>発売予定一覧（1ヶ月後までの商品を表示）</li>
              <li>トピック閲覧</li>
              <li>フード詳細情報閲覧</li>
              <li>フード口コミ閲覧</li>
              <!-- <li>検索機能（作成中）</li> -->
            </ul>
          </div>
          <div>
            <h2 class="mt-16 ml-8">◎ログイン後機能</h2>
            <p class="ml-8 mt-2 subtitle-1 font-weight-bold">フード選択機能</p>
            <v-row class="ml-7">
              <v-col xl="7" lg="8" sm="10" cols="10">
                <p>KONBISTのメイン機能となります。</p>
                <p class="ma-0">
                  ログインすると画面左上にメニューアイコンが表示され、
                </p>
                <p class="ma-0">クリックするとメニューバーが表示されます。</p>
              </v-col>
              <v-col xl="7" lg="8" sm="10" cols="10" class="pt-0">
                <v-img
                  src="https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/open_menu.gif"
                  alt="open_menu.gif"
                />
              </v-col>
              <v-col xl="7" lg="8" sm="10" cols="10">
                <p class="ma-0">
                  フードアイコン又はフード詳細ページの「献立に追加」ボタンを
                </p>
                <p>クリックするとメニューバーにフードが追加されます。</p>
                <p class="ma-0">
                  フードを追加するとカロリーなどの合計情報が即表示されます。
                </p>
                <p class="ma-0">
                  追加したフードは削除ボタンをクリックすると削除できます。
                </p>
              </v-col>
              <v-col xl="7" lg="8" sm="10" cols="10" class="pt-0">
                <v-img
                  src="https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/add_food.gif"
                  alt="add_food.gif"
                />
              </v-col>
              <v-col xl="7" lg="8" sm="10" cols="10">
                <p class="ma-0">
                  メニューバー下部にある食べる日と時間帯を選択して
                </p>
                <p class="ma-0">
                  「献立セット」ボタンをクリックするとマイページの献立に登録されます。
                </p>
                <p class="ma-0">
                  食のバランスを考えてメニューをセットしましょう!
                </p>
              </v-col>
              <v-col xl="7" lg="8" sm="10" cols="10" class="pt-0">
                <v-img
                  src="https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/add_menu.gif"
                  alt="add_menu.gif"
                />
              </v-col>
            </v-row>
            <p class="ml-8 mt-2 subtitle-1 font-weight-bold">その他機能</p>
            <ul class="ml-11 mt-3">
              <li>フードいいね機能（いいね後はフード横アイコンが♥に変わる）</li>
              <li>口コミ投稿・編集・削除</li>
              <li>口コミいいね機能</li>
              <li>ユーザーフォロー機能</li>
              <li>
                ユーザーマイページ表示（フードいいね・口コミいいね・フォロー・フォロワー表示）
              </li>
              <li>
                ユーザー登録情報変更（アイコン画像・プロフィール・メールアドレス・パスワード）
              </li>
              <li>ユーザー削除</li>
              <!-- <li>メニューいいね機能（作成中）</li> -->
            </ul>
            <p class="ml-9 mt-3 pb-8 caption">
              いずれの機能も非同期で処理され即時反映されます。
            </p>
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      foods: [],
      loading: false,
      tab: null,
      items: [{ title: "冬のおすすめ" }],
    }
  },
  computed: {},
  created() {},
  methods: {},
}
</script>
