puts "Welcome to Stratego!"
puts "If you take the button labled 'f' then you win!""
require 'fox16'

include Fox

class HelloWorldWindow < FXMainWindow
  def initialize(app)
    super(app, 'Hello World Program')

    @mtx = FXMatrix.new(self, 6)

    numbers1 = ["F", "5", "4", "4", "3", "3", "3", "2", "2", "2", "2", "1", "1", "1", "1", "1"].shuffle
    numbers2 = ["F", "5", "4", "4", "3", "3", "3", "2", "2", "2", "2", "1", "1", "1", "1", "1"].shuffle

    8.times do
      6.times do |i|
        btn = FXButton.new(@mtx, '', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 50, :height => 50)
        btn.textColor = :white

        if i == 0 || i == 1
          btn.backColor = "red"
          btn.text = numbers1.pop
        elsif i == 2 || i == 3
          btn.backColor = "white"
        elsif i == 4 || i == 5
          btn.backColor = "blue"
          btn.text = numbers2.pop
        end


        btn.connect(SEL_COMMAND) do
          if btn.backColor == 4294967295 # white
            # nothing
          elsif btn.backColor == Fox.fxcolorfromname("red") # red
            # fetch the new btn
            btn_row = @mtx.rowOfChild(btn)
            btn_col = @mtx.colOfChild(btn)
            new_btn = @mtx.childAtRowCol(btn_row+1, btn_col)

            # if the new btn is white then
            if new_btn && new_btn.backColor == Fox.fxcolorfromname("white")
              # moves the btn
              btn.backColor = "white"
              new_btn.backColor = "red"
              new_btn.text = btn.text
              btn.text = ""
            #if red is bigger than blue
            elsif new_btn && new_btn.backColor == Fox.fxcolorfromname("blue")
              if btn.text.to_i > new_btn.text.to_i
                new_btn.backColor = "red"
                btn.backColor = "blue"
                new_btn.text = btn.text
                btn.backColor = "white"
                btn.text = ""
              end
            end

            # for blue
          elsif btn.backColor ==  Fox.fxcolorfromname("blue") # blue
            btn_row = @mtx.rowOfChild(btn)
            btn_col = @mtx.colOfChild(btn)
            new_btn = @mtx.childAtRowCol(btn_row-1, btn_col)

            if new_btn && new_btn.backColor == Fox.fxcolorfromname("white")
              btn.backColor = "white"
              new_btn.backColor = "blue"
              new_btn.text = btn.text
              btn.text = ""
            # if blue is bigger than red
            elsif new_btn && new_btn.backColor == Fox.fxcolorfromname("red")
              if btn.text.to_i > new_btn.text.to_i
                new_btn.backColor = "blue"
                btn.backColor = "red"
                new_btn.text = btn.text
                btn.backColor = "white"
                btn.text = ""
              end
            end
          end
        end
      end
    end
  end

  # don't touch this
  def create
    super
    self.show(PLACEMENT_SCREEN)
  end
end

# never touch these
app = FXApp.new
HelloWorldWindow.new(app)
app.create
app.run


