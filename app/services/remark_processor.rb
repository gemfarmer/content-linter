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

  def consolidate(errors)
    errors.group_by { |i| i[:line] }.
      map do |m|
      { line: m[0], message: m[1].
        map { |obj| obj[:message] }.join('/n') }
    end
  end

  def result
    processed_node = process
    consolidate(format(processed_node))
  end
end
