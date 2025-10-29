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

  def update_fts_index
    fields = %i[
      name url short_url username followers following
      organization location stars last_year_contributions avatar_url
    ]

    sql = <<~SQL
      INSERT OR REPLACE INTO profiles_fts(rowid, #{fields.join(', ')})
      VALUES (?, #{fields.map { "?" }.join(", ")})
    SQL

    self.class.connection.execute(
      self.class.sanitize_sql_array([ sql, id ] + fields.map { |field| send(field) || "" })
    )
  end

  def remove_from_fts_index
    self.class.connection.execute("DELETE FROM profiles_fts WHERE rowid = #{id}")
  end
end
