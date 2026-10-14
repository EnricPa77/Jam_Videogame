class_name CarConfig extends Resource

##Mide qué tan rápido va el coche. Cuanto mayor sea, mayor es su velocidad.
@export var speed: float 
##Mide qué tan rápido se enfada el coche. Cuanto mayor sea más rapido se enfada.
@export var anger_speed_increase: float
##Mide qué tan rápido se desenfada el coche. Cuanto mayor sea más rapido se enfada.
@export var anger_speed_decrease: float
##Mide qué tan rápido el coche pilla aceleración y frena al enfadarse. Cuanto menor sea más rápido acelera y más rapido frena.
@export var anger_speed_car: float
##Mide la velocidad máxima del coche al enfadarse
<<<<<<< Updated upstream
@export var anger_max_speed: float
=======
@export var anger_max_speed: float = 80
>>>>>>> Stashed changes
