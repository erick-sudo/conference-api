require 'open-uri'

class AttachRemoteImageJob < ApplicationJob

  queue_as :default

  after_enqueue do |job|
    self.class.jobs_completed ||= 0
    self.class.jobs_completed += 1
  end

  def perform(model_instance, remote_url, file_name)
    io = URI.open(remote_url)
    puts "Attched -------#{model_instance.id}------> #{model_instance.poster.attach(io: io, filename: "#{file_name}")}"
  end

  class << self
    attr_accessor :jobs_completed
  end
end
