def consolidate_cart(cart)
  # code here
  h ={}
  cart.each do |item|
    item.each do |k,v|
      if h[k].nil?
        h[k] = v
        h[k][:count] = 1
      else
        h[k][:count] += 1
      end
    end
  end
  h
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = cart.clone
  cart.each do |product, info|
    coupons.each do |item|
      if product == item[:item]
        if info[:count] >= item[:num]
          if new_cart[product + " W/COUPON"].nil?
            new_cart[product + " W/COUPON"] = {}
            new_cart[product + " W/COUPON"][:price] = item[:cost]
            new_cart[product + " W/COUPON"][:clearance] = info[:clearance]
            new_cart[product + " W/COUPON"][:count] = 1
          else
            new_cart[product + " W/COUPON"][:count] += 1
          end
          new_cart[product][:count] = info[:count] - item[:num]
        end
      end
    end
  end
  new_cart
end


def apply_clearance(cart)
  # code here
  new_cart = cart.clone
  cart.each do |product, info|
    if info[:clearance] == true
      new_cart[product][:price] = info[:price] - (info[:price] * 0.2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupons_cart)
  cart_total = 0
  clearance_cart.each do |product, info|
      cart_total += info[:price] * info[:count]
  end
  if cart_total > 100
    cart_total = cart_total - (cart_total * 0.1)
  end
  cart_total
end
