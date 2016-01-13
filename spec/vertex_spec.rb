require 'spec_helper'
 
describe Vertex do
  before :each do
    @vertex = Vertex.new(1,5.00,10.00,20.00,0.00,30.00,5.00)
    @vertex2 = Vertex.new(2,6.00,2.00,20.00,0.00,30.00,5.00)
    @vertex3 = Vertex.new(3,5.00,2.00,20.00,0.00,30.00,5.00)
  end

  describe "#id" do
    it "returns the correct id" do
      expect(@vertex.id).to eq(1)
      expect(@vertex.id).not_to eq(2)
    end
  end

  describe "#x coordinate" do
    it "returns the correct x" do
      expect(@vertex.x_coord).to eq(5.00)
      expect(@vertex.x_coord).not_to eq(10.00)
    end
  end

  describe "#y coordinate" do
    it "returns the correct y" do
      expect(@vertex.y_coord).to eq(10.00)
      expect(@vertex.y_coord).not_to eq(3.00)
    end
  end

  describe "euclidean_distance between vertices" do
    it "returns the euclidean distance between vertices" do
      expect(Vertex.euclidean_distance(@vertex, @vertex2)).to eq(8.06225774829855)
      expect(Vertex.euclidean_distance(@vertex, @vertex3)).to eq(8.0)
      expect(Vertex.euclidean_distance(@vertex, @vertex2)).not_to eq(10.0)
    end
  end
end