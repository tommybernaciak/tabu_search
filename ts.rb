# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
require 'csv'
require 'rmagick'
include Magick

require './lib/graph.rb'
require './lib/output_image.rb'
require './lib/route.rb'
require './lib/vertex.rb'
require './lib/tabu_search.rb'

depot, vertices = Graph.import_data('./data/test.csv')
graph = Graph.new(depot, vertices)
graph.initial_solution
puts "initial solution cost: #{graph.cost}"
OutputImage.new(graph, 'initial_solution')
result_graph = TabuSearch.new(graph).run 
puts "result solution cost: #{result_graph.cost}"
OutputImage.new(result_graph, 'result')
