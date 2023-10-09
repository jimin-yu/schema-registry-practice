require 'kafka'

# Kafka 클러스터에 연결
kafka = Kafka.new(
  seed_brokers: ['localhost:9094'],
  client_id: 'my-producer',
)

topic = 'sample-topic'
producer = kafka.producer

# 메시지 보내기
producer.produce('Hello, Kafka!', topic: topic)

# 프로듀서를 닫습니다.
producer.deliver_messages
producer.shutdown