local pd <const> = playdate
local gfx <const> = pd.graphics


function specialEdificio(currentBuildingPosX, currentBuildingPosY)

-- Crea un nuevo edificio sprite del vector que los contiene, segun el indice nroEdificio

nroEdificio += 1

-- Saves in the building matrix the starting position for the currentBuildingPos X and Y

edificioAttribute[nroEdificio] [2] = currentBuildingPosX
edificioAttribute[nroEdificio] [3] = currentBuildingPosY


-- Crea un valor random para recuperar el png con la imagen del eficio, con este valor completa el nombre del fichero

-- Saves in the building matrix the kind of building image from 1 to 4

buildingType = math.random( 6, 7 )

edificioAttribute[nroEdificio] [1] = buildingType

edificioImage = gfx.image.new("/isoimages/buildings/edificio"..buildingType)

edificioSprite [nroEdificio]  = gfx.sprite.new(edificioImage)

edificioSprite [nroEdificio] : setCollideRect(1, 130, 64, 12)

edificioSprite[nroEdificio].type ="largebuilding"

-- Building Group Collider

--edificioSprite [nroEdificio] : setGroups(2)


-- Posicion en Limbo del edificio 

edificioSprite [nroEdificio] : moveTo(currentBuildingPosX, -110)

-- Calcula la posicion de destino hasta donde tiene que bajar el edificio

edificioAttribute[nroEdificio][4] = currentBuildingPosY + 256


edificioSprite [nroEdificio] : setZIndex(8)

edificioSprite [nroEdificio] : add()


end


