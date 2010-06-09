# shortcut to call a class method that you would like to be traceable
def ccm(className, sym, *args, &block)
  TraceableObject.call_class_method(className, sym, *args, &block)
end
# shortcut to instantiate a traceable object
def cto(className)
  TraceableFactory.createTraceableObject(className)
end

def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
  if first_letter_in_uppercase
    lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
  else
    lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
  end
end