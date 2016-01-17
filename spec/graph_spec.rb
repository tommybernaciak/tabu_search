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

  # describe "#depot" do
  #   it "returns the depot vertex" do
  #     expect(@route.depot).to eq(@depot)
  #     expect(@route.depot).not_to eq(@vertex4)
  #   end
  # end

  # describe "#vertices" do
  #   it "returns the correct array with vertices" do
  #     expect(@route.vertices.first).to eq(@vertex1)
  #     expect(@route.vertices.first).not_to eq(@vertex4)
  #     expect(@route.vertices.first).not_to eq(@vdepot)
  #     expect(@route.vertices.last).to eq(@vertex4)
  #     expect(@route.vertices.last).not_to eq(@vertex2)
  #     expect(@route.vertices.last).not_to eq(@vdepot)
  #     expect(@route.vertices.size).to eq(4)
  #     expect(@route.vertices.include?(@other_vertex)).to eq(false)
  #   end
  # end

  # describe "#path" do
  #   it "returns the correct array with depot, vertices" do
  #     expect(@route.path.first).to eq(@depot)
  #     expect(@route.path.first).not_to eq(@vertex1)
  #     expect(@route.path.last).to eq(@depot)
  #     expect(@route.path.last).not_to eq(@vertex4)
  #     expect(@route.path.size).to eq(6)
  #   end
  # end

  # describe "#cost" do
  #   it "returns the correct cost of a path" do
  #     expect(@route.cost).not_to eq(100)
  #     expect(@route.cost).to eq(40.00)
  #   end
  # end

  # describe "#clone route" do
  #   it "returns a new route with the same depot as previous" do
  #     new_route = Route.clone_route(@route)
  #     expect(new_route.depot).to eq(@depot)
  #     expect(new_route.depot).not_to eq(@vertex1)
  #   end
  #   it "returns a new route with the same veritces as previous" do
  #     new_route = Route.clone_route(@route)
  #     expect(new_route.vertices.first).to eq(@vertex1)
  #     expect(new_route.vertices.last).to eq(@vertex4)
  #     expect(new_route.vertices.first).not_to eq(@vertex4)
  #     expect(new_route.vertices.last).not_to eq(@vertex1)
  #     expect(new_route.vertices.size).to eq(4)
  #   end
  #   it "returns a new route with the same path as previous" do
  #     new_route = Route.clone_route(@route)
  #     expect(new_route.path.first).to eq(@depot)
  #     expect(new_route.path.first).not_to eq(@vertex1)
  #     expect(new_route.path.last).to eq(@depot)
  #     expect(new_route.path.last).not_to eq(@vertex4)
  #     expect(new_route.path.size).to eq(6)
  #   end
  #   it "returns a new route with the same cost as previous" do
  #     new_route = Route.clone_route(@route)
  #     expect(new_route.cost).not_to eq(150)
  #     expect(new_route.cost).to eq(40.00)
  #   end
  # end

  # describe "#random_node" do
  #   it "returns a random vertex from route vertices" do
  #     random = @route.random_node
  #     expect(@route.vertices.include?(random)).to eq(true)
  #     expect(random).not_to eq(@depot)
  #     expect(random).not_to eq(@other_vertex)
  #   end
  # end

  # describe "#find_closest" do
  #   it "returns a vertex closest to other_vertex" do
  #     expect(@route.find_closest(@other_vertex)).to eq(@vertex2)
  #     expect(@route.find_closest(@other_vertex)).not_to eq(@vertex1)
  #     expect(@route.find_closest(@other_vertex)).not_to eq(@vertex3)
  #     expect(@route.find_closest(@other_vertex)).not_to eq(@depot)
  #   end
  # end

  # describe "#add_node" do
  #   it "add a new vertex to route and generate a new path" do
  #     @route.add_node(@other_vertex, @vertex3)
  #     expect(@route.path.size).to eq(7)
  #     expect(@route.vertices.include?(@other_vertex)).to eq(true)
  #     expect(@route.vertices.first(4)).to eq([@vertex1, @vertex2, @other_vertex, @vertex3])
  #     expect(@route.vertices.first(4)).not_to eq([@vertex3, @vertex2, @other_vertex, @vertex1])
  #   end
  # end

  # describe "#delete_node" do
  #   it "delete node and generate a new path" do
  #     @route.delete_node(@vertex2)
  #     expect(@route.path.size).to eq(5)
  #     expect(@route.vertices.include?(@vertex2)).to eq(false)
  #     expect(@route.path.first(4)).to eq([@depot, @vertex1, @vertex3, @vertex4])
  #     expect(@route.path.first(4)).not_to eq([@depot, @vertex1, @vertex2, @vertex3])
  #   end
  # end
end