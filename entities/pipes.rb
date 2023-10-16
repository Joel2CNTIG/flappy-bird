class Pipes

    attr_accessor :x, :y_pipe1, :y_pipe2, :x_start
    def initialize(w, h, y_pipe1, y_pipe2, x)
        @w = w
        @h = h
        @image_pipe1 = Gosu::Image.new('./img/pipe.png')
        @image_pipe2 = Gosu::Image.new('./img/pipe2.png')
        @offset_pipe = 714
        @x = x
        @x_start = x
        @y_pipe1 = y_pipe1
        @y_pipe2 = y_pipe2
        @y_pipe1 = rand((@h +400 -@offset_pipe)..(@h +700 -@offset_pipe))
        @y_pipe2 = @y_pipe1-714 -150
    end

    def update()
        @x -= 5
        if @x < -50
            @x = 1200
            @y_pipe1 = rand((@h +400 -@offset_pipe)..(@h +700 -@offset_pipe))
            @y_pipe2 = @y_pipe1-714 -150
        end
    end

    def draw()
        @image_pipe1.draw(@x, @y_pipe1)
        @image_pipe2.draw(@x, @y_pipe2)
    end
end