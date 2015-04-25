# encoding: utf-8

describe Hexx::API do

  let(:test) { Module.new.extend described_class }
  let(:foo)  { double :foo, new: :foo, bar: :baz }

  before { described_class::Foo = foo               }
  after  { described_class.send :remove_const, :Foo }

  describe ".[]" do

    subject { test[:foo] }

    it "returns nil by default" do
      expect(subject).to be_nil
    end

  end # describe .[]

  describe ".api_method" do

    context "without third argument" do

      subject { test.api_method :foo, foo }

      it "defines [:foo]" do
        expect { subject }.to change { test[:foo] }.from(nil).to(foo)
      end

      it "defines ['foo']" do
        expect { subject }.to change { test["foo"] }.from(nil).to(foo)
      end

      it "defines #foo as [:foo].new" do
        subject
        expect(test.foo).to eq :foo
      end

    end # context

    context "with third argument" do

      subject { test.api_method "foo", foo, :bar }

      it "defines [:foo]" do
        expect { subject }.to change { test[:foo] }.from(nil).to(foo)
      end

      it "defines #foo as custom method" do
        subject
        expect(test.foo).to eq :baz
      end

    end # context

  end # describe .api_method

end # describe Hexx::API