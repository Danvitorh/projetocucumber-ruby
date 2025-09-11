Quando('acesso a página principal da starbugs') do
  @home.open
end

Então('eu devo ver uma lista de cafés disponíveis') do
  #products virou variavel para guardar os dados
  expect(@home.coffee_list.size).to be > 0
end

Dado('que estou na página principal da Starbugs') do
  #chama o metodo criado na hooks
  @home.open
end

Dado('que sejo comprar o seguinte produto:') do |table|
#table hashes vai pegando os itens da tabela e recuperando por posição (linhas)
@product_name = table.hashes[0][:product]
@product_price = table.hashes[0][:price]
@delivery_price = table.hashes[0][:delivery]
end

Quando('inicio a compra desse item') do
  #busca elemento
  @home.buy(@product_name)
end

Então('devo ver a página de Checkout com o detalhes do produto') do
  @checkout.assert_check_product_details(@product_name, @product_price, @delivery_price)
end

Então('o valor total da compra deve ser de {string}') do |total_price|
  @checkout.assert_total_price(total_price)
end

Então('devo ver um popup informando que o produto está indisponível') do
  @popup.have_text('Produto indisponível')
end
