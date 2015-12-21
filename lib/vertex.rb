class Vertex
	attr_reader :id, :x_coord, :y_coord, :demand, :ready_time, :due_time, :service_time

  def initialize(id, x_coord, y_coord, demand, ready_time, due_time, service_time)
    @id = id
    @x_coord = x_coord
    @y_coord = y_coord
    @demand = demand
    @ready_time = ready_time
    @due_time = due_time
    @service_time = service_time
  end

  private

  def self.import_data(filename)
    vertices = Array.new
    CSV.foreach(filename, col_sep: ',', headers: true) do |row|
      data = row.to_hash
      vertices << Vertex.new(data['id'].to_i, data['x_coord'].to_f, data['y_coord'].to_f, data['demand'].to_f, data['ready_time'].to_f, data['due_time'].to_f, data['service_time'].to_f )
    end
    return vertices
  end
end
