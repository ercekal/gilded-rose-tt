class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def update_brie(item)
    item.quality < 50 ? item.quality += 1 : 50
  end

  def check_quality(item)
    item.quality < 0 ? item.quality = 0 : item.quality = item.quality
  end

  def update_normal(item)
    item.sell_in < 0 ? item.quality -= 2 : item.quality -= 1
  end

  def update_conjured(item)
    item.sell_in < 0 ? item.quality -= 4 : item.quality -= 2
  end

  def update_ticket(item)
    case item.sell_in
    when item.sell_in > 10 then item.quality += 1
    when 6...10 then item.quality += 2
    when 0...5 then item.quality += 3
    else item.quality = 0
    end
  end

  def item_checker(item)
    case item.name
    when "Aged Brie"
      update_brie(item)
    when "Conjured Mana Cake"
      update_conjured(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_ticket(item)
    when "Sulfuras, Hand of Ragnaros" then
    else update_normal(item)
    end
  end

  def update_quality()
    @items.each do |item|
      item_checker(item)
      check_quality(item)
      update_sell_in(item)
    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
