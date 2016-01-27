# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Route
  attr_accessor :vertices, :path
  attr_reader :depot, :capacity
	
  def initialize(depot, vertices, capacity, penalty_coefficient=1.0)
    @depot = depot
    @vertices = vertices
    @capacity = capacity
    @penalty_coefficient = penalty_coefficient
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
    new_route = Route.new(route.depot, vertices, route.capacity)
    return new_route
  end

  # caluculate distance of full path
  def distance
    distance = 0
    (@path.size - 1).times { |i| distance += Vertex.euclidean_distance(@path[i], @path[i+1]) }
    return distance
  end

  # caluculate demand of full path
  def demand
    demand = 0
    (@path.size - 1).times { |i| demand += @path[i].demand }
    return demand
  end

  # caluculate cost of full path / time windows
  def travel_time_and_cost
    cost = 0
    travel_time = 0
    (@path.size - 1).times do |i|
      current_vertex = @path[i]
      next_vertex = @path[i+1]
      # travel time = travel distance
      distance = Vertex.euclidean_distance(current_vertex, next_vertex)
      travel_time += distance
      # calculate how early or how late is service
      early_cost = (next_vertex.ready_time - travel_time) > 0 ? (next_vertex.ready_time - travel_time) : 0
      late_cost = (travel_time - next_vertex.due_time) > 0 ? (travel_time - next_vertex.due_time) : 0
      # calculate penalty cost
      cost += early_cost * @penalty_coefficient + late_cost * @penalty_coefficient
      # add service_time and early_cost (wait-for-service time) to travel time
      travel_time += next_vertex.service_time + early_cost
    end
    return cost, travel_time
  end

  # caluculate service_time of full path
  def service_time
    service_time = 0
    (@path.size - 1).times { |i| service_time += @path[i].service_time }
    return service_time
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
