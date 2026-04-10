extends genericObject



func hit():
	#on hit, remove the lid, then get a random marker then its position.
	$LidSprite.hide()
	if not opened:
		genericObject_hit_sound.play()
		for i in range(1):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos,current_direction)
		opened = true

	
