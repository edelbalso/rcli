require 'lib/core/traceable_object'

class TraceableFactory

  def self.createTraceableObject( className )

    TraceableObject.before_init(className) if TRACE_APP
    
    obj = Object.const_get( className ).new
    
    TraceableObject.after_init(className) if TRACE_APP

    if TRACE_APP
      return TraceableObject.new(obj)
    else
      return obj
    end
  end
    
end
