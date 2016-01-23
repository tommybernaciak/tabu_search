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
    penalty_coefficient = 1
  end

  def self.euclidean_distance(v1, v2)
    Math.sqrt( ( v1.x_coord - v2.x_coord ) ** 2.0 + ( v1.y_coord - v2.y_coord ) ** 2.0 )
  end
end
