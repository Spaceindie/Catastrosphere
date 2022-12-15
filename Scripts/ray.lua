local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
import "scripts/flyingScore"

class('ray').extends(AnimatedSprite)

alcanceTiro = 0
hitBuilding = false
hitPlane = false
hitBiplane = false
oneTimeShake = false
hitCounter = 1

hitTime = true

function ray:init(xDirection, yDirection,  raySpeed, rayDamage)


-- crea imagen del rayo 

    raySpriteSheet = gfx.imagetable.new("/images8bit/weapons/ray-table-16-24")

    ray.super.init(self, raySpriteSheet)

    self: addState("sparking", 1, 2, {tickStep = 12})

    self: setCenter(0,0)

    self: setCollideRect(0, 0, 16, 24)

    self: setZIndex(110)

    self.speed = raySpeed

    self.type = "ray"

    self: changeState("sparking")

    self:playAnimation()

   -- Se posiciona el objeto a disparar

      self.xPosition = xDirection 

      self.yPosition = yDirection 

      self.objectSpeed = raySpeed


      self: moveWithCollisions(self.xPosition  , self.yPosition)


    self:add()
   


-----------------------------------------
-- COLLISION DETECTION
-----------------------------------------


function rayCollisionResponse( self, other)

    --print (other.type)

-- HITTING THE BUILDINGS

   if (other.type =="smallbuilding") and (hitTime == true) then
    
    -- makes the ray sprite invisible when hit the building 
    self:setVisible(false)

    -- If there's a hit agains a building this should show the destroyed version 1-4 sprites

    hitBuilding = true

    hitTime = false

     
    for i = 1, 4 do -- check for all the buildings to find which one has been hit
      
      -- El nombre de cada sprite de los edificios se compone de dos partes
      -- La primer esta en identificadorEdificioPartA que es el numero del 1 al 4
      -- la segunda tambien es un numero del 1 al 4 contenida en identificadorEdificioPartB
      
      if other == edificioSprite[i] then edificioAttribute[i][7] = edificioAttribute[i][7] + 1 -- hit dammages increases in 1 

      identificadorEdificioPartA = edificioAttribute[i][1]
      identificadorEdificioPartB = edificioAttribute[i][7]

      if (identificadorEdificioPartB <= 4) then

      edificioDestroyed = gfx.image.new("/isoimages/buildings/edificio"..identificadorEdificioPartA..identificadorEdificioPartB)

  
      -- Generates the same image but inverted for FX

    edificioInvertido = edificioDestroyed:invertedImage()

    edificioSprite[i]:setImage(edificioInvertido)

    -- Pause and change image for the real one
    
    playdate.timer.performAfterDelay(200, function ()

    edificioSprite[i]:setImage(edificioDestroyed)
      
      end)

      
    end
    end
    end

    return gfx.sprite.kCollisionTypeOverlap
  
    end -- del Smallbuilding


-- HITTING THE LARGE BUILDINGS

    
  if (other.type =="largebuilding") and (hitTime == true) then

    -- makes the ray sprite invisible when hit the building 
    self:setVisible(false)

    hitBuilding = true
    hitTime = false

   --print (other.type)

   for i = 1, 4 do -- check for all the buildings to find which one has been hit
      
    -- El nombre de cada sprite de los edificios se compone de dos partes
    -- La primer esta en identificadorEdificioPartA que es el numero del 1 al 4
    -- la segunda tambien es un numero del 1 al 4 contenida en identificadorEdificioPartB
    
    if other == edificioSprite[i] then edificioAttribute[i][7] = edificioAttribute[i][7] + 1 -- hit dammages increases in 1 

    identificadorEdificioPartA = edificioAttribute[i][1] 
    identificadorEdificioPartB = edificioAttribute[i][7]

    if (identificadorEdificioPartB <= 4) then

    edificioDestroyed = gfx.image.new("/isoimages/buildings/edificio"..identificadorEdificioPartA..identificadorEdificioPartB)

    -- Generates the same image but inverted for FX

    edificioInvertido = edificioDestroyed:invertedImage()

    edificioSprite[i]:setImage(edificioInvertido)

    -- Pause and change image for the real one
    
    playdate.timer.performAfterDelay(200, function ()

     
    edificioSprite[i]:setImage(edificioDestroyed)
      
      end)


  end
  end
  end

  
  return gfx.sprite.kCollisionTypeOverlap
  
  
  end -- del largebuilding

--[[

-- HITTING THE PLAYER

if (other.type =="player")  then

    return gfx.sprite.kCollisionTypeOverlap

end

--]]

-- HITTING CAR

if (other.type =="car")  and (hitTime) then

  other:changeState("destroyed")
 
   hitCar = true
   hitTime = false

   end
 
 

-- HITTING THE TREES

if (other.type =="tree") and (hitTime) then

    -- makes the ray sprite invisible when hit the trees
    self:setVisible(false)

  hitTree = true
  hitTime = false

   other: changeState("burnt")

   return gfx.sprite.kCollisionTypeOverlap

