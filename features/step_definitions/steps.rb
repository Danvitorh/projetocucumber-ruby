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
  #tornar váriavel
  product_title = find('.item-details h1')
  #expect pega a váriavel e valida o texto, depois faz a comparação com a tag inicial
  expect(product_title.text).to eql @product_name

  sub_price = find('.subtotal .sub-price ')
  expect(sub_price.text).to eql @product_price
  delivery = find('.delivery .delivery-price')
  expect(delivery.text).to eql @delivery_price
end

Então('o valor total da compra deve ser de {string}') do |total_price|
  #deixou o elemento como váriavel
  price = find('.total-price')
  expect(price.text).to eql total_price
end

Então('devo ver um popup informando que o produto está indisponível') do
  popup = find('.swal2-html-container')
  expect(popup.text).to eql 'Produto indisponível'
end

 