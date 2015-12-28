# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Route
  attr_reader :depot, :vertices, :route
	
	def initialize(depot, vertices)
    @depot = depot
    @vertices = vertices
    @route = create_route
  end

  def create_route
    route = Array.new
    @vertices.each { |v| route << v }
    route.insert(0, @depot)
    route << @depot
    return route
  end

end