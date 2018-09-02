require 'rufus-scheduler'

# need to prime the pump
Rails.logger.debug 'adding initial data'

Stat.create!({time: Time.now(), value: 50.0 })
Health.create!({time: Time.now(), value: true})



scheduler = Rufus::Scheduler::singleton

# add the health status

scheduler.every Settings.healthCreateFrequency do
  Rails.logger.info 'healthcheck'
  lstat = Stat.order(:time).last

  Health.create!({time: Time.now(),
                  value: (lstat.time > Time.now() - Settings.healthyInterval  && # machine is recording
                          lstat.value >= Settings.engineMinRPMs &&             # engine is on
                          lstat.value <= Settings.engineMaxRPMs                # engine is not over-revved
                         )})
  
end

# add the fake monitoring data
scheduler.every Settings.statCreateFrequency do
  Rails.logger.info  'monitoring data'
  lstat = Stat.order(:time).last

  Stat.create!({time: Time.now(), value: (lstat.value + rand(Settings.statRange) - Settings.statRange/2 ) })
end
