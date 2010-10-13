class TraceableObject

  def initialize(obj)
    @obj = obj
  end

  def self.before_init(classname)
    puts "-- s - #{classname}.initialize() ---"
  end
  
  def self.after_init(classname)
    puts "-- f - #{classname}.initialize() ---"
    
  end

  def before_trace(sym)
    puts "-- s - #{@obj.class}.#{sym}() ---"
  end

  def after_trace(sym)
    puts "-- f - #{@obj.class}.#{sym}() ---"
  end

  def self.before_trace(className, sym)
    puts "-- s - #{className}::#{sym}() ---"
  end

  def self.after_trace(className, sym)
    puts "-- f - #{className}::#{sym}() ---"
  end
  
  def method_missing(sym, *args, &block)
    before_trace(sym)
    @obj.send sym, *args, &block
    after_trace(sym)
  end

  def self.call_class_method(className, sym, *args, &block)
    self.before_trace(className, sym) if Rcli.trace_app
    retval = Object.const_get( className ).send sym, *args, &block
    self.after_trace(className, sym) if Rcli.trace_app
    retval
  end
  
end