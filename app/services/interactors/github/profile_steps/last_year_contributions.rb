module Interactors
  module Github
    module ProfileSteps
      class LastYearContributions
        include Interactor

        def call
          context.data[:last_year_contributions] =
            context
              .page
              .query_selector("#user-profile-frame #js-contribution-activity-description")
              .text_content.strip.scan(/\d+/).join
        end
      end
    end
  end
end
