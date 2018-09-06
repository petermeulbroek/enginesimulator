class HealthsController < ApplicationController
  before_action :set_health, only: [:show ]
  before_action :validate_params

  # GET /healths
  def index
    if params[:all]
      @healths = Health.all.select(:time, :value)
    elsif params[:since]
      @healths = Health.where('time > :since', {since: params[:since]}).select(:time, :value)
    else
      @healths = Health.order(time: :asc ).select(:time, :value).last
    end

    json_response(@healths)
  end

    private
  
  def validate_params
    unless  params.nil?
      params.permit(:since, :all)
    end
  end
end
