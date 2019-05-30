ActiveRecord::Schema.define do
  self.verbose = true

  create_table :tags, force: true do |t|
    t.string :name, index: { unique: true }
    t.string :sticker, default: 'default'
  end

  create_table :hashtags, force: true do |t|
    t.string :name, index: { unique: true }
    t.string :sticker, default: 'default'
  end

  create_table :tweets, force: true do |t|
    t.string :body
    t.integer :tweet_id
  end

  create_table :artists, force: true do |t|
    t.string :name
  end

  create_table :albums, force: true do |t|
    t.string :name
    t.integer :artist_id
    t.integer :producer_id
  end

  create_table :producers, force: true do |t|
    t.string :name
  end

  create_table :songs, force: true do |t|
    t.string :name
    t.integer :album_id
  end
end