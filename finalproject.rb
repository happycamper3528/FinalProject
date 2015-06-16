require 'gosu'

class ColorImage < Gosu::Image
  def initialize(path, *options)
    super(path, *options)

    @hidden = false
  end

  def toggleHide
    if @hidden
      @hidden = false
    else
      @hidden = true
    end
  end

  def draw(x, y, z)
    if !@hidden
      super(x, y, z)
    end
  end
end

class GameWindow < Gosu::Window
  def initialize
    super 600, 449
    self.caption = "Musical Colors"

    @red = ColorImage.new("./red_square.jpg", :tileable => true)
    @orange = ColorImage.new("./orange_square.jpg", :tileable => true)
    @yellow = ColorImage.new("./yellow_square.jpg", :tileable => true)
    @lightgreen = ColorImage.new("./light_green_square.jpg", :tileable => true)
    @darkgreen = ColorImage.new("./dark_green_square.jpg", :tileable => true)
    @lightblue = ColorImage.new("./light_blue_square.gif", :tileable => true)
    @darkblue = ColorImage.new("./dark_blue_square.jpg", :tileable => true)
    @purple = ColorImage.new("./purple_square.gif", :tileable => true)
    @pink = ColorImage.new("./pink_square.png", :tileable => true)
    @brown = ColorImage.new("./brown_square.jpg", :tileable => true)
    @grey = ColorImage.new("./grey_square.jpg", :tileable => true)
    @white = ColorImage.new("./white_square.jpg", :tileable => true)

    @colors = [@red, @orange, @yellow, @lightgreen, @darkgreen, @lightblue, @darkblue, @purple, @pink, @brown, @grey, @white]

    @color = @colors.shuffle

    @PianoC = Gosu::Sample.new("./PianoC.aif")
    @PianoCSharp = Gosu::Sample.new("./PianoC#.aif")
    @PianoD = Gosu::Sample.new("./PianoD.aif")
    @PianoEb = Gosu::Sample.new("./PianoEb.aif")
    @PianoE = Gosu::Sample.new("./PianoE.aif")
    @PianoF = Gosu::Sample.new("./PianoF.aif")
    @PianoFSharp = Gosu::Sample.new("./PianoF#.aif")
    @PianoG = Gosu::Sample.new("./PianoG.aif")
    @PianoGSharp = Gosu::Sample.new("./PianoG#.aif")
    @PianoA = Gosu::Sample.new("./PianoA.aif")
    @PianoBb = Gosu::Sample.new("./PianoBb.aif")
    @PianoB = Gosu::Sample.new("./PianoB.aif")

    @font1 = Gosu::Font.new(30)
    @font2 = Gosu::Font.new(20)
    @font3 = Gosu::Font.new(60)
    @font4 = Gosu::Font.new(45)

    @start = Time.now

    @count = 0

    @lose = false
    @win = false
  end

  def needs_cursor?
    true
  end

  def update
  end

  def draw
    @color.each_with_index do |color, i|
      color.draw(i*50, 0, 0)
    end
    @font1.draw("INSTRUCTIONS: ", 0, 50, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("Play the above colors in order. You have 30 seconds.", 0, 80, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("red = A", 0, 100, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("orange = W", 0, 120, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("yellow = S", 0, 140, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("light green = E", 0, 160, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("dark green = D", 0, 180, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("light blue = F", 0, 200, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("dark blue = T", 0, 220, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("purple = G", 0, 240, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("pink = Y", 0, 260, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("brown = H", 0, 280, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("grey = U", 0, 300, 0, 1, 1, Gosu::Color::RED)
    @font2.draw("white = J", 0, 320, 0, 1, 1, Gosu::Color::RED)

    if @lose
      @font4.draw("WRONG NOTE! YOU LOSE!", 5, 387, 0, 1, 1, Gosu::Color::BLUE)
      @font1.draw("Press Space to exit.", 320, 350, 0, 1, 1, Gosu::Color::BLUE)
    end

    if @win
      @font4.draw("YOU WIN!", 5, 387, 0, 1, 1, Gosu::Color::BLUE)
      @font1.draw("Press Space to exit.", 320, 350, 0, 1, 1, Gosu::Color::BLUE)
    end

    timer = (35 - (Time.now - @start)).round

    if timer <= 0
      @font1.draw('0', 0, 0, 0, 1, 1, Gosu::Color::GRAY)
      @font3.draw("TIME'S UP!", 5, 387, 0, 1, 1, Gosu::Color::BLUE)
      @font1.draw("Press Space to exit.", 320, 400, 0, 1, 1, Gosu::Color::BLUE)
    else
      @font1.draw(timer.to_s, 0, 0, 0, 1, 1, Gosu::Color::GRAY)
    end
  end

  def button_down(id)
    if id == Gosu::KbA
      @red.toggleHide
      @PianoC.play
      if @color[@count] != @red
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbW
      @orange.toggleHide
      @PianoCSharp.play
      if @color[@count] != @orange
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbS
      @yellow.toggleHide
      @PianoD.play
      if @color[@count] != @yellow
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbE
      @lightgreen.toggleHide
      @PianoEb.play
      if @color[@count] != @lightgreen
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbD
      @darkgreen.toggleHide
      @PianoE.play
      if @color[@count] != @darkgreen
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbF
      @lightblue.toggleHide
      @PianoF.play
      if @color[@count] != @lightblue
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbT
      @darkblue.toggleHide
      @PianoFSharp.play
      if @color[@count] != @darkblue
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbG
      @purple.toggleHide
      @PianoG.play
      if @color[@count] != @purple
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbY
      @pink.toggleHide
      @PianoGSharp.play
      if @color[@count] != @pink
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbH
      @brown.toggleHide
      @PianoA.play
      if @color[@count] != @brown
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbU
      @grey.toggleHide
      @PianoBb.play
      if @color[@count] != @grey
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbJ
      @white.toggleHide
      @PianoB.play
      if @color[@count] != @white
        @lose = true
      else
        @count = @count + 1
      end
    end
    if id == Gosu::KbSpace
      exit
    end
    if @count == 12
      @win = true
    end
  end
end

window = GameWindow.new
window.show