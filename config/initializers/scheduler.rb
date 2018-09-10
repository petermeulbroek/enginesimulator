require 'rufus-scheduler'

# need to prime the pump
Rails.logger.debug 'adding initial data'

scheduler = Rufus::Scheduler::singleton

unless defined?(Rails::Console) || File.split($0).last == 'rake'

  # add the fake monitoring data
  scheduler.every Settings.statCreateFrequency, :tags => 'stats', :mutex => 'my_mutex' do
    Rails.logger.info  'monitoring data'
    lstat = Stat.order(:time).last

    Stat.create!({time: Time.now(), value: lstat.value + Settings.statRange * (rand - 0.5) })
  end

  
  # add the health status
  scheduler.every Settings.healthCreateFrequency, :tags => 'health', :mutex => 'my_mutex' do 
    
    lstat = Stat.order(:time).last

    Health.create!({time: Time.now(),
                    value: ((
                              lstat.time > Time.now() - Settings.healthyInterval &&
                              lstat.value >= Settings.engineMinRPMs &&
                              lstat.value <= Settings.engineMaxRPMs
                            ) || 0)
                   })
    Rails.logger.info "healthcheck:  Time: %{time}, Interval: %{interval}, Value: %{value}" % {time: Time.now(), interval:  Time.now() - lstat.time, value: lstat.value}

  end
  

end
