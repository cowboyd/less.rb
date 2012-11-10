require 'spec_helper'

describe Less::Loader do
  describe 'evaluating console.log()' do
    it 'should write message to $stdout' do
      msg = 'log much?'
      $stdout.should_receive(:puts).with(msg)
      subject.environment.runtime.eval("console.log('#{ msg }');")
    end
  end

  describe 'evaluating process.exit()' do
    it 'should not raise an error' do
      lambda {
        subject.environment.runtime.eval("process.exit();")
      }.should_not raise_error
    end
  end
end
