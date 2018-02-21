require_relative 'oyster_card/card'
require_relative 'oyster_card/fare'
require_relative 'oyster_card/journey'
require_relative 'oyster_card/zone'

# Add money £30 to card
card = Card.new
card.top_up(30)
puts "Current balance of card ******** #{card.balance}***************"

# Taking Transport Tube: from Holborn to Earl’s Court
card.tap_in({transport: :tube, stop: "Holborn"})
puts "****************** Travelled by TUBE *******************"
puts "Tapped in at Holborn(zone 1) \n Now Current balance of card ********* #{card.balance}************"
card.tap_out({transport: :tube, stop: "Earl’s Court"})
puts "Tapped out at Earl’s Court(zone 1/2) \n Now Current balance of card ********** #{card.balance} \n *********"

# Taking BUS: 328 from Earl’s Court to Chelsea(where there is no zone or station for Chelsea)
card.tap_in({transport: :bus, stop: "Earl’s Court"})
puts "*********Travelled by BUS**************"
puts "Tapped in at Earl’s Court (zone 1/2) \n Now Current balance of card ************* #{card.balance} \n **************"

# Taking Transport Tube: from Earl’s court to Hammersmith
card.tap_in({transport: :tube, stop: "Earl’s Court"})
puts "****************** Travelled by TUBE *******************"
puts "Tapped in at Earl’s Court (zone 1/2) \n Now Current balance of card ********* #{card.balance}************"
card.tap_out({transport: :tube, stop: "Hammersmith"})
puts "Tapped out at Hammersmith (zone 2) \n Now Current balance of card ************* #{card.balance} \n **************"

#Final Balance
puts "Final balance in card ********** #{card.balance}*************"