module Interactors
  module Github
    module ProfileSteps
      class Stars
        include Interactor

        def call
          context.data[:stars] =
            context
              .page
              .query_selector_all(".Layout-main .UnderlineNav a")
              .find { |link| link.text_content.include?("Stars") }
              .query_selector(".Counter")
              &.get_attribute("title")
        end
      end
    end
  end
end
