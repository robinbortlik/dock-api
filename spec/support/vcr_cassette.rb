# frozen_string_literal: true

module VcrCassette
  def self.remove
    VCR.current_cassette.eject
    FileUtils.rm(VCR.current_cassette.file)
  end
end
