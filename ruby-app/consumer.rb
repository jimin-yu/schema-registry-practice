require 'kafka'
require 'avro_turf'
require 'avro_turf/messaging'

SCHEMA_REGISTRY_URL = 'http://localhost:8081'
KAFKA_BROKER_URL = 'localhost:9094'
KAFKA = Kafka.new([KAFKA_BROKER_URL])
AVRO = AvroTurf::Messaging.new(registry_url: SCHEMA_REGISTRY_URL)

def subscribe_topic(topic)
  consumer = KAFKA.consumer(group_id: "my-consumer")
  consumer.subscribe(topic)
  trap("TERM") { consumer.stop }
  consumer
end

def decode_avro_message(encoded_message)
  # encoded_message가 schema_id를 포함하고 있어서 어떤 스키마 인지 알 수 있음.
  decoded_message = AVRO.decode(encoded_message)
  decoded_message
end

# This will loop indefinitely, yielding each message in turn.
consumer = subscribe_topic('sample-topic')
consumer.each_message do |message|
  p "#{message.topic} : #{message.offset}"
  p decode_avro_message(message.value)
rescue => e
  p e
  p 'cannot decode'
end