def s
  trace = ''
  m =  caller[0][/`([^']*)'/, 1] 
  if "#{self.class}" == "Class"
    trace = "-- s - #{self}::#{m}() --- "
  else  
    trace = "-- s - #{self.class}.#{m}() --- "
  end
  
    puts trace if TRACE_APP
end

def f
  trace = ''
  m =  caller[0][/`([^']*)'/, 1] 
  if "#{self.class}" == "Class"
    trace = "-- f - #{self}::#{m}() --- "
  else  
    trace = "-- f - #{self.class}.#{m}() --- "
  end
  
  puts trace if TRACE_APP
end