a = Robot.new # 0, 0
a.move_down # 0, -1
a.move_left # -1, -1

# puts a.inspect

b = Robot.new # 0, 0
b.move_up # 0, 1
b.move_right # 1, 1

# puts b.inspect

c = Robot.new

# puts c.inspect

d = Robot.new

e = Robot.new # 0, 0
b.move_up # 0, 1
b.move_up # 0, 2

f = b = Robot.new # 0, 0
b.move_down # -1, 0

puts b.enemies_around.inspect

puts Robot.all_robots




  def enemies_around
    x = position[0]
    y = position[1]
    surroundings = [[x-1, y-1], [x-1, y], [x-1, y+1], [x, y+1], [x, y-1], [x+1, y+1], [x+1, y], [x+1, y-1]]
    #surroundings = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]]
    #surroundings = surroundings.map {|e| Robot.in_position(e[0], e[1])}
  end
