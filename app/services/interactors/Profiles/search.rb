module Interactors
  module Profiles
    class Search
      include Interactor

      delegate :query, to: :context

      def call
        context.profiles = ::Profile.fulltext_search(sanitize_query(query))
      end

      private

      def sanitize_query(query)
        return "" if query.blank?

        if query.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
          "\"#{query.gsub('"', '""')}\""
        else
          query.gsub(/[@"'*(),\[\]{}]/, " ").strip.split(/\s+/).join(" OR ")
        end
      end
    end
  end
end
