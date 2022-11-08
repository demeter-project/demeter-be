class ErrorSerializer
  attr_reader :errors
  def initialize(errors)
    @errors = errors
  end

  def show
    { errors: handle(errors.messages) }
  end
  
  def handle(error_hash)
    error_hash.reduce([]) do |array, (att,msg)|
      title = att.to_s.humanize
      msgs = msg.map { |msg| title + " " + msg }
      array << { 
        title: title,
        source: att,
        detail: msgs
      }
    end
  end
 
  def custom_show
    { errors: custom_handle(errors) }
  end

  def custom_handle(error_hash)
    error_hash.reduce([]) do |array, (att,msg)|
      title = att.to_s.humanize
      array << { 
        title: title,
        source: att,
        detail: title + " " + msg
      }
    end
  end
end
