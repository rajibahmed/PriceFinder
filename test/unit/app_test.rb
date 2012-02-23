require File.expand_path("../../test_helper.rb", __FILE__)

class TestApp < Test::Unit::TestCase

  def setup
    @app = Ala::App.new(Ala::Router.instance)
  end

  def test_finding_cheapest_carrier_and_price
    assert_equal [:A, "0.17"], @app.find_cheapest("+ 46000000444")
    assert_equal :A, @app.carrier

    assert_equal [nil, nil], @app.find_cheapest("--sfasd 6000000444")
    assert_equal "N/A",       @app.price
    assert_equal "N/A",       @app.carrier

    assert_equal [:B, "1.0"], @app.find_cheapest("+(467) 32 0000444")
    assert_not_equal "2.0",   @app.price
    assert_not_equal ":A",    @app.carrier
  end

  def test_for_phone_number
    @app.phone = "+ 46 232111"
    assert_equal "+ 46 232111", @app.phone
    assert_respond_to @app, :phone
    assert_respond_to @app, :phone=
  end

  def test_router_is_set
    assert_equal @app.route, Ala::Router.instance
    assert_respond_to @app, :route
  end

end
