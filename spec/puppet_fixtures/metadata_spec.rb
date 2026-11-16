# frozen_string_literal: true

require 'spec_helper'
require 'tmpdir'

describe PuppetFixtures::Metadata do
  subject(:metadata) { described_class.new(path) }

  let(:dir) { Dir.mktmpdir }
  let(:path) { File.join(dir, 'metadata.json') }

  after { FileUtils.rm_rf(dir) }

  context 'with a name and version' do
    before { File.write(path, JSON.generate('name' => 'example-mymodule', 'version' => '1.0.0')) }

    it { expect(metadata.name).to eq('example-mymodule') }
    it { expect(metadata.version).to eq('1.0.0') }
  end

  context 'without a name and version' do
    before { File.write(path, JSON.generate({})) }

    it { expect { metadata.name }.to raise_error(ArgumentError, 'No module name found') }
    it { expect { metadata.version }.to raise_error(ArgumentError, 'No module version found') }
  end
end
