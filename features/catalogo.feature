#language:pt

#Escrever HU em primeira pessoa, é bom para leitura mais intuitiva
Funcionalidade: Catálogo de cafés
    Como um usuário do site da starbugs
    Eu quero ver o catalogo de cafés na página principal
    Para que eu possa escolher e saber mais sobre os produtos disponíveis

Cenário: Acessar o catalogo de cafés na página principal
    
    Quando acesso a página principal da starbugs
    Então eu devo ver uma lista de cafés disponíveis


Cenário: Iniciar a compra de um café

    Dado que estou na página principal da Starbugs
        E que sejo comprar o seguinte produto:
          |     product          |     price  |     delivery |
          |     Expresso Gelado  |    R$ 9,99 |   R$ 10,00  |
    Quando inicio a compra desse item
    Então devo ver a página de Checkout com o detalhes do produto
        E o valor total da compra deve ser de "R$ 19,99"

@temp
Cenário: Café indisponível
    Dado que estou na página principal da Starbugs
        E que sejo comprar o seguinte produto:
          |     product          |     price  |     delivery |
          |    Expresso Cremoso  |    R$ 9,99 |   R$ 10,00  |
    Quando inicio a compra desse item
    Então devo ver um popup informando que o produto está indisponível

