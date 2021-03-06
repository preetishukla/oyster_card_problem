class Zone

  ZONES = {
    "holborn" => [1],
    "earls court" => [1, 2],
    "hammersmith" => [2],
    "wimbeldon" => [3]
  }

  ZONE_WORDS = { 1 => "one",
    2 => "two",
    3 => "three"
  }

  attr_reader :origin, :destination

  def initialize(origin, destination)
    @origin = ZONES[origin]
    @destination = ZONES[destination]
  end

  def perform
    zones = collect_travelled_zones
    if zones.include?(1)
      { count_zone: ZONE_WORDS[zones.max], check_zone_one: true }
    else
      { count_zone: ZONE_WORDS[zones.length], check_zone_one: false }
    end
  end

  private

  def collect_travelled_zones
    one_zone_only = origin & destination
    one_zone_only.any? ? one_zone_only : multiple_zones
  end

  def multiple_zones
    if travelling_outbound?
      list_zones_upto(destination.min)
    else
      list_zones_upto(destination.max)
    end
  end

  def travelling_outbound?
    origin.last < destination.first
  end

  def list_zones_upto(dest_zone)
    zones_array = [origin.max, dest_zone]
    (zones_array.min..zones_array.max).collect {|i| i}
  end
end