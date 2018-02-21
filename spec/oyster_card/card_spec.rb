require 'spec_helper'

describe Card do

  let(:card) { described_class.new }

  describe "initial state for card" do
    it "should have default balance of 0" do
      expect(card.balance).to eq(0)
    end
  end

  describe "top up(amount)" do
    before { card.top_up(30) }

    it 'should successfully add amount to card(top up)' do
      expect(card.balance).to eq(30)
    end

    context "invalid top up(amount)" do
      it "fails if the top up amount is of string" do
        expect{card.top_up("hello")}.to raise_error("Please enter valid amount or amount must be higher than 0")
      end

      it "fails if the top up amount is of negative" do
        expect{card.top_up(-30)}.to raise_error("Please enter valid amount or amount must be higher than 0")
      end

    end
  end

  describe "when travel fare is taken off the card" do
    before { card.top_up(30) }

    context "transport travelling by bus" do
      before { card.tap_in({transport: :bus}) }

      it "should successfully charge the card(using bus fare)" do
        expect(card.balance).to eq(28.20)
      end
    end

    context "transport travelling by tube" do
      before { card.tap_in({transport: :tube, stop: "Holborn"}) }

      it "should successfully temp charge the card(using tube fare)" do
        expect(card.balance).to eq(26.80)
        card.tap_out({transport: :tube, stop: "Earls court"})
        expect(card.balance).to eq(27.50)
      end

      it "should charge maximum amount if user didnt touch out in the end of the journey" do
        expect(card.balance).to eq(26.80)
        card.tap_in({transport: :tube, stop: "Earls court"})
        expect(card.balance).to eq(23.60)
        card.tap_out({transport: :tube, stop: "Holborn"})
        expect(card.balance).to eq(24.30)
      end

      it "should charge maximum amount if user didnt touch out and then took the bus" do
        expect(card.balance).to eq(26.80)
        card.tap_in({transport: :bus})
        expect(card.balance).to eq(25)
        card.tap_in({transport: :tube, stop: "Holborn"})
        expect(card.balance).to eq(21.80)
        card.tap_out({transport: :tube, stop: "Earls court"})
        expect(card.balance).to eq(22.50)
      end
    end

    it "should charge maximum amount if user didnt touch in and only touched out" do
      card.tap_out({transport: :tube, stop: "Holborn"})
      expect(card.balance).to eq(26.80)
      card.tap_in({transport: :tube, stop: "Holborn"})
      expect(card.balance).to eq(23.60)
      card.tap_out({transport: :tube, stop: "Earls court"})
      expect(card.balance).to eq(24.30)
    end
  end

  describe "when card balance is not at least the minimum fare" do
    context "tube" do
      before { card.top_up(1.90) }

      it "should refuse entry" do
        expect{card.tap_in({transport: :tube, stop: "Holborn"})}.to raise_error("You don't have enough amount in yuor card. Please top up your card")
      end

      it "should not let the user touch out if he didnt touch in" do
        expect{card.tap_out({transport: :tube, stop: "Holborn"})}.to raise_error("You don't have enough amount in yuor card. Please top up your card")
      end
    end

    context "bus" do
      before { card.top_up(1.50) }

      it "should refuse entry" do
        expect{card.tap_in({transport: :bus})}.to raise_error("You don't have enough amount in yuor card. Please top up your card")
      end
    end
  end
end
