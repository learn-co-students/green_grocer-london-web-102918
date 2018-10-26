def consolidate_cart(cart)
  cart.each_with_object({}) do |grocery, value|
    grocery.each do |info, attribute|
      if value[info]
        attribute[:count] += 1
      else
        attribute[:count] = 1
        value[info] = attribute
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
      end
    end
    cart
end

def apply_clearance(cart)
  cart.each do |grocery, info|
    if info[:clearance]
      new_price = info[:price] * 0.8
      info[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  checkout_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(checkout_cart, coupons)
  clearance_cart = apply_clearance(couponed_cart)
  count = 0
  clearance_cart.each do |grocery, info|
    count += info[:price] * info[:count]
  end
  count = count * 0.9 if count > 100
  count
end
