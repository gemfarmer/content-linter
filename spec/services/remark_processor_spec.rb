require 'rails_helper'

describe RemarkProcessor do
  it 'it can process a file and return an object' do
    remark_processor = RemarkProcessor.new('Hey guys {% something %}')
    expect(remark_processor.process).to match RETEXT_RESPONSE
  end

  it 'it formates the processed response' do
    remark_processor = RemarkProcessor.new('# Hey guys {% something %}')

    formatted_response = [{
      line: 1,
      message: '`guys` may be insensitive, use `people`, `persons`, `folks` instead'
    }]

    expect(remark_processor.format(RETEXT_RESPONSE)).to match formatted_response
  end

  it 'consolidates errors on to one line' do
    remark_processor = RemarkProcessor.new('# Hey guys look at this sentense')

    formatted_response = [{
      line: 1,
      message: '`guys` may be insensitive, use `people`, `persons`, `folks`' \
               ' instead/n`sentense` is misspelt; did you mean `sentence`?'
    }]

    expect(remark_processor.result).to match formatted_response
  end

  it 'suggests more appropriate content (retext-equality)' do
    remark_processor = RemarkProcessor.new('# Hey guys {% something %}')

    formatted_response = [{
      line: 1,
      message: '`guys` may be insensitive, use `people`, `persons`, `folks` instead'
    }]

    expect(remark_processor.result).to match formatted_response
  end

  it 'checks for misspellings (retext-spell)' do
    remark_processor = RemarkProcessor.new("Something in this\n sentense is not spelled correctly.")

    formatted_response = [{
      line: 2,
      message: '`sentense` is misspelt; did you mean `sentence`?'
    }]

    expect(remark_processor.result).to match formatted_response
  end

  it 'checks for better use of quotes (retext-quote)' do
    remark_processor = RemarkProcessor.new("Something' is up,\n isnt it?")

    formatted_response = [{
      line: 2,
      message: "`isnt` is misspelt; did you mean `isn't`, `int`, `inst`?"
    },
                          {
                            line: 1,
                            message: "Expected a smart quote: `’`, not `'`"
                          }]

    expect(remark_processor.result).to match formatted_response
  end

  it 'makes suggestions for better words (retext-simplify)' do
    remark_processor = RemarkProcessor.new('This test is positively easy to utilize!')

    formatted_response = [{
      line: 1,
      message: 'Replace “utilize” with “use”'
    }]

    expect(remark_processor.result).to match formatted_response
  end

  it 'makes suggestions for better words (retext-simplify)' do
    remark_processor = RemarkProcessor.new('This test is positively easy to utilize!')

    formatted_response = [{
      line: 1,
      message: 'Replace “utilize” with “use”'
    }]

    expect(remark_processor.result).to match formatted_response
  end
end
