class Bird

    attr_reader :score, :highscore, :crashed
    def initialize(x, y, w, h, pipe, pipe2, crashed)
        @pipe = pipe
        @pipe2 = pipe2
        @x = x
        @y = y
        @w = w
        @h = h
        @y_speed = 0
        @upd_y = 0.5
        @jump_y = -10
        @cooldown = 0
        @is_helddown = 0
        @score = 0
        @hitbox_x_low = -40
        @hitbox_x_high = 47.5
        @hitbox_y_low = -25
        @hitbox_y_high = 34
        @f = File.open("./highscore.txt","r")
        @g = @f.read
        @highscore = 0
        @highscore += @g.to_i
        @image = Gosu::Image.new("./img/bird.png")
        @crashed = crashed
        @crashed = false
    end

    def update
        if @crashed
            @image = Gosu::Image.new("./img/bird2.png")
            @y += 10
            if @y >= @w
                @y_speed = 0
                @x = @w/2 - 47.5
                @y = @h/2 - 29.5
                @pipe.x = @pipe.x_start
                @pipe2.x = @pipe2.x_start
                @pipe.y_pipe1 = rand((@h +400 -714)..(@h +700 -714))
                @pipe.y_pipe2 = @pipe.y_pipe1-714 -150
                @pipe2.y_pipe1 = rand((@h +400 -714)..(@h +700 -714))
                @pipe2.y_pipe2 = @pipe2.y_pipe1-714 -150
                @score = 0
                @crashed = false
            end
        else
            @cooldown += 1
            if @y_speed < 25
                @y_speed += @upd_y
            end
            if @y_speed > 15
                @image = Gosu::Image.new("./img/bird2.png")
                @hitbox_x_low = -25
                @hitbox_x_high = 34
                @hitbox_y_low = -40
                @hitbox_y_high = 47.5
            else
                @image = Gosu::Image.new("./img/bird.png")
                @hitbox_y_low = -25
                @hitbox_y_high = 34
                @hitbox_x_low = -40
                @hitbox_x_high = 47.5
            end
            if Gosu.button_down?(Gosu::KbSpace)
                if @y > -100
                    if @cooldown > 2
                        if @is_helddown < 1
                            @is_helddown += 1
                            @cooldown = 0
                            @y_speed = @jump_y
                        end
                    end
                end
            else
                @is_helddown = 0
            end
            if @y + 29.5 >= @w
                sleep(2)
                @y_speed = 0
                @x = @w/2 - 47.5
                @y = @h/2 - 29.5
                @score = 0
            end
            if ((((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).first <= ((@pipe.x-36.5)..(@pipe.x+36.5)).last && ((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).last >= ((@pipe.x-36.5)..(@pipe.x+36.5)).first && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high)).first <= ((@pipe.y_pipe1)..(@pipe.y_pipe1+714)).last && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high)).last >= ((@pipe.y_pipe1)..(@pipe.y_pipe1+714)).first) || (((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).first <= ((@pipe2.x-36.5)..(@pipe2.x+36.5)).last && ((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).last >= ((@pipe2.x-36.5)..(@pipe2.x+36.5)).first && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high)).first <= ((@pipe2.y_pipe1)..(@pipe2.y_pipe1+714)).last && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high)).last >= ((@pipe2.y_pipe1)..(@pipe2.y_pipe1+714)).first)) || ((((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).first <= ((@pipe.x-36.5)..(@pipe.x+36.5)).last && ((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).last >= ((@pipe.x-36.5)..(@pipe.x+36.5)).first && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high+11)).first <= ((@pipe.y_pipe2)..(@pipe.y_pipe2+680)).last && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high+11)).last >= ((@pipe.y_pipe2-40)..(@pipe.y_pipe2+680)).first) || (((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).first <= ((@pipe2.x-36.5)..(@pipe2.x+36.5)).last && ((@x+@hitbox_x_low)..(@x+@hitbox_x_high)).last >= ((@pipe2.x-36.5)..(@pipe2.x+36.5)).first && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high+11)).first <= ((@pipe2.y_pipe2)..(@pipe2.y_pipe2+680)).last && ((@y+@hitbox_y_low)..(@y+@hitbox_y_high+11)).last >= ((@pipe2.y_pipe2-40)..(@pipe2.y_pipe2+680)).first))
                @crashed = true
            end

            if @pipe.x == 350 || @pipe2.x == 350
                @score += 1
                if @score > @highscore
                    @highscore = @score
                end
            end
            if @highscore > @g.to_i
                h = File.open("./highscore.txt","w")
                h.write(@highscore)
            end
            @y += @y_speed
        end
    end

    def draw 
        @image.draw(@x,@y)
    end
end