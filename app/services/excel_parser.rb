class ExcelParser < ApplicationForm
  def run
    parse_excel
  end

  private

  def parse_excel
    case params[:name]
    when 'local_seed'
      LocalSeedExcelParser.new(current_user: current_user, params: params, seed_type: nil).run
    when 'foreign_seed'
      ForeignSeedExcelParser.new(current_user: current_user, params: params).run
    when 'cryo_seed'
      LocalSeedExcelParser.new(current_user: current_user, params: params, seed_type: 'Cryo').run
    end
  end
end