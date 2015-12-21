require 'csv'

require './lib/graph.rb' 
require './lib/output_image.rb' 
require './lib/route.rb' 
require './lib/vertex.rb' 

g = Graph.new( Vertex.import_data('./data/test.csv') )
puts g.depot
puts g.vertices