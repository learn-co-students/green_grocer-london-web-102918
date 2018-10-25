require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item_hash|
    item_hash.each do |item, attributes|
      if consolidated_cart.include?(item)
        consolidated_cart[item][:count] += 1 
      else 
        consolidated_cart[item] = attributes
        consolidated_cart[item][:count] = 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    
    # `if cart[item_name]` is in case coupon doesn't apply
    
    if cart[item_name] && cart[item_name][:count] >= coupon[:num]
      cart[item_name][:count] -= coupon[:num]
      if
        cart["#{item_name} W/COUPON"]
        cart["#{item_name} W/COUPON"][:count] +=1
      else  
        
        # working backwards from here - the `else` adds to the hash unless key
        # already exists
        
        cart["#{item_name} W/COUPON"] = {count: 1, price: coupon[:cost], clearance: cart[item_name][:clearance]}
      end
    end
  end
  cart
end

# not sure the above would work if the coupon count and item count were identical

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