end -- del hit tree


  -- HITTING GUYS

  if (other.type =="man") and (hitTime) then

    -- makes the ray sprite invisible when hit the character

  self:setVisible(false)
  
  for i= 1, 2 do

   if other == guySprite[i] then guyVictim = i end
   
  end

  if guyVictim == 1 then  character1IsDead = true end
  if guyVictim == 2 then  character2IsDead = true end
 

  other: changeState("rayImpact")

  hitMan = true
  hitTime = false

  playdate.timer.performAfterDelay(2000, function ()
  other: remove()
  end)


   return gfx.sprite.kCollisionTypeOverlap

end -- del hit MAN




if (other.type =="woman")  and (hitTime) then

  -- makes the ray sprite invisible when hit the character

self:setVisible(false)

 
for i= 1, 2 do 

  if other == guySprite[i] then guyVictim = i end

 end

 if guyVictim == 1 then  character1IsDead = true end
 if guyVictim == 2 then  character2IsDead = true end

 
hitWoman = true
hitTime = false


self:setVisible(false)
characterIsDead = true
other: changeState("rayImpact")

playdate.timer.performAfterDelay(2000, function ()

other: remove()

end)

 return gfx.sprite.kCollisionTypeOverlap

end -- del hit WOMAN


-- HITTING PLANE

if (other.type =="plane") and (hitTime == true) then

  -- makes the ray sprite invisible when hit the building 

  self:setVisible(false)

  hitPlane = true
  hitTime = false

-- PLane is touched

other:changeState("down")

return gfx.sprite.kCollisionTypeOverlap

end -- del hit PLANE


-- HITTING BIPLANE

if (other.type =="biPlane") and (hitTime == true) then

  -- makes the ray sprite invisible when hit the building 

  self:setVisible(false)

  hitBiplane = true
  hitTime = false

-- PLane is touched

other:changeState("down")

return gfx.sprite.kCollisionTypeOverlap

end -- del hit BIPLANE




end -- de la funcion rayCollisionResponse
end -- DEL INIT

-- UPDATE

function ray:update()

  -------------------------------
-- HIT SCORES
-------------------------------


    -- Desplaza el objeto arrojable
    -- Deshabilita la posibilidad de disparar varias veces

    attackReady = false
  
    self: moveWithCollisions(self.xPosition  , self.yPosition + alcanceTiro)
   
     alcanceTiro += self.objectSpeed


    -- HIT BUILDING SCORE 

     if (alcanceTiro >= 80) and (hitBuilding) then

     -- print ("hit")
      scoreBanner = 10
      flyingScore(200, 120)
      alcanceTiro = 0
      attackReady = true

      score:addTen()
   
      hitTime = true
      self:remove()
      hitBuilding = false
  end


  -- HIT TREE SCORE 

  if  (alcanceTiro >= 80) and (hitTree) then
    
    --print ("hit")
    scoreBanner = 50
    flyingScore(200, 120)
    alcanceTiro = 0
    attackReady = true

    score:addFifty()
 
    hitTime = true
    self:remove()
    hitTree= false

end

  -- HIT MAN SCORE 

if  (alcanceTiro >= 80) and  (hitMan) then
    
  --print ("hit MAN")
  scoreBanner = 100
  flyingScore(200, 120)
  alcanceTiro = 0
  attackReady = true

  score:addHundred()

  hitTime = true
  self:remove()
  hitMan= false

end

if  (alcanceTiro >= 80) and (hitWoman) then
    
  --print ("hit WOMAN")

  scoreBanner = 100
  flyingScore(200, 120)
  alcanceTiro = 0
  attackReady = true

  score:addHundred()

  hitTime = true
  self:remove()
  hitWoman= false
  

end

-- HIT PLANE SCORE 

 -- if (alcanceTiro >= 80) and (hitPlane) then

    if  (hitPlane) then
    
    print ("hit")
    scoreBanner = 150
    flyingScore(200, 120)
    alcanceTiro = 0
    attackReady = true

    score:addTwoHundred()
 
    hitTime = true
    self:remove()
    hitPlane = false

end

-- HIT BIPLANE SCORE 

if  (hitBiplane) then
    
  print ("hit")
  scoreBanner = 150
  flyingScore(200, 120)
--  flyingScore(playerSprite.x, playerSprite.y +150)
  alcanceTiro = 0
  attackReady = true

  score:addTwoHundred()

  hitTime = true
  self:remove()
  hitBiplane = false

end

   -- HIT CAR
   if (hitCar) then

    self:remove()
    -- print ("hit")
     scoreBanner = 10
     flyingScore(200, 120)
     alcanceTiro = 0
     attackReady = true

     score:addTen()
     hitTime= true
     hitCar = false
 end


-- NO HIT NO SCORE 

  -- Si no hay impacto no hay puntaje 

 if (alcanceTiro >= 80) and (hitBuilding == false) then

  print ("NO hit")
      scoreBanner = 0
      flyingScore(200, 120)
      alcanceTiro = 0
      attackReady = true
      self:remove()

  end


self:updateAnimation()
self.yPosition += 1
self.collisionResponse = rayCollisionResponse
gfx.sprite.update()


end

