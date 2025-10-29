module Interactors
  module Github
    module ProfileSteps
      class Organization
        include Interactor

        def call
          context.data[:organization] =
            context
              .sidebar
              .query_selector("li[aria-label^='Organization:']")
              &.get_attribute("aria-label")
              &.sub(/^Organization:\s*/, "")
        end
      end
    end
  end
end
