class RemarkProcessor
  def initialize(file)
    @file = file
  end

  def process
    JSON.parse(`node retext-18f.js "#{@file}"`)
  end

  def format(process)
    process.map do |p|
      formatted_response = {}
      formatted_response[:line] = p['line']
      formatted_response[:message] = p['message']
      formatted_response
    end
  end

  def result
    processed_node = process
    format(processed_node)
  end
end
