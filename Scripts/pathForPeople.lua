local pd <const> = playdate
local gfx <const> = pd.graphics

import 'libraries/AnimatedSprite.lua'


function pathForPeople()

  -- Calcula una trayectoria para un personaje de al menos 14 casillas de extension

 freeTile = true
 tripCounter = 1
 possibleTrajectory = math.random(1,4)

  
  print ("TRAYECTORIA "..possibleTrajectory)
  
  if possibleTrajectory == 1 then 
    print ("16 x 16")
    
   possibleFreeTileX = 16
   possibleFreeTileY = 16

   startingFreeTileX = 16
   startingFreeTileY = 16

   animationIda="walkBackRight"
   animationVuelta="walkFrontLeft"

   walkSpeed = 15000

  end

 if possibleTrajectory == 2 then 
  print ("1 x 16")

  possibleFreeTileX = 1
  possibleFreeTileY = 16

  startingFreeTileX = 1
  startingFreeTileY = 16

  animationIda="walkBackLeft"
  animationVuelta="walkFrontRight"

  walkSpeed = 30000

end

if possibleTrajectory == 3 then 

  print ("16 x 1")

  possibleFreeTileX = 16
  possibleFreeTileY = 1

  startingFreeTileX = 16
  startingFreeTileY = 1

  animationIda="walkFrontRight"
  animationVuelta="walkBackLeft"

  walkSpeed = 25000

end

if possibleTrajectory == 4 then 

  print ("1 x 1")


  possibleFreeTileX = 1
  possibleFreeTileY = 1

  startingFreeTileX = 1
  startingFreeTileY = 1

  animationIda="walkFrontLeft"
  animationVuelta="walkBackRight"

  walkSpeed = 20000

end


  -- Verifica si hay tiles libres en Y

  while (freeTile) and (tripCounter <= 14) do
    
    if normalMap [possibleFreeTileX] [possibleFreeTileY] == "G" then 
      

            destinationPathX = isoMap [possibleFreeTileX] [possibleFreeTileY].x
            destinationPathY = isoMap [possibleFreeTileX] [possibleFreeTileY].y

           --print ("TIPO DE CELDA "..normalMap [possibleFreeTileX] [possibleFreeTileY])
           -- print ("Cantidad de celdas"..tripCounter)

      tripCounter +=1 

      if possibleTrajectory == 1 then  possibleFreeTileX -=1 end
      if possibleTrajectory == 2 then  possibleFreeTileY -=1 end
      if possibleTrajectory == 3 then  possibleFreeTileY +=1 end
      if possibleTrajectory == 4 then  possibleFreeTileX +=1 end


    else
      
      freeTile = false
      tripCounter = 1

    end

 
    
    
  end

end

