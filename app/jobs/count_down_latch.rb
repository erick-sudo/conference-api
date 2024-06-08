require 'monitor'

class CountDownLatch
    def initialize(count)
        @count = count
        @monitor = Monitor.new
        @condition = @monitor.new_cond
    end

    def count_down
        @monitor.synchronize do
            @count -= 1
            @condition.broadcast if @count <= 0
        end
    end

    def await
        @monitor.synchronize do
            @condition.wait_while { @count > 0 }
        end
    end
end