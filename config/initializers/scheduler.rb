require 'rufus-scheduler'
require 'time'

# need to prime the pump
Rails.logger.debug 'adding initial data'

scheduler = Rufus::Scheduler::singleton

unless defined?(Rails::Console) || File.split($0).last == 'rake'
  
  # add the fake monitoring data
  scheduler.every Settings.statCreateFrequency, :tags => 'stats', :mutex => 'my_mutex' do
    Rails.logger.info  'monitoring data'
    lstat = Stat.order(:time).last
    
    Stat.create!({time: Time.current, value: lstat.value + Settings.statRange.to_f * (rand - 0.5) })
  end
  
  
  # add the health status
  scheduler.every Settings.healthCreateFrequency, :tags => 'health', :mutex => 'my_mutex' do
    sleep(0.5)
    if Stat.count > 2
    
      lstat = Stat.order(:time).last
    #    byebug
      
      Health.create!({time: Time.current,
                      value: (
                        (
                          lstat.time.to_f > Time.current.to_f - Settings.healthyInterval.to_f &&
                          lstat.value >= Settings.engineMinRPMs.to_f &&
                          lstat.value <= Settings.engineMaxRPMs.to_f
                        ) || 0)
                     })
    end
    
    Rails.logger.info "healthcheck:  Time: %{time}, Interval: %{interval}, Value: %{value}" % {time: Time.current, interval:  Time.current - lstat.time, value: lstat.value}
    
  end
end
