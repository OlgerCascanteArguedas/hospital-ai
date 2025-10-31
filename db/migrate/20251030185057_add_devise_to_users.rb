# db/migrate/20251030185057_add_devise_to_users.rb
class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def up
    # No toques :email si ya existe
    change_table :users, bulk: true do |t|
      # Devise core
      t.string   :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      # Recoverable
      t.string   :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

      # Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      # Opcionales: descomenta solo si vas a usar estos módulos en User
      # Trackable
      # t.integer  :sign_in_count, default: 0, null: false unless column_exists?(:users, :sign_in_count)
      # t.datetime :current_sign_in_at unless column_exists?(:users, :current_sign_in_at)
      # t.datetime :last_sign_in_at unless column_exists?(:users, :last_sign_in_at)
      # t.string   :current_sign_in_ip unless column_exists?(:users, :current_sign_in_ip)
      # t.string   :last_sign_in_ip unless column_exists?(:users, :last_sign_in_ip)

      # Confirmable
      # t.string   :confirmation_token unless column_exists?(:users, :confirmation_token)
      # t.datetime :confirmed_at unless column_exists?(:users, :confirmed_at)
      # t.datetime :confirmation_sent_at unless column_exists?(:users, :confirmation_sent_at)
      # t.string   :unconfirmed_email unless column_exists?(:users, :unconfirmed_email)

      # Lockable
      # t.integer  :failed_attempts, default: 0, null: false unless column_exists?(:users, :failed_attempts)
      # t.string   :unlock_token unless column_exists?(:users, :unlock_token)
      # t.datetime :locked_at unless column_exists?(:users, :locked_at)
    end

    # Índices (crearlos solo si faltan)
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    # add_index :users, :confirmation_token, unique: true if column_exists?(:users, :confirmation_token) && !index_exists?(:users, :confirmation_token)
    # add_index :users, :unlock_token, unique: true if column_exists?(:users, :unlock_token) && !index_exists?(:users, :unlock_token)
  end

  def down
    remove_index :users, :email if index_exists?(:users, :email)
    remove_index :users, :reset_password_token if index_exists?(:users, :reset_password_token)

    change_table :users, bulk: true do |t|
      remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
      remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
      remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
      remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)

      # Opcionales: solo si los creaste en up
      # remove_column :users, :sign_in_count if column_exists?(:users, :sign_in_count)
      # remove_column :users, :current_sign_in_at if column_exists?(:users, :current_sign_in_at)
      # remove_column :users, :last_sign_in_at if column_exists?(:users, :last_sign_in_at)
      # remove_column :users, :current_sign_in_ip if column_exists?(:users, :current_sign_in_ip)
      # remove_column :users, :last_sign_in_ip if column_exists?(:users, :last_sign_in_ip)
      # remove_column :users, :confirmation_token if column_exists?(:users, :confirmation_token)
      # remove_column :users, :confirmed_at if column_exists?(:users, :confirmed_at)
      # remove_column :users, :confirmation_sent_at if column_exists?(:users, :confirmation_sent_at)
      # remove_column :users, :unconfirmed_email if column_exists?(:users, :unconfirmed_email)
      # remove_column :users, :failed_attempts if column_exists?(:users, :failed_attempts)
      # remove_column :users, :unlock_token if column_exists?(:users, :unlock_token)
      # remove_column :users, :locked_at if column_exists?(:users, :locked_at)
    end
  end
end
