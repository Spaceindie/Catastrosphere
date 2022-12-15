local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
import "scripts/flyingScore"

class('rain').extends(AnimatedSprite)

rainAlcanceTiro = 0
rainHitBuilding = false
rainHitPlane = false
rainHitCar = false
rainHitCounter = 1

rainHitTime = true

function rain:init(rainxDirection, rainyDirection, rainSpeed, rainDamage)

-- crea imagen del rayo 

    rainSpriteSheet = gfx.imagetable.new("/images8bit/weapons/rain-table-32-64")

    rain.super.init(self, rainSpriteSheet)

    self: addState("raining", 1, 10, {tickStep = 4})

    self: setCenter(0,0)

    self: setCollideRect(0, 0, 16, 24)

    self: setZIndex(110)

    self.speed = rainSpeed

    self.type = "rain"

    self: changeState("raining")

    self:playAnimation()

   -- Se posiciona el objeto a disparar

      self.xPosition = rainxDirection

      self.yPosition = rainyDirection

      self.objectSpeed = rainSpeed


      self: moveWithCollisions(self.xPosition  , self.yPosition)


    -- Pone el objeto en la pantalla cerca del player compensando el Scroll X e Y

    --self:moveTo(xDirection - posXScroll , yDirection - posYScroll)

   -- self:moveTo(xDirection , yDirection )
   -- print ("Posicion rayo X "..xDirection)
   -- print ("Posicion rayo Y "..yDirection)

    self:add()
  

-----------------------------------------
-- COLLISION DETECTION
-----------------------------------------


function rainCollisionResponse( self, other)

  --print (other.type)

-- HITTING THE BUILDINGS

 if (other.type =="smallbuilding") then
  
  return gfx.sprite.kCollisionTypeOverlap

  end -- del Smallbuilding


-- HITTING THE LARGE BUILDINGS

if (other.type =="largebuilding") then

return gfx.sprite.kCollisionTypeOverlap

end -- del largebuilding


-- HITTING THE TREES

if (other.type =="tree") then

 return gfx.sprite.kCollisionTypeOverlap

end -- del hit tree


-- HITTING GUYS

if (other.type =="man") and (rainHitTime) then

  -- makes the ray sprite invisible when hit the character

self:setVisible(false)

for i= 1, 2 do 

 if other == guySprite[i] then guyVictim = i end
 
end

if guyVictim == 1 then  character1IsDead = true end
if guyVictim == 2 then  character2IsDead = true end


other: changeState("lying")

hitMan = true
rainHitTime = false

playdate.timer.performAfterDelay(2000, function ()

other: remove()
end)


 return gfx.sprite.kCollisionTypeOverlap

end -- del hit MAN


-- HITTING WOMAN

if (other.type =="woman")  and (rainHitTime) then

-- makes the ray sprite invisible when hit the character

self:setVisible(false)


for i= 1, 2 do 

if other == guySprite[i] then guyVictim = i end

end

if guyVictim == 1 then  character1IsDead = true end
if guyVictim == 2 then  character2IsDead = true end



hitWoman = true
rainHitTime = false


self:setVisible(false)
characterIsDead = true
other: changeState("lying")

playdate.timer.performAfterDelay(2000, function ()

other: remove()

end)

return gfx.sprite.kCollisionTypeOverlap

end -- del hit WOMAN

-- HITTING CAR

if (other.type =="car")  and (rainHitTime) then

 other:changeState("ruined")

  rainHitCar = true
  rainHitTime = false
  end


-- HITTING PLANE

if (other.type =="plane") then
return gfx.sprite.kCollisionTypeOverlap
end -- del hit PLANE


-- HITTING THE PLAYER

if (other.type =="player")  then

  return gfx.sprite.kCollisionTypeOverlap

end

-- HITTING THE CAR

if (other.type =="car")  then

return gfx.sprite.kCollisionTypeOverlap

end



end -- de la funcion rayCollisionResponse
end -- DEL INIT


-- UPDATE

function rain:update()

    -- Desplaza el objeto arrojable
    -- Deshabilita la posibilidad de disparar varias veces

    rainAttackReady = false
  

    self: moveWithCollisions(self.xPosition  , self.yPosition + alcanceTiro)
   
     rainAlcanceTiro += self.objectSpeed

    -- Destruye el objeto pasado una distancia maxima

    -- Si se ha dado a un edifcio se lo sacude un poquito 


    -- Si se ha dado en edificioDestroyed se suman 10 puntos al score
    -- HIT BUILDING SCORE 

  if (rainAlcanceTiro >= 80) and (hitBuilding) then

      rainAlcanceTiro = 0
      rainAttackReady = true
      rainHitTime = true
      self:remove()
      hitBuilding = false

  end

  -- HIT TREE SCORE 

  if (rainAlcanceTiro >= 80) and (hitTree) then
    
    rainAlcanceTiro = 0
    rainAttackReady = true
    rainHitTime = true
    self:remove()
    rainHitTree= false

end

  -- HIT MAN SCORE 

if (rainAlcanceTiro >= 80) and (hitMan) then
    
  
  scoreBanner = 10
  flyingScore(playerSprite.x, playerSprite.y +10)
  rainAlcanceTiro = 0
  rainAttackReady = true
  score:addTen()
  rainHitTime = true
  self:remove()
  rainHitMan= false

end

if (rainAlcanceTiro >= 80) and (hitWoman) then
    
  --print ("hit WOMAN")
  scoreBanner = 10
  flyingScore(playerSprite.x, playerSprite.y +10)
  rainAlcanceTiro = 0
  rainAttackReady = true
  score:addTen()
  rainHitTime = true
  self:remove()
  rainHitWoman= false
  

end

-- HIT CAR SCORE 

if (rainAlcanceTiro >= 80) and (rainHitCar) then
    

  scoreBanner = 5

  flyingScore(playerSprite.x, playerSprite.y +5)
  rainAlcanceTiro = 0
  rainAttackReady = true
  score:addFive()
  rainHitTime = true
  self:remove()
  rainHitcar= false
  

end



-- HIT PLANE SCORE 

  if (rainAlcanceTiro >= 80) and (hitPlane) then
    
    --print ("hit")
    
    rainAlcanceTiro = 0
    rainAttackReady = true
    rainHitTime = true
    self:remove()
    hitPlane = false

end


-- NO HIT NO SCORE 

  -- Si no hay impacto no hay puntaje 

 if (rainAlcanceTiro >= 80) and (hitBuilding == false) then

      rainAlcanceTiro = 0
      rainAttackReady = true
      self:remove()

  end




self:updateAnimation()
self.yPosition += 1
self.collisionResponse = rainCollisionResponse
gfx.sprite.update()


end

