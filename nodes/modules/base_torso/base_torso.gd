extends Module

func bind(player: Player, slot):
	super.bind(player, slot)
	player.damage_taken_factor *= 0.8
	
func unbind():
	player.damage_taken_factor /= 0.8
