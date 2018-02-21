class Card

  attr_reader :balance

  #Initialize the Card with balance 0 and journey
  def initialize
    @balance = 0
    @journey = nil
  end

  #Add or refund_money Money to Card
  def top_up(amount)
    add_money(amount)
  end

  #Used from where we start the journey
  def tap_in(options)
    @journey = Journey.new(transport: options[:transport], start_journey: options[:stop])
    deduct_amount(@journey.basic_fare)
  end

  #where journey end or we reached the station
  def tap_out(options)
    if @journey
      @journey.complete!(end_journey: options[:stop])
      refund_money(@journey.fare_difference)
    else
      @journey = Journey.new(transport: options[:transport], end_journey: options[:stop])
      deduct_amount(@journey.basic_fare)
    end
  end

  private

  #deduct the fare from balance and also check if balance is enough for journey or not
  def deduct_amount(amount)
    raise "You don't have enough amount in yuor card. Please top up your card" if @balance < @journey.basic_fare
    @balance -= amount
  end

  #Add money to card
  def add_money(amount)
    raise 'Please enter valid amount or amount must be higher than 0' unless amount_valid?(amount)
    @balance += amount
  end
  
  #we can use add_money method for refund money also.
  alias :refund_money :add_money

  #used for checking the amount is valid or not
  def amount_valid?(amount)
    (amount.is_a?(Integer) || amount.is_a?(Float)) && amount > 0
  end

end