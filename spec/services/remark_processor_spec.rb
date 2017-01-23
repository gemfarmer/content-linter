require 'rails_helper'

describe RemarkProcessor do
  it 'it can process a file and return an object' do
    remark_processor = RemarkProcessor.new('### Heading')

    retex_response = RETEXT_RESPONSE

    expect(remark_processor.process).to eq retex_response
  end

  it 'it formates the processed response' do
    retex_response = RETEXT_RESPONSE

    remark_processor = RemarkProcessor.new('### Heading')

    formatted_response = [{
      line: 1,
      message: 'First heading level should be `1`'
    }]

    expect(remark_processor.format(retex_response)).to eq formatted_response
  end

  it 'it returns a list of errors' do
    retex_response = RETEXT_RESPONSE

    remark_processor = RemarkProcessor.new('### Heading')

    allow(remark_processor).to receive(:process).
      and_return(retex_response)

    formatted_response = [{
      line: 1,
      message: 'First heading level should be `1`'
    }]

    expect(remark_processor.result).to eq formatted_response
  end
end
