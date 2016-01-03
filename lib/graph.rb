# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Graph
	attr_reader :vertices, :depot, :routes, :solution
	
	def initialize(depot, vertices)
    @depot, @vertices = depot, vertices
    @vehicles_numer = 3
    @solution = Array.new
  end

  # shuffle vertices, split then to random arrays, generate routes and add them to solution
  def initial_solution
    vertices = random_split(@vertices, @vehicles_numer)
    generate_routes(vertices, @depot).each { |r| @solution << r }
  end

  # create a copy of graph object
  def self.clone(graph)
    new_graph = Graph.new(graph.depot, graph.vertices)
    new_graph.clone_solution(graph)
    return new_graph
  end

  # caluculate cost of solution
  def cost
    cost = 0
    @solution.each { |r| cost += r.cost }
    return cost
  end

  # create a new solution with the same routes
  def clone_solution(graph)
    graph.solution.each { |route| @solution << Route.new(route.depot, route.vertices) }
  end

  def random_routes
    random1, random2 = @solution.sample(2)
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

  def self.import_data(filename)
    vertices = Array.new
    CSV.foreach(filename, col_sep: ',', headers: true) do |row|
      data = row.to_hash
      vertices << Vertex.new(data['id'].to_i, data['x_coord'].to_f, data['y_coord'].to_f, data['demand'].to_f, data['ready_time'].to_f, data['due_time'].to_f, data['service_time'].to_f )
    end
    return set_depot(vertices)
  end

  def self.set_depot(vertices)
    depot = vertices.first
    vertices.delete(depot)
    return depot, vertices
  end

end
