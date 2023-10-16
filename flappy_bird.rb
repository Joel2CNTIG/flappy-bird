require 'gosu'
require_relative './entities/bird'
require_relative './entities/pipes'

class Game < Gosu::Window

    def initialize 
        @w = 800
        @h = 600
        super(@w,@h)
        @background = Gosu::Image.new("img/flappy_bg.png")
        @pipes = Pipes.new(@w, @h, @y_pipe1, @y_pipe2, 1200)
        @pipes2 = Pipes.new(@w, @h, @y_pipe1, @y_pipe2, 1800)
        @bird = Bird.new(@w/2 - 47.5, @h/2 - 29.5, @w, @h, @pipes, @pipes2, false)
        self.caption = "flappy_bird"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @started = 0
    end

    def update
        if Gosu.button_down?(Gosu::KbSpace) || @started >= 1
            @started += 1
            @bird.update
            unless @bird.crashed
                @pipes.update
                @pipes2.update
            end
        end
    end

    def draw
        @background.draw(0,0)
        @font.draw("#{@bird.score} | #{@bird.highscore}", @w-60, 40, 1, 1.0, 1.0)
        @bird.draw
        @pipes.draw
        @pipes2.draw
    end
end

game = Game.new
game.show
