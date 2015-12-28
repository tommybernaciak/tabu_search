# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class Graph
	attr_reader :vertices, :depot
	
	def initialize(filename)
    verts = import_data(filename)
    @depot, @vertices = set_depot(verts)
  end

  private

  def import_data(filename)
    vertices = Array.new
    CSV.foreach(filename, col_sep: ',', headers: true) do |row|
      data = row.to_hash
      vertices << Vertex.new(data['id'].to_i, data['x_coord'].to_f, data['y_coord'].to_f, data['demand'].to_f, data['ready_time'].to_f, data['due_time'].to_f, data['service_time'].to_f )
    end
    return vertices
  end

  def set_depot(vertices)
    depot = vertices.first
    vertices.delete(depot)
    return depot, vertices
  end

end
