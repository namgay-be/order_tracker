class TestDetailsUpdater < ApplicationForm
  attr_accessor :test_detail

  def update(id)
    @test_detail = TestDetail.find(id)
    @test_detail.update(params)
  end
end
