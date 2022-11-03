class ErrorSerializer
  attr_reader :errors
  def initialize(errors)
    @errors = errors
  end

  
  def show
    { errors: errors.messages.handle }
  end
  
  def custom_show
    custom_errors = errors.reduce([]) do |array, (att,msg)|
      title = att.to_s.capitalize
      array << { 
        title: title,
        detail: title + " " + msg
      }
    end
    { errors: custom_errors }
  end
  
  def handle
    reduce([]) do |array, (att,msg)|
      title = att.to_s.capitalize
      array << { 
        title: title,
        detail: title + " " + msg.first
      }
    end
  end
end
