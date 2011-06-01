require 'spec_helper'

describe Less::Parser do
  describe "simple usage" do
    it "parse less into a tree" do
      root = subject.parse(".class {width: 1+1}")
      root.to_css.gsub(/\n/,'').should eql ".class {  width: 2;}"
    end
  end
end
