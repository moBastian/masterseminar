class TestSEL < Test
  # Fuer sinnentnehmendes Lesen SEL

  def draw_items(first)
    itemset = Array.new
    20.times  do    # Don't use len to avoid items start and end items (itemtype > 0 or itemtype <0)
      remaining = content_items - itemset
      itemset = itemset + [remaining.sample]
    end
    return [intro_items.map{|i| i.id}, itemset.map{|i| i.id}, outro_items.map{|i| i.id}]
  end
end
  
