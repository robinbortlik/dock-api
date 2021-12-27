# frozen_string_literal: true

module WaitForJob
  TIMEOUT = 60
  RETRY_COUNT = 10

  def self.wait(id)
    attempts = 1

    begin
      data = Dock::Api::Jobs.find(id)

      return if data['status'] == 404

      if data['status'] != 'finalized'
        log("Job ##{id}: waiting to finish. Current status: #{data['status']}")
        sleep(TIMEOUT)
        raise
      end
    rescue StandardError
      if attempts < RETRY_COUNT
        attempts += 1
        retry
      else
        log("Job ##{id}: Retry attempts exceeded. Moving on.")
      end
    end
  end

  def self.log(message)
    puts "#{Time.now} | #{message}"
  end
end
