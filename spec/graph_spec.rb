require 'spec_helper'
 
describe Graph do
  before :all do
    @depot = Vertex.new(1,10.00,10.00,0.00,0.00,30.00,0.00)
    @vertex1 = Vertex.new(2,10.00,20.00,10.00,0.00,30.00,5.00)
    @vertex2 = Vertex.new(3,20.00,20.00,7.00,0.00,30.00,5.00)
    @vertex3 = Vertex.new(4,20.00,10.00,13.00,0.00,30.00,5.00)
    @vertex4 = Vertex.new(5,15.00,10.00,19.00,0.00,30.00,5.00)
    @vertex5 = Vertex.new(6,50.00,10.00,19.00,0.00,30.00,5.00)
    @vertex6 = Vertex.new(5,60.00,10.00,19.00,0.00,30.00,5.00)
    @vertex7 = Vertex.new(5,5.00,10.00,19.00,0.00,30.00,5.00)
    @vertex8 = Vertex.new(5,15.00,30.00,19.00,0.00,30.00,5.00)
    @vertex9 = Vertex.new(5,25.00,10.00,19.00,0.00,30.00,5.00)
    @other_vertex = Vertex.new(6,20.00,22.00,13.00,0.00,30.00,5.00)
  end

  before :each do
    vertices = [@vertex1, @vertex2, @vertex3, @vertex4, @vertex5, @vertex6, @vertex7, @vertex8, @vertex9]
    graph = Graph.new(@depot, vertices)
    graph.initial_solution
  end

end