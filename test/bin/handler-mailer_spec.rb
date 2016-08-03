# NOTE: always require `json` while testing
require 'json'
require_relative '../spec_helper.rb'
require_relative '../../bin/handler-mailer.rb'

# rubocop:disable Style/ClassVars
class Mailer
  at_exit do
    @@autorun = false
  end

  def settings
    @settings ||= JSON.parse(fixture('mailer_settings.json').read)
  end
end

describe 'Handlers' do
  before do
    @handler = Mailer.new
  end

  # We hashtag @method_name that needed to be test.
  describe '#short_name' do
    it 'should return short name' do
      # NOTE: no_override mean the event does not override anything !?
      io_obj = fixture('no_override.json')
      @handler.read_event(io_obj)
      # Evaluate the @method_name here
      short_name = @handler.short_name
      expect(short_name).to eq('host01/frontend_http_check')
    end
  end

  describe '#prefix_subject' do
    it 'should return custom' do
      # method config is coming from Mixlib for parsing command line arguments
      # Passing an array of arguments ["-s", "custom_prefix_subject"]
      prefix_subject =
        Mailer.new('-s custom_prefix_subject'.split).prefix_subject
      expect(prefix_subject).to eq('custom_prefix_subject ')
    end

    it 'should return subject_prefix in settings file' do
      prefix_subject = @handler.prefix_subject
      expect(prefix_subject).to eq('this is the test ')
    end
  end

  describe '#parse_content_type' do
    it 'should return short name' do
      # NOTE: no_override mean the event does not override anything !?
      io_obj = fixture('no_override.json')
      @handler.read_event(io_obj)
      # Evaluate the @method_name here
      short_name = @handler.short_name
      expect(short_name).to eq('host01/frontend_http_check')
    end
  end
end
