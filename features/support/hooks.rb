
#importação relativa, importação da cama page objects
#precisa do do
require_relative './pages/home.rb'
Before do
    @home = HomePage.new
end