local pd <const> = playdate
local gfx <const> = pd.graphics


function edificio(currentBuildingPosX, currentBuildingPosY)

-- Crea un nuevo edificio sprite del vector que los contiene, segun el indice nroEdificio

nroEdificio += 1

-- Saves in the building matrix the starting position for the currentBuildingPos X and Y

edificioAttribute[nroEdificio] [2] = currentBuildingPosX
edificioAttribute[nroEdificio] [3] = currentBuildingPosY


-- Crea un valor random para recuperar el png con la imagen del eficio, con este valor completa el nombre del fichero

-- Saves in the building matrix the kind of building image from 1 to 4

buildingType = math.random( 1, 4 )

edificioAttribute[nroEdificio] [1] = buildingType

edificioImage = gfx.image.new("/isoimages/buildings/edificio"..buildingType)

edificioSprite [nroEdificio]  = gfx.sprite.new(edificioImage)

edificioSprite [nroEdificio].type ="smallbuilding"

-- Posicion en Limbo del edificio 

edificioSprite [nroEdificio] : moveTo(currentBuildingPosX, -100)

-- Buidling Collider

edificioSprite [nroEdificio] : setCollideRect(10 ,1, 40, 10)

-- Temporary deactivate collisions

edificioSprite [nroEdificio] : setCollisionsEnabled(false)


-- Calcula la posicion de destino hasta donde tiene que bajar el edificio

edificioAttribute[nroEdificio][4] = currentBuildingPosY + 256

--print ("EDIFICIO".. nroEdificio.." POSICION "..currentBuildingPosY + 256)


-- Dependiendo de donde caiga el edificio varia su Zindex 

if (currentBuildingPosY + 256) <= 150 then edificioSprite [nroEdificio] : setZIndex(10) else edificioSprite [nroEdificio] : setZIndex(25) end


edificioSprite [nroEdificio] : add()




end




-- UPDATE


function playdate.update()
    
   
    collisionResponse = buildingCollisionResponse
    gfx.sprite.update()

    
end