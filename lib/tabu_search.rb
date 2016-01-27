# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class TabuSearch

  def initialize(graph, tabu_list_size=7, max_iteration=10000)
    @graph = graph
    @tabu_list_size = tabu_list_size
    @max_iteration = max_iteration
    @tabu_list = Array.new(@tabu_list_size)
  end

  def run
    current = Graph.clone_graph(@graph)
    best = Graph.clone_graph(current)
    @max_iteration.times do
      candidate = Graph.clone_graph(current)
      # choose two random routes
      # choose random node from r1 and find closest node from r2
      route1, route2, node1, node2 = select_nodes(candidate)
      # relocate n1 from r1 to r2, place it before n2
      route2.add_node(node1, node2)
      route1.delete_node(node1)
      # check if candidate is on tabu_list
      unless is_tabu?(candidate)
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

  # choose two random routes
  # choose random node from r1 and find closest node from r2
  def select_nodes(graph)
    begin
      route1, route2 = graph.random_routes
      node1 = route1.random_node
      node2 = route2.find_closest(node1)
    end while ( (route2.demand + node1.demand) > graph.vehicle_capacity )
    return route1, route2, node1, node2
  end

  # check if given graph is on tabu_list
  def is_tabu?(graph)
    @tabu_list.each do |forbidden_move|
      unless forbidden_move.nil?
        return true if forbidden_move.solution.map(&:path) == graph.solution.map(&:path)
      end
    end
    return false
  end

  # add graph to tabu list
  def add_to_tabu_list(solution)
    @tabu_list.push(solution)
    @tabu_list.shift if @tabu_list.size > @tabu_list_size
  end
end
