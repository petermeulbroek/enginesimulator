class StatsController < ApplicationController
  before_action :set_stat, only: [:show ]
  before_action :validate_params

  # GET /stats
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

    json_response({result: "OK"})
  end

  def restart
    # want to shut down the stat queue
    squeue = Rufus::Scheduler.singleton.jobs.select{ |j| j.opts.has_value?("stats")}.first
    squeue.resume

    json_response({result: "OK"})
  end

  
  def corrupt
    # corrupt data so the app looks permanently unhealthy
    Stat.create(time: Time.now(), value: -2000)

    json_response({result: "OK"})
  end

  def uncorrupt
    # uncorrupt data
    Stat.where("value < 0").delete_all
    json_response({result: "OK"})

  end
  private
  
  def validate_params
    unless  params.nil?
      params.permit(:since, :all)
    end
  end

end
