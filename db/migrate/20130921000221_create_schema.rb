class CreateSchema < ActiveRecord::Migration
  def self.up
    
    create_table :user_groups do |t|
      t.string :name
    end

    create_table :users do |t|
      t.belongs_to :user_group
      t.string :first_name
      t.string :last_name
      t.string :title
    end

    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :image
    end

    create_table :bids do |t|
      t.belongs_to :user
      t.belongs_to :item
      t.decimal :price
      t.datetime :timestamp

      t.timestamps
    end

    add_foreign_key(:bids, :users)
    add_foreign_key(:bids, :items)
    add_index(:bids, :user_id)
    add_index(:bids, :item_id)

  end

  def self.down
    remove_foreign_key(:bids, :users)
    remove_foreign_key(:bids, :items)

    drop_table :bids
    drop_table :users
    drop_table :items
  end
end
