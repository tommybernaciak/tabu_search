# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Graph
	attr_accessor :vertices, :depot, :routes, :solution
	
  def initialize(depot, vertices)
    @depot = depot
    @vertices = vertices
    @vehicles_numer = 3
    @solution = []
  end

  # shuffle vertices, split then to random arrays, generate routes and add them to solution
  def initial_solution
    vertices = random_split(@vertices, @vehicles_numer)
    generate_routes(vertices, @depot).each { |route| @solution << route }
  end

  # caluculate cost of solution
  def cost
    cost = 0
    @solution.each { |route| cost += route.cost }
    return cost
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

  def random_split(array, number)
    slice_size = (array.size/Float(number)).ceil
    array.shuffle.each_slice(slice_size).to_a
  end

  def generate_routes(arrays_of_vertices, depot)
    routes = Array.new
    arrays_of_vertices.each { |arr| routes << Route.new(depot, arr) }
    return routes
  end

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
