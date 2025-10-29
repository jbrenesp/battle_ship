# lib/ai_player.rb
class AIPlayer
  attr_reader :remaining_ships, :previous_hits

  def initialize
    @previous_shots = []
    @previous_hits = []
  end

  # Returns [result, [row, col]]
  def take_turn(board)
    row, col = select_target(board)
    result = board.fire(row, col)
    @previous_shots << [row, col]

    # Track hits for targeting strategy
    @previous_hits << [row, col] if result == "Hit"

    [result, [row, col]]
  end

  private

  def select_target(board)
    # If there are previous hits, try surrounding cells
    if @previous_hits.any?
      target = target_adjacent(board)
      return target if target
    end

    # Otherwise, random shot
    loop do
      row = Board::ROWS.sample
      col = Board::COLUMNS.sample
      unless @previous_shots.include?([row, col])
        return [row, col]
      end
    end
  end

  def target_adjacent(board)
    @previous_hits.each do |hit_row, hit_col|
      # Generate potential adjacent coordinates
      adjacent = [
        [hit_row, hit_col - 1],
        [hit_row, hit_col + 1],
        [Board::ROWS[Board::ROWS.index(hit_row) - 1], hit_col],
        [Board::ROWS[Board::ROWS.index(hit_row) + 1], hit_col]
      ].select do |r, c|
        valid_coordinate?(r, c) && !@previous_shots.include?([r, c])
      end

      return adjacent.sample if adjacent.any?
    end
    nil
  end

  def valid_coordinate?(row, col)
    Board::ROWS.include?(row) && Board::COLUMNS.include?(col)
  end
end
