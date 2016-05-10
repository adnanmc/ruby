class Player

  def initialize
    puts "welcome to our dungen"
    puts "starting game now"
    @health = 100
  end

  def status
    puts "Remaining #{@health} hp left"

  end


  def attack(target)
    if target.is_alive?
      damage = rand(10)

      if damage == 0
        puts "You missed"
      else
        puts "you hit the wolf for #{damage} points"
      end
    else
      puts "target is dead"
    end
  end


end

class Monster

  def initialize
    @health = 100
  end

  def attack
    damage = rand(5)
    puts "wolf hits you for #{damage} hp"
  end


  def got_hit(damage)
    @health = @health - damage

    if @health <= 0

      puts "wolf just died"

    end
  end

  def is_alive?
    if @health <= 0
      return false
    else
      return true
    end

  end

end


me = Player.new
wolf = Monster.new


a.status

a.attack

a.attack
a.attack
