class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :url
      t.string :short_url
      t.string :username
      t.string :followers
      t.string :following
      t.string :organization
      t.string :location
      t.integer :stars
      t.integer :last_year_contributions
      t.string :avatar_url

      t.timestamps
    end

    execute <<-SQL
      CREATE VIRTUAL TABLE IF NOT EXISTS profiles_fts USING fts5(
        name,
        url,
        short_url,
        username,
        followers,
        following,
        organization,
        location,
        stars UNINDEXED,
        last_year_contributions UNINDEXED,
        avatar_url,
        content='profiles',
        content_rowid='id'
      );
    SQL
  end
end
