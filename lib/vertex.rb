# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
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

end
