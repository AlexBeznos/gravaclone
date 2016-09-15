class WalkThroughFootprintJob < ApplicationJob
  queue_as :walk

  def perform(footprint_id, user_id, changes)
    footprint   = Footprint.includes(:application).find(footprint_id)
    application = footprint.application
    user        = User.find(user_id)

    unless application.user_update_url.blank?
      RestClient.post application.user_update_url, prepared_params(user, changes)
    end
  end

  private

  def prepared_params(user, changes)
    {
      "email": user.email,
      "changes": changes
    }.tap do |params|
      params["email"] = changes["email"].first if changes.keys.include? "email"
    end
  end
end
