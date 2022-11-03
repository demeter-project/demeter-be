class ErrorSerializer
  attr_reader :errors
  def initialize(errors)
    @errors = errors
  end

  def handle
    errors.messages.reduce([]) do |array, (att,msg)|
      title = att.to_s.capitalize
      array << { 
        title: title,
        detail: title + " " + msg.first
      }
    end
  end

  def custom
    require 'pry'; binding.pry
  end

  def show
    { errors: handle }
  end
end