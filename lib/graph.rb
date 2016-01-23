# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Graph
	attr_accessor :vertices, :depot, :routes, :solution
	
  def initialize(depot, vertices)
    @depot = depot
    @vertices = vertices
    @vehicles_numer = 10
    @vehicle_capacity = 200
    @solution = []
  end

  # shuffle vertices, generate routes of given capacity and add them to solution
  def initial_solution
    arrays_of_vertices = Array.new(@vehicles_numer) { Array.new }
    shuffled_vertices = @vertices.shuffle
    arrays_of_vertices.each do |route|
      route_capacity = 0
      while (route_capacity < @vehicle_capacity && shuffled_vertices.size > 0)
        vertex = shuffled_vertices.first
        route_capacity += vertex.demand
        if route_capacity > @vehicle_capacity
          break 
        else
          route << vertex
          shuffled_vertices.delete(vertex)
        end
      end
    end
    generate_routes(arrays_of_vertices, @depot).each { |route| @solution << route }
  end

  def generate_routes(arrays_of_vertices, depot)
    routes = Array.new
    arrays_of_vertices.each do |arr| 
      arr.sort! { |a,b| a.ready_time <=> b.ready_time }
      routes << Route.new(depot, arr, @vehicle_capacity)
    end
    return routes
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
