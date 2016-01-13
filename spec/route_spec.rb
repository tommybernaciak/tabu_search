require 'spec_helper'
 
describe Route do
  before :all do
    @depot = Vertex.new(1,35.00,35.00,0.00,0.00,30.00,0.00)
    @vertex1 = Vertex.new(2,41.00,49.00,10.00,0.00,30.00,5.00)
    @vertex2 = Vertex.new(3,35.00,17.00,7.00,0.00,30.00,5.00)
    @vertex3 = Vertex.new(4,55.00,45.00,13.00,0.00,30.00,5.00)
    @vertex4 = Vertex.new(5,55.00,20.00,19.00,0.00,30.00,5.00)
    @vertices = [@vertex1, @vertex2, @vertex3, @vertex4]
    @other_vertex = Vertex.new(6,49.00,50.00,13.00,0.00,30.00,5.00)
  end

  before :each do
    @route = Route.new(@depot, @vertices)
  end

  describe "#depot" do
    it "returns the depot vertex" do
      expect(@route.depot).to eq(@depot)
      expect(@route.depot).not_to eq(@vertex4)
    end
  end

  describe "#vertices" do
    it "returns the correct array with vertices" do
      expect(@route.vertices.first).to eq(@vertex1)
      expect(@route.vertices.first).not_to eq(@vertex4)
      expect(@route.vertices.first).not_to eq(@vdepot)
      expect(@route.vertices.last).to eq(@vertex4)
      expect(@route.vertices.last).not_to eq(@vertex2)
      expect(@route.vertices.last).not_to eq(@vdepot)
      expect(@route.vertices.size).to eq(4)
      expect(@route.vertices.include?(@other_vertex)).to eq(false)
    end
  end

  describe "#path" do
    it "returns the correct array with depot, vertices" do
      expect(@route.path.first).to eq(@depot)
      expect(@route.path.first).not_to eq(@vertex1)
      expect(@route.path.last).to eq(@depot)
      expect(@route.path.last).not_to eq(@vertex4)
      expect(@route.path.size).to eq(6)
    end
  end

  describe "#cost" do
    it "returns the correct cost of a path" do
      expect(@route.cost).not_to eq(100)
      expect(@route.cost).to eq(132.19848847209772)
    end
  end

  describe "#clone route" do
    it "returns a new route with the same depot as previous" do
      new_route = Route.clone_route(@route)
      expect(new_route.depot).to eq(@depot)
      expect(new_route.depot).not_to eq(@vertex1)
    end
    it "returns a new route with the same veritces as previous" do
      new_route = Route.clone_route(@route)
      expect(new_route.vertices.first).to eq(@vertex1)
      expect(new_route.vertices.last).to eq(@vertex4)
      expect(new_route.vertices.first).not_to eq(@vertex4)
      expect(new_route.vertices.last).not_to eq(@vertex1)
      expect(new_route.vertices.size).to eq(4)
    end
    it "returns a new route with the same path as previous" do
      new_route = Route.clone_route(@route)
      expect(new_route.path.first).to eq(@depot)
      expect(new_route.path.first).not_to eq(@vertex1)
      expect(new_route.path.last).to eq(@depot)
      expect(new_route.path.last).not_to eq(@vertex4)
      expect(new_route.path.size).to eq(6)
    end
    it "returns a new route with the same cost as previous" do
      new_route = Route.clone_route(@route)
      expect(new_route.cost).not_to eq(150)
      expect(new_route.cost).to eq(132.19848847209772)
    end
  end

  describe "#random_node" do
    it "returns a random vertex from route vertices" do
      random = @route.random_node
      expect(@route.vertices.include?(random)).to eq(true)
      expect(random).not_to eq(@depot)
      expect(random).not_to eq(@other_vertex)
    end
  end
end