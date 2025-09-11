
require 'rspec/expectations'

class CheckoutPage
include Capybara::DSL
include RSpec::Matchers

    def assert_check_product_details(product_name,product_price, delivery_price)      
  product_title = find('.item-details h1')
  #expect pega a váriavel e valida o texto, depois faz a comparação com a tag inicial
  expect(product_title.text).to eql product_name

  sub_price = find('.subtotal .sub-price ')
  expect(sub_price.text).to eql product_price
  delivery = find('.delivery .delivery-price')
  expect(delivery.text).to eql delivery_price
end

def assert_total_price(total_price)
    price = find('.total-price')
    expect(price.text).to eql total_price
end

end