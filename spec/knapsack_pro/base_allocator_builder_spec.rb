describe KnapsackPro::BaseAllocatorBuilder do
  let(:adapter_class) { KnapsackPro::Adapters::BaseAdapter }
  let(:allocator_builder) { described_class.new(adapter_class) }

  describe '#allocator' do
    subject { allocator_builder.allocator }

    it do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '#test_dir' do
    subject { allocator_builder.test_dir }

    before do
      expect(KnapsackPro::TestFilePattern).to receive(:call).with(adapter_class).and_return(test_file_pattern)
    end

    context 'when single pattern' do
      let(:test_file_pattern) { 'spec/**{,/*/**}/*_spec.rb' }

      it { should eq 'spec' }
    end

    context 'when multiple patterns' do
      let(:test_file_pattern) { '{spec/controllers/**/*.rb,spec/decorators/**/*.rb}' }

      it { should eq 'spec' }
    end
  end
end
