class CountDownLatchSerializer < ActiveJob::Serializers::ObjectSerializer
    def serialize?(argument)
        argument.is_a? CountDownLatch
    end

    def serialize(count_down_latch)
        super("count_down_latch" => count_down_latch.count)
    end

    def deserialize(hash)
        CountDownLatch.new(hash["count_down_latch"])
    end
end