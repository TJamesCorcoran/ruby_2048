require 'test/unit'

extend Test::Unit::Assertions

module Direction
  Up = 1
  Right = 2
  Down = 3
  Left =4
end

# collapse an array to the left
def collapse(array)
    output = Array.new(array.size(), 0)
    collapse = 0;
    skip = false
    ww = 0
    for ii in (0 .. array.size() - 1)
      
      puts "read index = #{ii}; write index = #{ww}"
      if array[ii] == 0
        puts "    zero"
      elsif skip
        puts "    skip!"
        skip = false
      elsif array[ii] == array[ii + 1]
        puts "    collapse"
        output[ww] = 2 * array[ii]
        ww += 1
        skip = true
      else
        output[ww] = array[ii]
        ww += 1
        puts "    single"
      end

    end
    return output
end 


class Board
  def initialize()
    @board = [[0, 10, 0, 0],
              [0, 10, 0, 0],
              [0, 30, 0, 0],
              [0, 40, 0, 0]
  ]
  end

  def col(qq)
    @board.map { |row| row[qq]}
  end

  def tilt(direction)
    output = Array.new(@board.size()) { Array.new(@board.size(), 0) }
    case direction
    when Direction::Left
      puts "LEFT"
      for ii in 0 .. (@board.size() - 1)
        output[ii] = collapse(@board[ii])
      end
    when Direction::Right
      puts "RIGHT"
      for ii in 0 .. (@board.size() - 1)
        output[ii] = collapse(@board[ii].reverse()).reverse()
      end
    when Direction::Up
      puts "UP"
      for cc in 0 .. (@board.size() - 1)
        puts "-------------- col = #{cc}"
        col_out = collapse(self.col(cc))
        puts "col = #{cc} ; col_in = #{self.col(cc)} ; col_out = #{col_out}"
        col_out.each_with_index { |val, row_index|
          output[row_index][cc] = val 
        }
      end 
    when Direction::Down
      puts "DOWN"
      for cc in 0 .. (@board.size() - 1) 
        puts "-------------- col = #{cc}"
        col_out = collapse(self.col(cc).reverse()).reverse()
        puts "col = #{cc} ; col_in = #{self.col(cc)} ; col_out = #{col_out}"
        col_out.each_with_index { |val, row_index|
          output[row_index][cc] = val 
        }        
      end
    end
    @board = output
    puts "@board = #{@board}"
end
end 

def test
  # array = [ 1, 2, 4, 4];
  # assert_equal(collapse(array), [1,2,8,0]);

  #array = [ 2, 2, 4, 4];
  #assert_equal(collapse(array), [4,8,0, 0]);

  board = Board::new()
  # board.tilt(Direction::Left)
  # board.tilt(Direction::Right)
  # board.tilt(Direction::Right)
  # board.tilt(Direction::Left)
  # puts" col = #{board.col(0)}"
  board.tilt(Direction::Down)
end

test()
