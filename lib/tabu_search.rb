# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class TabuSearch

  def initialize(graph)
    @graph = graph
    @tabu_list_size = 7
    @max_iteration = 20
    @tabu_list = Array.new(@tabu_list_size)
  end

  def run
    current = Graph.clone_graph(@graph)
    best = Graph.clone_graph(current)
    @max_iteration.times do
      candidate = Graph.clone_graph(current)
      # tabu search
      # choose two random routes
      route1, route2 = candidate.random_routes
      # choose random node from r1
      node1 = route1.random_node
      # find closest node from r2
      node2 = route2.find_closest(node1)
      # relocate n1 from r1 to r2, place it before n2
      route2.add_node(node1, node2)
      route1.delete_node(node1)

      if is_tabu?(candidate)
        #do nothing?
      else
        if candidate.cost < current.cost
          current = Graph.clone_graph(candidate)
          best = Graph.clone_graph(candidate) if candidate.cost < best.cost
        end
        add_to_tabu_list(candidate)
      end
    end
    return best
  end

  private

  def is_tabu?(graph)
    @tabu_list.each do |forbidden_move|
      unless forbidden_move.nil?
        return true if forbidden_move.solution == graph.solution
      end
    end
    return false
  end

  def add_to_tabu_list(solution)
    @tabu_list.push(solution)
    @tabu_list.shift if @tabu_list.size > @tabu_list_size
  end

end
