class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      # パスワード暗号処理
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      # パスワードリセット処理
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false

      ## Rememberable
      # ログイン情報保持処理
      t.datetime :remember_created_at

      ## Trackable
      # ユーザーの履歴保存処理
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # メールによる本登録処理
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # ユーザーロック処理
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name
      t.string :image
      t.string :email

      ## Tokens
      t.text :tokens

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, %i[uid provider], unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,       unique: true
  end
end
