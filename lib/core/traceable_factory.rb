require 'core/traceable_object'

class TraceableFactory

  def self.createTraceableObject( className, *args )

    TraceableObject.before_init(className) if Rcli.trace_app
    
    obj = Object.const_get( className ).new(*args)
    
    TraceableObject.after_init(className) if Rcli.trace_app

    if Rcli.trace_app
      return TraceableObject.new(obj,*args)
    else
      return obj
    end
  end
    
end
