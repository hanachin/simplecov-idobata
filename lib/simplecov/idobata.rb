require "simplecov/idobata/version"
require "simplecov/idobata/badge"
require "idobata_hook"
require "idobadge"

# SimpleCov formatter for idobata.io
class SimpleCov::Formatter::IdobataFormatter
  class << self
    # @!attribute hook_url
    #   @return [String] your idobata.io generic webhook url
    # @!attribute goal
    #   @return [Fixnum] the coverage goal, when your coverage reach to goal,
    #     the badge looks like green, default is 90.
    # @!attribute warning
    #   @return [Fixnum] the coverage warning line, default is 80,
    #     if your coverage greather than `warning`, the badge looks like orange,
    #     if your coverage is less than `warning`, the badge looks like red.
    attr_accessor :hook_url, :goal, :warning
  end

  # SimpleCov formatter for idobata.io
  # @example Use IdobataFormatter with other formatter
  #   require 'simplecov/idobata'
  #
  #   SimpleCov.formatters = [
  #    SimpleCov::Formatter::HTMLFormatter,
  #    SimpleCov::Formatter::IdobataFormatter,
  #   ]
  #
  # @example Set idobata.io generic webhook url by .hook_url
  #   SimpleCov::Formatter::IdobataFormatter.hook_url = "YOUR_IDOBATA_HOOK_URL"
  # @example Set idobata.io generic webhook url by environment variable
  #   % export SIMPLECOV_IDOBATA_HOOK_URL=YOUR_IDOBATA_HOOK_URL
  #   % bundle exec rspec
  def initialize
    @hook_url = self.class.hook_url || ENV['SIMPLECOV_IDOBATA_HOOK_URL']
  end

  # format coverage result, then post result to idobata.io
  # @param result [SimpleCov::Result]
  def format(result)
    client.send(Badge.new(result).to_s, format: :html)
  end

  private

  def client
    IdobataHook::Client.new(@hook_url)
  end
end
