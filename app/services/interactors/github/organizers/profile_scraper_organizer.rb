module Interactors
  module Github
    module Organizers
      class ProfileScraperOrganizer
        include Interactor::Organizer

        before do
          context.fail!(error: "Page não definida") unless context.page
          context.data = {}
        end

        organize(
          Interactors::Github::ProfileSteps::Username,
          Interactors::Github::ProfileSteps::FollowMetrics,
          Interactors::Github::ProfileSteps::AvatarUrl,
          Interactors::Github::ProfileSteps::Organization,
          Interactors::Github::ProfileSteps::Location,
          Interactors::Github::ProfileSteps::Stars,
          Interactors::Github::ProfileSteps::LastYearContributions
        )
      end
    end
  end
end
