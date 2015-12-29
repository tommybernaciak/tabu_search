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

  def cost
    cost = 0
    (@route.size - 1).times { |i| cost += Vertex.euclidean_distance(@route[i], @route[i+1]) }
    return cost
  end

end