def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  result = nil
  i      = 0

  while i < collection.length
    if collection[i][:item] == name
      result = collection[i]
    end
    i += 1
  end
  result
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  uniq_cart = []

  cart.each do |item|
    item_name  = item[:item]
    item_check = find_item_by_name_in_collection(item_name, uniq_cart)

    if item != item_check
      item[:count] = 1
      uniq_cart << item
    else
      item[:count] += 1
    end
  end
  uniq_cart
end

def create_coupon_hash(coupon, discounted_item)
  result = {}

  result[:item]      = coupon[:item] + ' W/COUPON'
  result[:price]     = coupon[:cost] / coupon[:num]
  result[:clearance] = discounted_item[:clearance]
  result[:count]     = coupon[:num]

  result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |single_coupon|
    item_to_be_discounted = find_item_by_name_in_collection(single_coupon[:item], cart)

    if item_to_be_discounted && item_to_be_discounted[:count] >= single_coupon[:num]
      if item_to_be_discounted
        coupon = create_coupon_hash(single_coupon, item_to_be_discounted)
        cart << coupon

        until item_to_be_discounted[:count] < single_coupon[:num]
          item_to_be_discounted[:count] -= single_coupon[:num]
        end

      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  cart.each do |item|
    if item[:clearance] == true
      discount      = 0.2 * item[:price]
      item[:price] -= discount
    end
  end
  cart
end

def find_cart_total(cart)
  total = 0
  cart.each do |item|
    item[:price] *= item[:count]
    total        += item[:price]
  end
  total
end

def apply_10_percent(total)
  discount = 0.1 * total
  total   -= discount
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  cart  = consolidate_cart(cart)
  cart  = apply_coupons(cart, coupons)
  cart  = apply_clearance(cart)
  total = find_cart_total(cart)

  if total > 100
    total = apply_10_percent(total)
  else
    total
  end
end
