function paranoid --wraps="echo '-1' | sudo tee /proc/sys/kernel/perf_event_paranoid" --description "alias paranoid echo '-1' | sudo tee /proc/sys/kernel/perf_event_paranoid"
  echo '-1' | sudo tee /proc/sys/kernel/perf_event_paranoid $argv
        
end
