module ExportHelper
  def process_file
    attach(File.read(temp_file))
    document.save
    document.file
  end

  def temp_file
    CustomTempfile.open(file_name, nil) do |tmp|
      file.write(tmp.path)
    end
  end

  def attach(excel)
    document.file.attach(
      io: StringIO.new(excel),
      filename: file_name,
      content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  def document
    @excel ||= Excel.new(name: 'some')
  end
end
