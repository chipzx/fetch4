class CreateServiceRequestCallsRanks < ActiveRecord::Migration
  def change
    create_view :service_request_calls_ranks
  end
end
