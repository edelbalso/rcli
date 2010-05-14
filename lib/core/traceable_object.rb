class TraceableObject
  def initialize(obj)
    @obj = obj
  end

  def before_trace

  end

  def after_trace

  end

  def method_missing(sym, *args, &block)
    before_trace
    @obj.send sym, *args, &block
    after_trace
  end
end