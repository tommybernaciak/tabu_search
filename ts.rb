# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
require 'csv'
require 'rmagick'
include Magick

require './lib/graph.rb' 
require './lib/output_image.rb' 
require './lib/route.rb' 
require './lib/vertex.rb' 

depot, vertices = Graph.import_data('./data/test.csv')
graph = Graph.new(depot, vertices)
graph.initial_solution
OutputImage.new(graph, 'initial_solution')