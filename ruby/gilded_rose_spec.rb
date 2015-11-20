require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe "#update_quality" do

    context "default item" do
      def build_items
        [Item.new("foo", 10, 20)]
      end
      
      it "does not change the name" do
        items = build_items()
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq("foo")
      end
      
      it "decreases sellIn value" do
        items = build_items()
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(9)
      end

      it "decreases quality value" do
        items = build_items()
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(19)
      end

      it "decreases quality twice when sellIn passed" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        9.downto(0) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(10)
        # now when sellIn has passed, expecting that quality decreases by 2
        gilded_rose.update_quality()
        expect(items[0].quality).to eq(8)
      end

      it "never got negative quality" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        0.upto(29) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(0)
      end
    end
    
    context "Aged Brie" do
      def build_items
        [Item.new("Aged Brie", 10, 20)]
      end
      
      it "increases quality" do
        items = build_items()
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(21)
      end

      it "increases quality twice when sellIn passed" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        9.downto(0) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(30)
        # now when sellIn has passed, expecting that quality increases by 2
        gilded_rose.update_quality()
        expect(items[0].quality).to eq(32)
      end
    end
    
    context "Backstage passes" do
      def build_items
        [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 20)]
      end
      
      it "increases quality" do
        items = build_items()
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(21)
      end

      it "quality increases by 2 when there are 10 days or less left" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        1.downto(0) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(22)
        # now when 10 days left, expecting that quality increases by 2
        gilded_rose.update_quality()
        expect(items[0].quality).to eq(24)
      end

      it "quality increases by 3 when there are 5 days or less left" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        6.downto(0) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(32)
        # now when 5 days left, expecting that quality increases by 3
        gilded_rose.update_quality()
        expect(items[0].quality).to eq(35)
      end

      it "drops quality to 0 after concert" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        12.downto(0) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(0)
      end
    end

    context "Conjured" do
      def build_items
        [Item.new("Conjured Mana Cake", 10, 24)]
      end
       
      it "descreases twice fast" do
        items = build_items()
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality()
        expect(items[0].quality).to eq(22)
        8.downto(0) { gilded_rose.update_quality() }
        expect(items[0].quality).to eq(4)
        gilded_rose.update_quality()
        expect(items[0].quality).to eq(0)
      end
    end

  end

end
