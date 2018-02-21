require 'spec_helper'

describe Zone do

  describe "when travelling one zone in zone one only" do
    let(:zone) { described_class.new("earls court", "holborn")}

    it "should count correct amount of zones" do
      expect(zone.perform).to eq({count_zone: "one", check_zone_one: true})
    end
  end
  
  describe "when travelling three zones" do
    let(:zone) { described_class.new("holborn", "wimbeldon")}

    it "should count correct amount of zones" do
      expect(zone.perform).to eq({count_zone: "three", check_zone_one: true})
    end
  end

  describe "when travelling two zones excluding first zone" do
    let(:zone) { described_class.new("hammersmith", "wimbeldon")}

    it "should count correct amount of zones" do
      expect(zone.perform).to eq({count_zone: "two", check_zone_one: false})
    end
  end

end
