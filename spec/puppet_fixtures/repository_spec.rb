# frozen_string_literal: true

require 'spec_helper'

describe PuppetFixtures::Repository do
  describe PuppetFixtures::Repository::Git do
    let(:repository) { described_class.new(remote: 'https://example.com/repo.git', target: 'target', branch: 'main', ref: nil) }

    describe '#clone' do
      it 'passes flags as separate arguments' do
        allow(repository).to receive(:run_command)
        repository.clone(['--single-branch', '--no-tags'])
        expect(repository).to have_received(:run_command)
          .with(%w[git clone --depth 1 -b main --single-branch --no-tags https://example.com/repo.git target])
      end
    end
  end

  describe PuppetFixtures::Repository::Mercurial do
    let(:repository) { described_class.new(remote: 'https://example.com/repo', target: 'target', branch: 'default', ref: nil) }

    describe '#clone' do
      it 'passes flags as separate arguments' do
        allow(repository).to receive(:run_command)
        repository.clone(['--noupdate', '--insecure'])
        expect(repository).to have_received(:run_command)
          .with(%w[hg clone -b default --noupdate --insecure https://example.com/repo target])
      end
    end
  end
end
