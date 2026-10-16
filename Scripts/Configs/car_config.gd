class_name CarConfig extends Resource

##Mide qué tan rápido va el coche. Cuanto mayor sea, mayor es su velocidad.
@export var speed: float = 60
##Mide el aumento de rabia por segundo hasta llegar a 100
@export_range (0, 20, 0.5) var anger_speed_increase: float = 10
##Mide cuanta rabia baja por segundo hasta llegar a 0
@export_range (0, 20, 0.5) var anger_speed_decrease: float = 10
##Mide la velocidad que cambia el coche por segundo al enfadarse o desenfadarse.
@export_range (0, 10, 0.5) var anger_speed_car: float = 2
##Mide la velocidad máxima del coche al enfadarse
@export var anger_max_speed: float = 100
