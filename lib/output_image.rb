# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class OutputImage
	
	def initialize(graph, filename)
    @graph = graph
    draw_image(filename)
  end

  def draw_image(filename)
    img = Magick::ImageList.new
    img.new_image(1000, 1000)
    draw_depot(@graph.depot, img)
    @graph.vertices.each do |v|
      draw_vertex(v, img)
    end
    img.write("#{filename}.png")
  end

  private

  # multiplied by 10
  def vertex_coordinates(vertex)
    return vertex.x_coord * 10, vertex.y_coord * 10, vertex.x_coord * 10 + 3, vertex.y_coord * 10 + 3
  end

  def draw_depot(depot, image)
    cir = Magick::Draw.new
    cir.fill('#00FFFF')
    cir.stroke('#FF00FF').stroke_width(1)
    x1, y1, x2, y2 = vertex_coordinates(depot)
    cir.circle(x1, y1, x2, y2)
    cir.draw(image)
  end

  def draw_vertex(vertex, image)
    cir = Magick::Draw.new
    cir.fill('#C0C0C0')
    cir.stroke('#000000').stroke_width(1)
    x1, y1, x2, y2 = vertex_coordinates(vertex)
    cir.circle(x1, y1, x2, y2)
    cir.draw(image)      
  end
end
