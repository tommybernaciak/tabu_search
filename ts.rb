# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
require 'csv'
require 'rmagick'
require 'benchmark'
include Magick

require './lib/graph.rb'
require './lib/output_image.rb'
require './lib/route.rb'
require './lib/vertex.rb'
require './lib/tabu_search.rb'

filename = ARGV[0]
depot, vertices = Graph.import_data("./data/#{filename}.csv")
graph = Graph.new(depot, vertices)
OutputImage.new(graph, "#{filename}-initial_setup")
graph.initial_solution
puts "----- INITIAL SOLUTION:"
puts "-- distance: #{graph.distance}"
puts "-- travel time: #{graph.travel_time}"
puts "-- cost: #{graph.cost}"
# puts "-- demands:"
# puts graph.solution.size

OutputImage.new(graph, "#{filename}-initial_solution")

result_graph = Graph.new(depot, vertices)
# measure time of algorithm
time = Benchmark.measure {
  result_graph = TabuSearch.new(graph).run
}

puts "----- RESULT SOLUTION:"
puts "-- distance: #{result_graph.distance}"
puts "-- travel time: #{result_graph.travel_time}"
puts "-- cost: #{result_graph.cost}"
# puts "-- demands:"
# result_graph.solution.each do |route|
#   puts route.demand
# end
OutputImage.new(result_graph, "#{filename}-result")
puts "----- ALGORITHM TIME:"
puts time
#cpu time, system time, total and real elapsed time.