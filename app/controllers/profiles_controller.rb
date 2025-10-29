# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[update destroy]

  def index
    @query    = params[:q]
    @profile  = Profile.new
    @profiles = Interactors::Profiles::Search.call(query: @query).profiles.presence || []
  end

  def create
    save_profile
  end

  def update
    save_profile
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path(q: params[:q]), notice: "Profile deleted."
  end

  private

  def save_profile
    result = Interactors::Profiles::SaveProfile.call(params: profile_params)
    @profile = result.profile

    if result.success?
      redirect_to profiles_path(q: result.profile.name), notice: "Profile saved successfully."
    else
      redirect_to profiles_path, alert: "There was an error saving the profile."
    end
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :url).merge(id: params[:id])
  end
end
