class SetupWalkThroughFootprintsJob < ApplicationJob
  queue_as :setup

  def perform(user_id, changes)
    Footprint.where(user_id: user_id).find_each do |footprint|
      WalkThroughFootprintJob.perform_async(footprint.id, user_id, changes)
    end
  end
end
