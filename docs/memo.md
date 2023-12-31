- リンク
  - https://leanpub.com/everydayrailsrspec-jp
- RSpec が提供するデフォルトのマッチャ
  - https://github.com/rspec/rspec-expectations
- RSpec の公式ドキュメント
  - https://rspec.info/documentation/

memo
- describeとcontextは技術的に交換可能
  - describeはクラスやシステムの機能に関するアウトライン
  - contextは特定の状態に関するアウトライン
- before ブロックの中に書かれたコードは内側の各テストが実⾏される前に実⾏される
  - ただしdescribeやcontextのブロックによってスコープが限定される
- テストについて
  - 期待する結果は能動形で明⽰的に記述する
  - 起きてほしいことと、起きてほしくないことをテストする
  - 境界値テストをする
  - 可読性を上げるためにスペックを整理する
- Railsではサンプルデータを生成する手段としてフィクスチャと呼ばれる機能がデフォルトで提供されている
- ただしテクスチャはActiveRecordを使わないためモデルのバリデーションのような機能が無視される
- `FactoryBot.build`を使うと新しいテストオブジェクトをメモリ内に保存し、`FactoryBot.create`を使うとアプリケーションのテスト⽤データベースにオブジェクトを永続化する
- sequenceを使うことでユニークな値を作ることができる`sequence(:email) { |n| "tester#{n}@example.com" }`
- associationは`association :user`のように簡単に定義できる
- factoryの重複を減らすテクニックは以下二つ
  - 入れ子にすることで、ファクトリの継承を使う方法
  - traitを使う方法
- factory_botのgithub
  - https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
- コントローラスペックではユーザーインターフェースを無視して、パラメータを直接コントローラのメソ
ッドに送信する
- システムスペックではアプリケーションの利用者が使うものと全く同じwebフォームを使って新しいプロジェクトを作成する
- システムスペックでは⼀つのexample、もしくは⼀つのシナリオで複数のエクスペクテーションを書くのは問題ない
- システムスペックではtake_screenshotメソッドでテスト内のあらゆる場所でシミュレート中のブラウザの画像を作成可能（JSドライバのみ）
- Capybara はブラウザの操作をシミュレートするだけであり、プログラム上のやりとりは特にシミュレートしない
- 共通のワークフローをモジュールに切り出すことでコードの重複を減らすことができる
- beforeの中に書いたコードはdescribeやcontextの内部に書いたテストを実⾏するたびに毎回実⾏される
- これは不要なデータを作成することで遅くなるなど、テストに予期しない影響を及ぼす恐れがある
- letを使うことで呼び出した際にそのレコードを作成することができる、なお該当のテスト終了後はデータは掃除される
- let!はブロックを即座に実行されるため、内部データも即座に作成される
- shared_contextを用いることで、複数のテストファイルで必要なセットアップを行うことが可能
- RSpecはテスト内で失敗したらそこで即座に停止するが、aggregate_failuresの機能を使うことで他のexpectも続けて実行可能
- モックは本物のオブジェクトのフリをするオブジェクト、テストダブルとも呼ばれる
- モックはデータベースにアクセスしないためテストにかかる時間は短くなる
- スタブはオブジェクトのメソッドをオーバーライドして事前に決められた値を返す、テスト用に本物の結果を返すダミーメソッド
  - double, instance_doubleを使ってモックオブジェクトを作成する（検証機能がついているのはinstance_doubleの方）
    - 第一引数はモックオブジェクトの名前、第二引数以降はモックオブジェクトのメソッドとその返り値を置く
  - allow(note):
    - allow メソッドは、あるオブジェクトの振る舞いを制御するためのもので、この場合 note オブジェクトに対して振る舞いを設定する準備
  - .to receive(:user):
    - to receive(:user) は、note オブジェクトの user メソッドが呼ばれることを期待
    - このメソッドが呼ばれた場合、それに対する振る舞いを定義
  - .and_return(user):
    - and_return(user) は、user を返すように指定
    - note.user が呼ばれると、設定した user モックオブジェクトを返す
  - allow(note).to receive(:user).and_return(user) を使うことで、note オブジェクトの user メソッドを呼ぶ際に、モックオブジェクト user を返すように制御可能
  - `allow(モックオブジェクト).to receive(メソッド名)` の形で、モックに呼び出し可能なメソッドを設定できる
  - `allow(実装を置き換えたいオブジェクト).to receive(置き換えたいメソッド名).and_return(返却したい値やオブジェクト)`
- VCRを使うことで、テスト速度を高速に保ち、APIの呼び出しを必要最小限に抑えることができる
- 外部へのHTTPリクエストを監視して、作られたカセットをもとにテストを実行する、外部APIに新たなリクエストを投げることはない
