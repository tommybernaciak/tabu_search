# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
require 'csv'
require 'rmagick'
include Magick

require './lib/graph.rb' 
require './lib/output_image.rb' 
require './lib/route.rb' 
require './lib/vertex.rb' 

g = Graph.new('./data/test.csv')
OutputImage.new(g, 'test')