class RemoveJwtBlacklistModel < ActiveRecord::Migration[8.0]
  def up
    drop_table :jwt_blacklists
  end

  def down
    create_table :jwt_blacklists do |t|
      t.string :jti
      t.boolean :revoked

      t.timestamps
    end
    add_index :jwt_blacklists, :jti
  end
end
