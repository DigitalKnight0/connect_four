class Players
  attr_reader :name, :marker

  def initialize(name, marker = nil)
    @name = name
    @marker = marker
  end
end
