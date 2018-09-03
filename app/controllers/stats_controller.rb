class StatsController < ApplicationController
  before_action :set_stat, only: [:show ]
  # GET /stats
  def index
    @stats = Stat.all
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
end
