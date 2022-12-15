local pd <const> = playdate
local gfx <const> = pd.graphics


function squareMonuments(currentSquarePosX, currentSquarePosY, currentMonumentType)


-- Crea un nuevo edificio sprite del vector que los contiene, segun el indice nroEdificio

nroMonuments += 1


--print ("Monumento nro "..nroMonuments)

-- Saves in the building matrix the starting position for the currentBuildingPos X and Y

squareAttribute [nroMonuments] [2] = currentSquarePosX
squareAttribute [nroMonuments] [3] = currentSquarePosY


-- Crea un valor random para recuperar el png con la imagen del eficio, con este valor completa el nombre del fichero

-- Saves in the building matrix the kind of building image from 1 to 4

-- ESTATUES 

if currentMonumentType == "S0" then 

    squareMonumentType = math.random(1, 4)

    squareAttribute[nroMonuments][1] = squareMonumentType 

   -- print ("ESTATUA "..squareMonumentType)

    squareImage = gfx.image.new("/isoimages/monuments/estatua"..squareMonumentType)

    squareSprite [nroMonuments]  = gfx.sprite.new(squareImage)

    -- Posicion en Limbo 

    squareSprite [nroMonuments] : moveTo(currentSquarePosX, -100)

    -- Calcula la posicion de destino hasta donde tiene que bajar el edificio

    squareAttribute[nroMonuments][4] = currentSquarePosY + 256

    squareSprite [nroMonuments] : setZIndex(14)

    squareSprite [nroMonuments] : add()

                                end


-- BENCHES

if currentMonumentType == "S12" then 

    squareMonumentType = math.random(1, 4)
    
    squareAttribute[nroMonuments][1] = squareMonumentType 

   -- print ("BENCH "..squareMonumentType)

    squareImage = gfx.image.new("/isoimages/monuments/squarebench"..squareMonumentType)

    squareSprite [nroMonuments]  = gfx.sprite.new(squareImage)

    -- Posicion en Limbo 

    squareSprite [nroMonuments] : moveTo(currentSquarePosX, -100)

    -- Calcula la posicion de destino hasta donde tiene que bajar el edificio

    squareAttribute[nroMonuments][4] = currentSquarePosY + 256

    squareSprite [nroMonuments] : setZIndex(11)

    squareSprite [nroMonuments] : add()

                                end

                                
-- SQUARE ITEMS

  if currentMonumentType == "S13" then 

  squareMonumentType = math.random(1, 2)
                                    
  squareAttribute[nroMonuments][1] = squareMonumentType 
                                
 -- print ("ITEM DE PLAZA "..squareMonumentType)
                                
  squareImage = gfx.image.new("/isoimages/monuments/squareitems"..squareMonumentType)
                                
  squareSprite [nroMonuments]  = gfx.sprite.new(squareImage)
                                
  -- Posicion en Limbo 
  
 squareSprite [nroMonuments] : moveTo(currentSquarePosX, -100)

 -- Calcula la posicion de destino hasta donde tiene que bajar el edificio
                                
 squareAttribute[nroMonuments][4] = currentSquarePosY + 256
                                
 squareSprite [nroMonuments] : setZIndex(15)
                                
 squareSprite [nroMonuments] : add()
                                
end                                


end




