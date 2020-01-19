class Game
  def start
    puts "Player 1, what's your name?"
    p1_name = gets.chomp
    @player_1 = Player.new(p1_name, "X")
    puts "Player 2, what's your name?"
    p2_name = gets.chomp
    @player_2 = Player.new(p2_name, "O")
    @board = Board.new
    @board.show
  end

  def turn(player)
    puts "#{player.name}, pick the cell"
    pick = gets.chomp
    cell = pick.to_i-1

    if @board.field[cell] == "X" || @board.field[cell] == "O" || pick.length != 1 || !pick[/[1-9]/]
      puts "Invalid cell"
      self.turn(player)
    else
    @board.field[cell] = player.mark
    @board.show
    end
  end

  def finish
    case @board.winner
    when "X"
    puts "#{@player_1.name} won!"
    when "O"
    puts "#{@player_1.name} won!"
    else
    puts "It's a tie"
    end
    puts "Wanna play again?"
    puts "Y/N"
    valid_yes_answers = ["y","yes"]
    valid_no_answers = ["n","no"]
    answer = gets.chomp.downcase
    until valid_yes_answers.any? { |item| answer == item } || valid_no_answers.any? { |item| answer == item }
      puts "Enter 'Yes' or 'No'"
      answer = gets.chomp.downcase
    end
    Game.new.play if valid_yes_answers.any? { |item| answer == item }
  end

  def play
    self.start
    until @board.full? || @board.winner
      self.turn(@player_1)
      break if @board.full? || @board.winner
      self.turn(@player_2)
    end
    self.finish
  end
end