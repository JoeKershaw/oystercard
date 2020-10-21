class Oystercard
attr_reader :balance, :in_transit
CARD_LIMIT = 90
MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @in_transit = false
  end
  def top_up(amount)
    raise("#{CARD_LIMIT} limit reached!") if @balance + amount > CARD_LIMIT
    @balance += amount
  end
  def deduct(withdraw)
    @balance -= withdraw
  end
  def touch_in
    raise("Insufficient funds, minimum £1") if @balance < MINIMUM_FARE
    @in_transit = true
  end
  def in_journey?
    @in_transit
  end
  def touch_out
    @in_transit = false
  end
end
