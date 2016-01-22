# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class OutputImage

  COLORS = ['#0000e6', '#FF0000', '#ff66ff', '#862d86', '#8c8c8c', '#000000', '#43bc6f', '#FF8800', '#4da6ff', '#e5e600']
	#        [ dark blue, red, pink, purple, grey, black, light green, orange, light blue, yellow ]
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
    @graph.solution.each_with_index do |route, index|
      (route.path.size - 1).times { |i| draw_line(img, route.path[i], route.path[i+1], COLORS[index]) }
    end
    img.write("#{filename}.png")
  end

  private

  # multiplied by 10
  def vertex_coordinates(vertex)
    return vertex.x_coord * 10, vertex.y_coord * 10, vertex.x_coord * 10 + 5, vertex.y_coord * 10 + 5
  end

  # multiplied by 10
  def line_coordinates(v1, v2)
    return v1.x_coord * 10, v1.y_coord * 10, v2.x_coord * 10, v2.y_coord * 10
  end

  def draw_depot(depot, image)
    cir = Magick::Draw.new
    cir.fill('#000000')
    cir.stroke('#000000').stroke_width(1)
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

  def draw_line(image, vertex1, vertex2, color)
    line = Magick::Draw.new
    x1, y1, x2, y2 = line_coordinates(vertex1, vertex2)
    line.stroke(color).stroke_width(2)
    line.line(x1, y1, x2, y2)
    line.draw(image)
  end

end
