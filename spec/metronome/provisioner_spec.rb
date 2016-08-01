require "spec_helper"

RSpec.describe Metronome::Provisioner do
  before do
    Aws.config[:stub_responses] = true
  end

  let(:config) do
    Metronome do |config|
      config.queue_name = "example_queue_name"
    end
  end

  let(:sqs_client) do
    Aws::SQS::Client.new(
      stub_responses: {
        create_queue: {queue_url: "https://sqs.example/my-queue"},
        get_queue_attributes:  {attributes: {"QueueArn" => "my-queue-arn"}}
      }
    )
  end

  it "should work" do
    Metronome::Provisioner.new(config, sqs_client: sqs_client).provision
  end
end
