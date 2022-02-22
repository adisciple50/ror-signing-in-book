require "test_helper"

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #

  def test_that_blank_entries_fail
    entry = Entry.new
    assert_not entry.save, "entry was saved!"
  end
  def test_assert_just_phone_number_fails
    entry = Entry.new({mobile_phone:"07432123456"})
    assert_not entry.save, "entry was saved!"
  end
  def test_assert_just_phone_number_and_sign_out_fails
    entry = Entry.new({mobile_phone:"07432123456",time_out:Time.now})
    assert_not entry.save, "entry was saved!"
    end
  def test_assert_just_sign_in_and_sign_out_fails
    entry = Entry.new({time_in:Time.now,time_out:Time.now})
    assert_not entry.save, "entry was saved!"
  end
  def test_that_filled_name_and_time_in_passes
    # warning! this test is not tdd compliant because when no model validation is specified, the test passes.
    entry = Entry.new({name:'jason',time_in:Time.now})
    assert entry.save,"entry was not saved!"
  end
end
