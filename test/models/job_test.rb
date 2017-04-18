require 'test_helper'

class JobTest < ActiveSupport::TestCase
  
  def setup
    @job = Job.new(position: "position", company: "company", contact_name: "Name", contact_phone: "Phone", contact_email: "user@example.com", location: "somewhere", pay: "money", benefits: "some", responsibilities: "many", requirements: "a few", user: users(:user))
  end

  test "should be valid" do
    assert @job.valid?
  end

  test "should have position" do
    @job.position = "  "
    assert_not @job.valid?
  end

  test "should have company" do
    @job.company = " "
    assert_not @job.valid?
  end

  test "should have location" do
    @job.location = " "
    assert_not @job.valid?
  end

  test "should have pay" do
    @job.pay = " "
    assert_not @job.valid?
  end

  test "should have responsibilities" do
    @job.responsibilities = " "
    assert_not @job.valid?
  end

  test "should have requirements" do
    @job.requirements = " "
    assert_not @job.valid?
  end

  test "contact email should save downcase" do
    mixed_case_email = "UsEr@ExAmPlE.CoM"
    @job.contact_email = mixed_case_email
    @job.save
    assert_equal mixed_case_email.downcase, @job.reload.contact_email
  end
end
