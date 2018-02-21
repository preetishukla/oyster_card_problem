require 'spec_helper'

describe Journey do

  context "bus journey" do
    let(:journey) { described_class.new(transport: :bus, start_journey: "Wimbeldon")}

    it "should have a start_journey" do
      expect(journey.start_journey).to eq("wimbeldon")
    end

    it "should have a basic bus fare" do
      expect(journey.basic_fare).to eq(Fare::BUS_JOURNEY_FARE)
    end
  end

  context "tube journey" do

    describe "when user didn't tap in" do
      let(:journey) { described_class.new(transport: :tube, end_journey: "Hammersmith")}

      it "should have a basic tube fare" do
        expect(journey.basic_fare).to eq(Fare::TUBE_FARE)
      end

      it "should have an end_journey" do
        expect(journey.end_journey).to eq("hammersmith")
      end
    end

    describe "when user taped in and taped out" do
      let(:journey) { described_class.new(transport: :tube, start_journey: "Hammersmith")}
      before { journey.complete!(end_journey: "Wimbeldon")}

      it "should have a basic tube fare" do
        expect(journey.basic_fare).to eq(Fare::TUBE_FARE)
      end

      it "should have a start_journey source" do
        expect(journey.start_journey).to eq("hammersmith")
      end

      it "should have an end_journey destination" do
        expect(journey.end_journey).to eq("wimbeldon")
      end
    end
  end

end
