describe Whisp::Parser do
  before do
    @parser = Whisp::Parser::Parser.new
  end

  it "should parse strings" do
    @parser.parse('"hello"').should eq(["hello"])
  end

  it "should parse numbers" do
    @parser.parse('42').should eq([42])
    @parser.parse('-5').should eq([-5])
    @parser.parse('+5').should eq([5])
  end

  it "should parse atoms" do
    @parser.parse('an_atom123').should eq([:an_atom123])
    @parser.parse('#t').should eq([:'#t'])
    @parser.parse('#f').should eq([:'#f'])
  end

  it "should parse lists" do
    @parser.parse('(test)').should eq([[:test]])
    @parser.parse('(test list atoms 5)').should eq([[:test, :list, :atoms, 5]])
    @parser.parse('(test list atoms 5 (a nested list))').should eq([[:test, :list, :atoms, 5, [:a, :nested, :list]]])
  end

  it "should parse empty lists" do
    @parser.parse("()").should eq([[]])
    @parser.parse("(())").should eq([[[]]])
  end

  it "should fail on imbalanced parenthesis" do
    expect { @parser.parse("(a (list)") }.to raise_error Whisp::Parser::ParserError
    expect { @parser.parse("a (list))") }.to raise_error Whisp::Parser::ParserError
  end
end
