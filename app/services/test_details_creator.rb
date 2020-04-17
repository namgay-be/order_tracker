class TestDetailsCreator < ApplicationForm
  attr_accessor :test_detail

  def create
    @test_detail = TestDetail.new(params)
    @test_detail.save.tap do |result|
      result && seed.may_test? && seed.test!
    end
  end

  private

  def seed
    @seed ||= test_detail.seed
  end
end
