# frozen_string_literal: true

require 'spec_helper'

describe PuppetFixtures::Repository::Mercurial do
  let(:repository) { described_class.new(remote: 'https://example.com/repo', target: 'target', branch: nil, ref: nil) }

  describe '#update' do
    it 'pulls in the target directory' do
      allow(repository).to receive(:run_command)
      repository.update
      expect(repository).to have_received(:run_command).with(%w[hg pull], chdir: 'target')
    end
  end
end
