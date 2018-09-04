class StatsController < ApplicationController
  before_action :set_stat, only: [:show ]
  # GET /stats
  before_action :validate_params

  def index

    if params[:all]
      @stats = Stat.all.select(:time, :value)
    elsif params[:since]
      @stats = Stat.where('time > :since', {since: params[:since]}).select(:time, :value)
    else
      @stats = Stat.order(time: :asc ).select(:time, :value).last
    end

    json_response(@stats)

  end

  def shutdown
    # want to shut down the stat queue
    squeue = Rufus::Scheduler.singleton.jobs.select{ |j| j.opts.has_value?("stats")}.first
    squeue.pause

  end

  def destroy
    # corrupt data so the app looks permanently unhealthy
    Stat.create(time: Time.now(), value: -2000)
  end


  private
  
  def validate_params
    unless  params.nil?
      params.permit(:since, :all)
    end
  end

end
