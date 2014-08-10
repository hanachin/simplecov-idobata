require "simplecov/idobata/version"
require "simplecov/idobata/badge"
require "idobata_hook"
require "idobadge"

class SimpleCov::Formatter::IdobataFormatter
  class << self
    attr_accessor :hook_url, :goal, :warning
  end

  def initialize
    @hook_url = self.class.hook_url || ENV['SIMPLECOV_IDOBATA_HOOK_URL']
  end

  def format(result)
    client.send(Badge.new(result).to_s, format: :html)
  end

  private

  def client
    IdobataHook::Client.new(@hook_url)
  end
end
