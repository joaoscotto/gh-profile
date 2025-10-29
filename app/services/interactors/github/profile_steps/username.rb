module Interactors
  module Github
    module ProfileSteps
      class Username
        include Interactor

        def call
          context.data[:username] =
            context
              .sidebar
              &.query_selector(".vcard-names .vcard-username")
              &.text_content
              &.strip
        end
      end
    end
  end
end
