# frozen_string_literal: true

RSpec.describe Orchestration::InstallGenerator do
  subject(:install_generator) { described_class.new }

  it { is_expected.to be_a described_class }

  let(:dummy_path) { Orchestration.root.join('spec', 'dummy') }
  let(:orchestration_path) { dummy_path.join('orchestration') }

  it 'creates Makefile' do
    path = dummy_path.join('Makefile')
    FileUtils.rm_f(path)
    install_generator.application_makefile
    expect(File).to exist(path)
  end

  it 'does not overwrite Makefile' do
    path = dummy_path.join('Makefile')
    File.write(path, 'some make commands')
    install_generator.application_makefile
    expect(File.read(path)).to include 'some make commands'
  end

  it 'creates .env' do
    path = dummy_path.join('.env')
    FileUtils.rm_f(path)
    install_generator.env
    expect(File).to exist(path)
  end

  it 'does not overwrite .env' do
    path = dummy_path.join('.env')
    File.write(path, 'some env settings')
    install_generator.env
    expect(File.read(path)).to eql 'some env settings'
  end
end
