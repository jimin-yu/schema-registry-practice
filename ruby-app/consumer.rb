require 'avro_turf'
require 'avro_turf/messaging'
require 'kafka'

SCHEMA_REGISTRY_URL = 'http://localhost:8081'
KAFKA_BROKER_URL = 'localhost:9094'

########################## FUNCTIONS ##############################

# Avro Schema + Encoded Data
def encoding_in_data_file_format(data)
  # [schema_path] *.avsc 파일 저장되어 있는 디렉토리 위치
  avro = AvroTurf.new(schemas_path: 'schemas/')
  encoded_data = avro.encode(data, schema_name: "person")
  # "Obj\u0001\u0004\u0014avro.codec\bnull\u0016avro.schema\xFA\u0002{\"type\":\"record\",\"name\":\"person\",\"fields\":[{\"name\":\"first_name\",\"type\":\"string\",\"doc\":\"이름\"},{\"name\":\"last_name\",\"type\":\"string\",\"doc\":\"성\"},{\"name\":\"age\",\"type\":\"int\",\"doc\":\"나이\"}]}\u0000\\\xFC\xFE\xF9G\xB5\xF2\u0006\\ЃY\f\xB8\v;\u0002\u0014\nJimin\u0004Yu6\\\xFC\xFE\xF9G\xB5\xF2\u0006\\ЃY\f\xB8\v;"
  encoded_data
end

# kafka, database 저장용
# 앞에 schema가 붙어있는 data file format 대신 사이즈 경량화 할 때 
# (사용 예시 스키마 레지스트리를 이용하는 카프카 메세징)
# Messaging API를 사용해야함 (include avro_turf/messaging)
# NOTE: The Messaging format is **not compatible** with the Avro data file API.
def encoding_in_messaging_format(data)
  avro = AvroTurf::Messaging.new(registry_url: SCHEMA_REGISTRY_URL)
  # Schema registry에 없으면 등록함.
  # I, [2023-10-09T11:48:15.894704 #18123]  INFO -- : Registered schema for subject `person`; id = 1
  encoded_message = avro.encode(data, schema_name: "person")
  # "\u0000\u0000\u0000\u0000\u0001\nJimin\u0004Yu6"
  encoded_message
end

def produce_message_to_topic(message, topic)
  kafka = Kafka.new(
    seed_brokers: [KAFKA_BROKER_URL],
    client_id: 'my-producer',
  )
  producer = kafka.producer
  producer.produce(message, topic: topic)
  producer.deliver_messages
  producer.shutdown
end

####################################################################

user_data = {
  "first_name" => 'Junbin',
  "last_name" => "Kwok",
  "age" => 27
}
encoded_message = encoding_in_messaging_format(user_data)
produce_message_to_topic(encoded_message, 'sample-topic')
p 'DONE'