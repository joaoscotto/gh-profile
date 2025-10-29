class SyncProfileShortUrlJob < ApplicationJob
  queue_as :default

  def perform(profile_id)
    profile = Profile.find(profile_id)

    result = Interactors::Shortio::CreateLink.call(original_url: profile.url)

    if result.success?
      profile.update!(short_url: result.short_url)
    end
  end
end
