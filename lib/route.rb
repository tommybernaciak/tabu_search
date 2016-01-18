# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Route
  attr_accessor :vertices, :path
  attr_reader :depot
	
  def initialize(depot, vertices)
    @depot = depot
    @vertices = vertices
    @path = []
    create_path
  end

  def create_path
    # clear previous path
    @path = []
    @vertices.each { |vertex| @path.push(vertex) }
    @path.insert(0, @depot)
    @path.push(@depot)
  end

  def self.clone_route(route)
    vertices = []
    route.vertices.each { |v| vertices << v }
    new_route = Route.new(route.depot, vertices)
    puts "---- ERROR !!!" unless route.cost == new_route.cost 
    return new_route
  end

  # caluculate distance of full path
  def cost
    cost = 0
    (@path.size - 1).times { |i| cost += Vertex.euclidean_distance(@path[i], @path[i+1]) }
    return cost
  end

  # return random vertex from route
  def random_node
    @vertices.shuffle.first
  end

  # find a vertex in a route that is closest to given vertex
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
    position = @vertices.index(position_vertex)
    @vertices.insert(position, vertex)
    create_path
  end

  def delete_node(vertex)
    @vertices.delete(vertex)
    create_path
  end
end
