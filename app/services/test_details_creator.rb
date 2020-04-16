class TestDetailsCreator < ApplicationForm
  attr_accessor :test_detail

  def create
    @test_detail = TestDetail.new(params)
    @test_detail.save
  end
end