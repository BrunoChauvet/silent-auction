class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.string :name
      t.string :value
    end

    add_index(:preferences, :name, :unique => true)

    create_table :user_groups do |t|
      t.string :name
      t.integer :sort_order
    end

    add_index(:user_groups, :name, :unique => true)

    create_table :users do |t|
      t.belongs_to :user_group
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :pin
      t.boolean :admin, :default => false
    end

    create_table :categories do |t|
      t.string :name
    end

    add_index(:categories, :name, :unique => true)

    create_table :items do |t|
      t.belongs_to :category
      t.string :name
      t.text :description
      t.string :by
      t.string :code
      t.string :image
      t.string :sponsor
      t.decimal :start_price
      t.decimal :bid_increment
    end

    add_index(:items, :code, :unique => true)

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
    add_index(:bids, :timestamp)
  end
end
