# encoding: utf-8

describe Hexx::API do

  let(:tested_module) { Module.new.extend described_class }
  let(:foo)  { double :foo, new: :foo, bar: :baz }

  before { described_class::Foo = foo               }
  after  { described_class.send :remove_const, :Foo }

  describe ".[]" do

    subject { tested_module[:foo] }

    it "returns nil by default" do
      expect(subject).to be_nil
    end

  end # describe .[]

  describe ".api_method" do

    let(:args) { [:qux, :quxx, :quxxx] }

    context "without third argument" do

      subject { tested_module.api_method :foo, foo }

      it "defines [:foo]" do
        expect { subject }.to change { tested_module[:foo] }.from(nil).to(foo)
      end

      it "defines ['foo']" do
        expect { subject }.to change { tested_module["foo"] }.from(nil).to(foo)
      end

      it "returns the module" do
        expect(subject).to eq tested_module
      end

      it "defines #foo as [:foo].new" do
        subject
        expect(foo).to receive(:new).with(*args)
        expect(tested_module.foo(*args)).to eq :foo
      end

    end # context

    context "with third argument" do

      subject { tested_module.api_method "foo", foo, :bar }

      it "defines [:foo]" do
        expect { subject }.to change { tested_module[:foo] }.from(nil).to(foo)
      end

      it "defines #foo as custom method" do
        subject
        expect(foo).to receive(:bar).with(*args)
        expect(tested_module.foo(*args)).to eq :baz
      end

    end # context

  end # describe .api_method

end # describe Hexx::API
