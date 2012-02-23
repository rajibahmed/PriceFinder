require File.expand_path("../../test_helper.rb", __FILE__)

class TestRouter < Test::Unit::TestCase

  def setup
    @router = Ala::Router.instance
  end

  def test_country_codes
    loaded_country_code = "44"
    not_loaded_country_code = "02"

    assert @router.country_codes.include?(loaded_country_code)
    assert_equal false, @router.country_codes.include?(not_loaded_country_code)
  end


  def test_add_operator_and_price
    @router.add("88",:c, "1.0")
    assert @router.list.keys.include?("88")
    assert @router.country_codes.include? "88"
    assert @router.operators.include? :c
    assert_equal "1.0", @router.list["88"][:c]
    assert_equal false, @router.list.keys.include?("89")
  end


  def test_reading_values
    @router.read([["89", "1.2"]],:d)
    assert @router.list.keys.include?("89")
    assert @router.country_codes.include? "89"
    assert @router.operators.include? :d
  end


  def test_country_prefix_extraction
    assert_equal ["46"],@router.country_prefix_for("46000000444")
    assert_equal [], @router.country_prefix_for("6000000444")
  end


  def test_finding_cheapest_carrier_and_price
    assert_equal [:A, "0.17"], @router.find_cheapest("46000000444")
    assert_equal :A, @router.carrier

    assert_equal [nil, nil], @router.find_cheapest("6000000444")
    assert_equal nil, @router.price

    assert_equal [:B, "1.0"], @router.find_cheapest(" 4673 20000444")
    assert_not_equal "2.0", @router.price
    assert_not_equal ":A", @router.carrier
  end

end
