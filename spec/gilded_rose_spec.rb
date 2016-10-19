require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  vest1 = Item.new(name="+5 Dexterity Vest", sell_in=2, quality=10)
  vest2 = Item.new(name="+5 Dexterity Vest", sell_in=6, quality=10)
  cheese1 = Item.new(name="Aged Brie", sell_in=2, quality=2)
  cheese2 = Item.new(name="Aged Brie", sell_in=4, quality=12)
  elixir1 = Item.new(name="Elixir of the Mongoose", sell_in=5, quality=2)
  conjured1 = Item.new(name="Conjured Mana Cake", sell_in=2, quality=2)
  conjured2 = Item.new(name="Conjured Mana Cake", sell_in=2, quality=10)
  ticket1 = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=6, quality=5)
  ticket2 = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=3, quality=10)
  ticket3 = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=1, quality=20)
  vest = []
  before(:each) do

  end
  # let(:conjured_item1) { double(Item.new("Conjured Mana Cake", sell_in: 5, quality: 6)) }
  # let(:conjured_item2) { double("Item", name: "Conjured Mana Cake", sell_in: 3, quality: 10)) }
  # let(:legendary_item1) { double("Item", name: "Sulfuras, Hand of Ragnaros", sell_in: 2, quality: 80)) }
  # let(:legendary_item2) { double("Item", name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80)) }
  #
  # let(:cheese2) { double("Item", name: "Aged Brie", sell_in: 4, quality: 10) }
  # let(:ticket1) { double("Item", name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 6, quality: 10) }
  # let(:ticket2) { double("Item", name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 3, quality: 15) }
  # let(:ticket3) { double("Item", name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 20) }

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it 'degrades Quality by 1 each day before sell in date' do
      gu = GildedRose.new([elixir1])
      1.times {gu.update_quality}
      expect(elixir1.quality).to eq 1
    end

    it 'degrades Quality twice as much once the sell by date has passed' do
       vest << vest1
       vest << vest2
       gr = GildedRose.new(vest)
       3.times {gr.update_quality}
       expect(vest1.quality).not_to eq(vest2.quality)
    end

    it 'The Quality of an item is never negative' do
      tr = GildedRose.new([conjured1])
      3.times {tr.update_quality}
      expect(conjured1.quality).to eq 0
    end

    it '“Aged Brie” actually increases in Quality the older it gets' do
      ch = GildedRose.new([cheese1])
      2.times {ch.update_quality}
      expect(cheese1.quality).not_to eq 0
    end

    it 'Quality of "Aged Brie" increases by 1 each day' do
      ab = GildedRose.new([cheese2])
      2.times {ab.update_quality}
      expect(cheese2.quality).not_to eq 16
    end

  end

  # describe "#check_cheese" do
  #   it 'checks if the item is a cheese' do
  #     expect(gilded_rose.check_cheese).to eq true
  #   end
  # end
end
