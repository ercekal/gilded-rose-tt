require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  vest1 = Item.new(name="+5 Dexterity Vest", sell_in=0, quality=10)
  vest2 = Item.new(name="+5 Dexterity Vest", sell_in=6, quality=10)
  cheese1 = Item.new(name="Aged Brie", sell_in=2, quality=2)
  cheese2 = Item.new(name="Aged Brie", sell_in=4, quality=12)
  cheese3 = Item.new(name="Aged Brie", sell_in=4, quality=48)
  sulfuras1 = Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=2, quality=80)
  elixir1 = Item.new(name="Elixir of the Mongoose", sell_in=5, quality=2)
  elixir2 = Item.new(name="Elixir of the Mongoose", sell_in=3, quality=2)
  conjured1 = Item.new(name="Conjured Mana Cake", sell_in=2, quality=2)
  conjured2 = Item.new(name="Conjured Mana Cake", sell_in=2, quality=10)
  ticket1 = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=9, quality=5)
  ticket2 = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=3, quality=10)
  ticket3 = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=1, quality=20)

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'quality' do
      it 'degrades Quality by 1 each day before sell in date' do
        gu = GildedRose.new([elixir1])
        expect{gu.update_quality}.to change{elixir1.quality}.by -1
      end

      it 'degrades Quality twice as much once the sell by date has passed' do
         gr = GildedRose.new([vest1])
         1.times {gr.update_quality}
         expect{gr.update_quality}.to change{vest1.quality}.by -2
      end

      it 'The Quality of an item is never negative' do
        tr = GildedRose.new([elixir2])
        3.times {tr.update_quality}
        expect(elixir2.quality).to eq 0
      end

      it 'The Quality of an item is never more than 50' do
        bc = GildedRose.new([cheese3])
        expect{3.times {bc.update_quality}}.to change{cheese3.quality}.by 2
      end
    end

    it '“Aged Brie” actually increases by 1 in Quality the older it gets' do
      ch = GildedRose.new([cheese1])
      expect{ch.update_quality}.to change{cheese1.quality}.by 1
    end

    it '“Sulfuras”, being a legendary item, never has to be sold or decreases in Quality' do
      su = GildedRose.new([sulfuras1])
      expect{3.times {su.update_quality}}.to change{sulfuras1.quality}.by 0
    end

    context 'Backstage passes' do

      it 'increases quality by 2 if there are 10 days or less for sell in' do
        ba = GildedRose.new([ticket1])
        expect{ba.update_quality}.to change{ticket1.quality}.by 2
      end

      it 'increases quality by 3 if there are 5 days or less for sell in' do
        bb = GildedRose.new([ticket2])
        expect{bb.update_quality}.to change{ticket2.quality}.by 3
      end

      it 'if the sell in date passes, the quality is 0' do
        bc = GildedRose.new([ticket3])
        2.times{bc.update_quality}
        expect(ticket3.quality).to eq 0
      end
    end

    context 'Conjured Items' do

      it '“Conjured” items degrade in Quality twice as fast as normal items' do
        co = GildedRose.new([conjured2])
        expect{co.update_quality}.to change{conjured2.quality}.by -2
      end
    end
  end
end
