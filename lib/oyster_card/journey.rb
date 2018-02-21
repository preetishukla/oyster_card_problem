class Journey

  attr_reader :start_journey, :end_journey
  
  #Initialize the journey class with the transport used(Bus, Tube) and start journey or end journey
  def initialize(transport:, start_journey: nil, end_journey: nil)
    @transport = transport
    @start_journey = format_words(start_journey)
    @end_journey = format_words(end_journey)
  end

  #used when journey is complete
  def complete!(end_journey:)
    @end_journey = format_words(end_journey)
  end
  
  #Calculate the fare difference
  def fare_difference
    (basic_fare - final_tube_fare).round(2)
  end

  #get the basic fare for bus, tube and for station
  def basic_fare
    fare.public_send(@transport)
  end

  #calculate the final fare
  def final_tube_fare
    fare.calculate_final_fare(@start_journey, @end_journey)
  end

  private
  
  #format the word remove extra carriage return characters
  def format_words(word)
    word.downcase.gsub(/-|’|'/, "") if word
  end

  def fare
    @fare ||= Fare.new
  end
end