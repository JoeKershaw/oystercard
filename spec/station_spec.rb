require 'station'

describe Station do
  subject {described_class.new(name: "KC", zone: 2)}
  it 'station has a name variable' do
    expect(subject.name).to eq "KC"
  end
  it 'station has a zone variable' do
    expect(subject.zone).to eq 2
  end
end
