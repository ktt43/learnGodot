extends RigidBody2D

const speed = 750


func explode():
	$AnimationPlayer.play("Explosion")
	
	#Check if there are the Entity Group or the Container Group are within the BlastRadius Area2d, if so, call the hit function for the nodes that is within the area
	var blast_radius = $BlastRadius.get_overlapping_bodies()
	print(blast_radius)
	for body in blast_radius:
		if body.is_in_group("Entity") or body.is_in_group("Container"):
			body.hit()
