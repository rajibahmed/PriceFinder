##Programming Exercise

Finding cheapest operator and its prices. A experimental gem.



~~~
  require 'Ala'
  include Ala

  loader = Loader.new
  Router.instance.read(loader.first_operator, :x)
  Router.instance.read(loader.second_operator, :y)

  app = App.new(Router.instance)
  puts app.find_cheapest("4673291888888888888")
  puts app.carrier
  puts app.price

~~~

##Running Unit Tests

cd into the project folder
~~~
 rake test
~~~

