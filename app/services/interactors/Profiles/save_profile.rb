# frozen_string_literal: true

module Interactors
  module Profiles
    class SaveProfile
      include Interactor

      delegate :profile, :params, to: :context

      def call
        context.profile = params[:id].present? ? Profile.find(params[:id]) : Profile.new
        profile.assign_attributes(params)

        context.fail!(errors: profile.errors.full_messages) unless profile.save

        SyncProfileFromGithubJob.perform_later(profile.id)
        SyncProfileShortUrlJob.perform_later(profile.id)
      end
    end
  end
end
