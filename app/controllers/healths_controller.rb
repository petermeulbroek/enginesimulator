class HealthsController < ApplicationController
  before_action :set_health, only: [:show ]

  # GET /healths
  def index
    @healths = Health.last
    json_response(@healths)
  end
end
