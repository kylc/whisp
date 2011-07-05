describe Whisp::Interpreter do
  before do
    @interpreter = Whisp::Interpreter::Interpreter.new
  end

  it "should interpret a simple define" do
    @interpreter.interpret("(def some-var 5)")
    @interpreter.root_environment.get(:'some-var').should eq(5)
  end

  it "should interpret an if statement" do
    @interpreter.interpret("(if #t (def is-true #t))")
    @interpreter.root_environment.get(:'is-true').should eq(true)

    @interpreter.interpret("(if #f (def is-false #f))")
    @interpreter.root_environment.has_key?(:'is-false').should eq(false)
  end

  it "should compare equality" do
    @interpreter.interpret("(def equal (eq true true))")
    @interpreter.root_environment.get(:'equal').should eq(true)

    @interpreter.interpret("(def not-equal (eq 4 5))")
    @interpreter.root_environment.get(:'not-equal').should eq(false)
  end

  it "should interpret an or statement" do
    @interpreter.interpret("(def either (or #t #f))")
    @interpreter.root_environment.get(:'either').should eq(true)

    @interpreter.interpret("(def neither (or #f #f))")
    @interpreter.root_environment.get(:'neither').should eq(false)
  end

  it "should interpret simple arithmetic operations" do
    @interpreter.interpret("(def four (+ 2 2))")
    @interpreter.interpret("(def zero (- 2 2))")
    @interpreter.interpret("(def eight (* 4 2))")
    @interpreter.interpret("(def two (/ 4 2))")

    @interpreter.root_environment.get(:four).should eq(4)
    @interpreter.root_environment.get(:zero).should eq(0)
    @interpreter.root_environment.get(:eight).should eq(8)
    @interpreter.root_environment.get(:two).should eq(2)
  end

  it "should bind variables" do
    @interpreter.interpret("(def my-var 5)")
    @interpreter.interpret("(def my-other-var my-var)")

    @interpreter.root_environment.get(:'my-other-var').should eq(5)
  end

  it "should be able to recognize unbound variabled" do
    expect { @interpreter.interpret("(def some-var an-undefined-var)") }.to
        raise_error Whisp::Interpreter::InterpreterError
  end
end
