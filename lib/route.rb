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

  def random_node
    @vertices.shuffle.first
  end

  def find_closest(vertex)
    closest = @vertices.first
    closest_distance = Vertex.euclidean_distance(vertex, closest)
    @vertices.each do |v|
      distance = Vertex.euclidean_distance(vertex, v)
      if distance < closest_distance
        closest_distance = distance
        closest = v
      end
    end
    return closest
  end

  def add_node(vertex, position_vertex)
    position = @route.index(position_vertex)
    @route.insert(position, vertex)
  end

  def delete_node(vertex)
    @route.delete(vertex)
  end

end