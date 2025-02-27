require 'core/connector_settings'
require 'connectors/crawler/scheduler'

describe Connectors::Crawler::Scheduler do
  subject { described_class.new(poll_interval, heartbeat_interval) }

  let(:poll_interval) { 999 }
  let(:heartbeat_interval) { 999 }

  describe '#connector_settings' do
    context 'when elasticsearch query runs successfully' do
      let(:connector_settings) { [{ :id => '123' }] }
      before(:each) do
        allow(Core::ConnectorSettings).to receive(:fetch_crawler_connectors).and_return(connector_settings)
      end

      it 'fetches crawler connectors' do
        expect(subject.connector_settings).to eq(connector_settings)
      end
    end

    context 'when elasticsearch query fails' do
      before(:each) do
        allow(Core::ConnectorSettings).to receive(:fetch_crawler_connectors).and_raise(StandardError)
      end

      it 'fetches crawler connectors' do
        expect(subject.connector_settings).to be_empty
      end
    end
  end
end
