
#pascal case primeira letra é maiucula
class HomePage
include Capybara::DSL

    def open
    visit 'https://starbugs.vercel.app/'
    end

    def coffee_list
        return all('.coffee-item')
    end

    def buy(product_name)
    product = find('.coffee-item', text: product_name)
    product.find('.buy-coffee').click
    end

end