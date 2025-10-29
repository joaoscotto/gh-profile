# frozen_string_literal: true

class Profile < ApplicationRecord
  after_commit :update_fts_index, on: [ :create, :update ]
  after_commit :remove_from_fts_index, on: :destroy

  validates :name, :url, presence: true

  scope :fulltext_search, ->(query) {
    return none if query.blank?

    joins("INNER JOIN profiles_fts ON profiles.id = profiles_fts.rowid")
      .where("profiles_fts MATCH ?", query)
      .select("profiles.*, bm25(profiles_fts) AS rank")
      .order("rank")
  }

  private

  FTS_FIELDS = [
    :name, :url, :short_url, :username, :followers, :following,
    :organization, :location, :stars, :last_year_contributions, :avatar_url
  ]

  def update_fts_index
    values = FTS_FIELDS.map { |field| self.class.connection.quote(send(field) || "") }.join(", ")

    self.class.connection.execute(<<~SQL)
      INSERT OR REPLACE INTO profiles_fts(rowid, #{FTS_FIELDS.join(', ')})
      VALUES (#{id}, #{values});
    SQL
  end

  def remove_from_fts_index
    self.class.connection.execute("DELETE FROM profiles_fts WHERE rowid = #{id}")
  end
end
