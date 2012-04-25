require 'spec_helper'

describe Less::Parser do

  cwd = Pathname(__FILE__).dirname
  
  it "instantiates" do
    expect { Less::Parser.new }.should_not raise_error
  end
  
  describe "simple usage" do
    it "parse less into a tree" do
      root = subject.parse(".class {width: 1+1}")
      root.to_css.gsub(/\n/,'').should eql ".class {  width: 2;}"
    end

    it "accepts options when assembling the parse tree" do
      subject.parse(".class {width: 1+1}").to_css(:compress => true).strip.should eql ".class{width:2;}"
    end
  end

  it "throws a ParseError if the lesscss is bogus" do
    expect { subject.parse('{^)') }.should raise_error(Less::ParseError, /missing closing `\}`/)
  end

  it "passes exceptions from the less compiler" do
    expect { subject.parse('body { color: @a; }').to_css }.should raise_error(Less::ParseError, /variable @a is undefined/)
  end

  describe "when configured with multiple load paths" do
    subject { Less::Parser.new :paths => [ cwd.join('one'), cwd.join('two'), cwd.join('faulty') ] } 

    it "will load files from both paths" do
      subject.parse('@import "one.less";').to_css.gsub(/\n/,'').strip.should eql ".one {  width: 1;}"
      subject.parse('@import "two.less";').to_css.gsub(/\n/,'').strip.should eql ".two {  width: 1;}"
    end

    it "passes exceptions from less imported less files" do
      expect { subject.parse('@import "faulty.less";').to_css }.should raise_error(Less::ParseError, /variable @a is undefined/)
    end

    it "reports type, line, column and filename of (parse) error" do
      begin
        subject.parse('@import "faulty.less";').to_css
      rescue Less::ParseError => e
        e.type.should == 'Name'
        e.filename.should == cwd.join('faulty/faulty.less').to_s
        e.line.should == 1
        e.column.should == 16
      else
        fail "parse error not raised"
      end
    end
    
  end

  describe "when load paths are specified in as default options" do
    before do
      Less.paths << cwd.join('one')
      Less.paths << cwd.join('two')
      @parser = Less::Parser.new
    end
    after do
      Less.paths.clear
    end

    it "will load files from default load paths" do
      @parser.parse('@import "one.less";').to_css.gsub(/\n/,'').strip.should eql ".one {  width: 1;}"
      @parser.parse('@import "two.less";').to_css.gsub(/\n/,'').strip.should eql ".two {  width: 1;}"
    end
  end

end
