require File.expand_path("../../test_helper.rb", __FILE__)


class TestPhoneNumber < Test::Unit::TestCase


  def setup
    @ph1=" +4611222222 "
    @ph2="+(46)11222222"
    @ph3=" 46- 11222222"
    @ph4="262334344"
  end


  def test_number_is_clean
    assert_equal "4611222222", Ala::PhoneNumber.clean(@ph1)
    assert_equal "4611222222", Ala::PhoneNumber.clean(@ph2)
    assert_equal "4611222222", Ala::PhoneNumber.clean(@ph3)
    assert_equal "262334344", Ala::PhoneNumber.clean(@ph4)
  end

  def test_number_is_valid
    assert Ala::PhoneNumber.valid?("463211111", Ala::Router.instance)
    assert Ala::PhoneNumber.valid?("467122222",Ala::Router.instance)
    assert_equal false, Ala::PhoneNumber.valid?(@ph4,Ala::Router.instance)
  end
end
