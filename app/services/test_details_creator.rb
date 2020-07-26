class TestDetailsCreator < ApplicationForm
  attr_accessor :test_detail

  def create
    @test_detail = TestDetail.new(params)
    @test_detail.assign_attributes(creator: current_user)
    @test_detail.transaction do
      test_detail.save && seed.test!
    end
  end

  private

  def seed
    @seed ||= test_detail.seed
  end
end
