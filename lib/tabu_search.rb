# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class TabuSearch

  def initialize(graph)
    @graph = graph
    @tabu_list = Array.new
    @tabu_list_size = 7
  end

  def run
    new_graph = Graph.clone(@graph)
    return new_graph
  end

  private

  def is_tabu?(solution, tabu_list)
    tabu_list.each do |forbidden_edge|
      return true if forbidden_edge == solution
    end
    return false
  end

end