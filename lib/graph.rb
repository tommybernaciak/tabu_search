class Graph
	attr_reader :vertices, :depot
	
	def initialize(vertices)
    @depot, @vertices = set_depot(vertices)
  end

  private

  def set_depot(vertices)
    depot = vertices.first
    vertices.delete(0)
    return depot, vertices
  end

end