# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Graph
	attr_accessor :vertices, :depot, :routes, :solution
  attr_reader :vehicle_capacity
	
  def initialize(depot, vertices, vehicles_numer=2, vehicle_capacity=1000)
    @depot = depot
    @vertices = vertices
    @vehicles_numer = vehicles_numer
    @vehicle_capacity = vehicle_capacity
    @solution = []
  end

  # shuffle vertices, generate routes of given capacity and add them to solution
  def initial_solution
    loop do
      # clear solution after each iteration
      @solution = []
      vertices = shuffle_and_slice_vertices
      generate_routes(vertices, @depot).each { |route| @solution << route }
      break if routes_are_correct?
    end
  end

  def shuffle_and_slice_vertices
    arrays_of_vertices = Array.new(@vehicles_numer) { Array.new }
    arrays_of_vertices = @vertices.shuffle.each_slice((100.0/@vehicles_numer).ceil).to_a.reduce(&:zip).map(&:flatten).transpose.map(&:compact)
    return arrays_of_vertices
  end

  def generate_routes(arrays_of_vertices, depot)
    routes = Array.new
    arrays_of_vertices.each do |arr| 
      arr.sort! { |a,b| a.ready_time <=> b.ready_time }
      routes << Route.new(depot, arr, @vehicle_capacity)
    end
    return routes
  end

  # check if route.demand < vehicle_capacity
  def routes_are_correct?
    @solution.each do |route|
      return false if route.demand > @vehicle_capacity
    end
    return true
  end

  # caluculate distance of solution
  def distance
    distance = 0
    @solution.each { |route| distance += route.distance }
    return distance
  end

  # caluculate distance of solution
  def service_time
    service_time = 0
    @solution.each { |route| service_time += route.service_time }
    return service_time
  end

  # caluculate cost of solution
  def cost
    cost = 0
    @solution.each { |route| cost += route.travel_time_and_cost[0] }
    return cost
  end

  # caluculate cost of solution
  def travel_time
    travel_time = 0
    @solution.each { |route| travel_time += route.travel_time_and_cost[1] }
    return travel_time
  end

  # create a copy of graph object
  def self.clone_graph(graph)
    new_graph = Graph.new(graph.depot, graph.vertices)
    graph.solution.each do |route| 
      new_route = Route.clone_route(route)
      new_graph.solution << new_route
    end
    return new_graph
  end

  # select random two routes, unless random1 has less than two vertices
  def random_routes
    random1, random2 = @solution.sample(2)
    loop do
      random1, random2 = @solution.sample(2)
      break unless random1.vertices.size < 3
    end
    return random1, random2
  end

  private

  # import graph from csv
  def self.import_data(filename)
    vertices = Array.new
    CSV.foreach(filename, col_sep: ',', headers: true) do |row|
      data = row.to_hash
      vertices << Vertex.new(data['id'].to_i, data['x_coord'].to_f, data['y_coord'].to_f, data['demand'].to_f, data['ready_time'].to_f, data['due_time'].to_f, data['service_time'].to_f )
    end
    return set_depot(vertices)
  end

  # set first vertex as depot
  def self.set_depot(vertices)
    depot = vertices.first
    vertices.delete(depot)
    return depot, vertices
  end

end
