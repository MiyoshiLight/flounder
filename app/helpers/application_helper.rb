module ApplicationHelper
  def embedded_svg(filename, options = {})
    file_path = Rails.root.join("app/assets/images/icons", "#{filename}.svg")
    return nil unless File.exist?(file_path)

    file = File.read(file_path)
    if options[:class].present?
      file.sub!(/<svg/, "<svg class=\"#{options[:class]}\"")
    end
    raw file
  end
end
