class Revenue
  attr_reader :id,
              :revenue
  def initialize(result)
    @revenue = result
    @id = nil
  end
end
