class StatsController < ApplicationController
  before_action :set_stat, only: [:show ]
  # GET /stats
  def index
    @stats = Stat.all
    json_response(@stats)
  end

end
