require 'rufus-scheduler'

# need to prime the pump
Rails.logger.debug 'adding initial data'

scheduler = Rufus::Scheduler::singleton

unless defined?(Rails::Console) || File.split($0).last == 'rake'
  
  # add the health status
  scheduler.every Settings.healthCreateFrequency, :tags => 'health', :mutex => 'my_mutex' do 
    Rails.logger.info 'healthcheck'
    lstat = Stat.order(:time).last

    Health.create!({time: Time.now(),
                    value: ((
                              lstat.time > Time.now() - Settings.healthyInterval &&
                              lstat.value >= Settings.engineMinRPMs &&
                              lstat.value <= Settings.engineMaxRPMs
                            ) || 0)
                   })
    
  end
  
  # add the fake monitoring data
  scheduler.every Settings.statCreateFrequency, :tags => 'stats', :mutex => 'my_mutex' do
    Rails.logger.info  'monitoring data'
    lstat = Stat.order(:time).last

    Stat.create!({time: Time.now(), value: (lstat.value + rand(Settings.statRange) - Settings.statRange/2 ) })
  end

end
