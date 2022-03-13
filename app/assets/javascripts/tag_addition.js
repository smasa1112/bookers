//jqueryが読み込めるか判断して読み込み
(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['jquery'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('jquery'));
  } else {
    factory(root.jQuery);
  }
}(this, function($) {
  // jqueryを＄として決めちゃう部分
  // ページ更新でtag-it発火
  // document.readyだと初回リロードのみなのでon('turbolinks:load')に
  $(document).on('turbolinks:load',function() {
    $(".tag_form").tagit({  // 指定のセレクタ( 今回は、:tag_list の text_field )に、tag-itを反映
      tagLimit:10,         // タグの最大数
      singleField: true,   // タグの一意性
   // availableTags: ['ruby', 'rails', ..]  自動補完する一覧を設定できる(※ 配列ならok)。今回は、Ajax通信でDBの値を渡す(後述)。
    });
    let tag_count = 10 - $(".tagit-choice").length    // 登録済みのタグを数える
    $(".ui-widget-content.ui-autocomplete-input").attr(
      'placeholder','あと' + tag_count + '個登録できます');
  })

  // タグ入力で、placeholder を変更
  $(document).on("keyup", '.tagit', function() {
    let tag_count = 10 - $(".tagit-choice").length    // ↑ と同じなので、まとめた方がいい。
    $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
  });
}));