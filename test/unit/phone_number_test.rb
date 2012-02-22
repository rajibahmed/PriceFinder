require_relative "../test_helper.rb"

class TestPhoneNumber < Test::Unit::TestCase

  def setup
    @ph1=" +12334344 "
    @ph2="+001 23 34344"
    @ph3="ph +1 2334344 "
    @ph4="12334344"

  end


  def test_number_is_clean
    assert_equal "12334344", Ala::PhoneNumber.clean(@ph1)
    assert_equal "12334344", Ala::PhoneNumber.clean(@ph2)
    assert_equal "12334344", Ala::PhoneNumber.clean(@ph3)
    assert_equal "12334344", Ala::PhoneNumber.clean(@ph4)
  end

  def test_number_is_valid
    assert Ala::PhoneNumber.valid?(@ph1)
    assert Ala::PhoneNumber.valid?(@ph2)
    assert Ala::PhoneNumber.valid?(@ph3)
  end
end
