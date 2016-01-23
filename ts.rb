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

puts "----- INITIAL SOLUTION:"
puts "-- distance: #{graph.distance}"
puts "-- travel time: #{graph.travel_time}"
puts "-- cost: #{graph.cost}"
puts "-- demands:"
graph.solution.each do |route|
  puts route.demand
end
OutputImage.new(graph, 'initial_solution')

result_graph = TabuSearch.new(graph).run 

puts "----- RESULT SOLUTION:"
puts "-- distance: #{result_graph.distance}"
puts "-- travel time: #{result_graph.travel_time}"
puts "-- cost: #{result_graph.cost}"
puts "-- demands:"
result_graph.solution.each do |route|
  puts route.demand
end
OutputImage.new(result_graph, 'result')
