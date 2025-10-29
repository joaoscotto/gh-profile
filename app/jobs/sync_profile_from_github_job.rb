class SyncProfileFromGithubJob < ApplicationJob
  queue_as :default

  def perform(profile_id)
    profile = Profile.find(profile_id)

    response = Interactors::Github::ProfileScraper.call(url: profile.url)
    return unless response.success?

    profile.assign_attributes(response.data)
    profile.save!
  end
end
