#lib/board.rb
class Board
  ROWS = ('A'..'J').to_a
  COLUMNS = (1..10).to_a

  def initialize
    #creates a 10 x10 grid (~ represents water)
    @grid = Array.new(ROWS.size) {Array.new(COLUMNS.size, '~')}
  end

  def display
    #prints column headers
    puts "  " + COLUMNS.join('   ')
    #prints each row with the row letter
    @grid.each_with_index do |row, i|
      puts "#{ROWS[i]} #{row.join('   ')}"
    end
  end
end

