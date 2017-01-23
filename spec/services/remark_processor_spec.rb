require 'rails_helper'

describe RemarkProcessor do
  it 'it can process a file and return an object' do
    remark_processor = RemarkProcessor.new('Hey guys {% something %}')
    expect(remark_processor.process).to eq RETEXT_RESPONSE
  end

  it 'it formates the processed response' do
    remark_processor = RemarkProcessor.new('# Hey guys {% something %}')

    formatted_response = [{
      line: 1,
      message: '`guys` may be insensitive, use `people`, `persons`, `folks` instead'
    }]

    expect(remark_processor.format(RETEXT_RESPONSE)).to eq formatted_response
  end

  it 'it returns a list of errors' do
    remark_processor = RemarkProcessor.new('# Hey guys {% something %}')

    allow(remark_processor).to receive(:process).
      and_return(RETEXT_RESPONSE)

    formatted_response = [{
      line: 1,
      message: '`guys` may be insensitive, use `people`, `persons`, `folks` instead'
    }]

    expect(remark_processor.result).to eq formatted_response
  end
end
