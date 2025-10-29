module Interactors
  module Github
    module ProfileSteps
      class Location
        include Interactor

        def call
          context.data[:location] =
            context
              .sidebar
              .query_selector("li[aria-label^='Home location:']")
              &.get_attribute("aria-label")
              &.sub(/^Home location:\s*/, "")
        end
      end
    end
  end
end
