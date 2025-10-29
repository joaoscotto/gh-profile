module Interactors
  module Github
    module ProfileSteps
      class AvatarUrl
        include Interactor

        def call
          context.data[:avatar_url] =
            context
              .sidebar
              .query_selector(".avatar-user")
              .get_attribute("src")
        end
      end
    end
  end
end
