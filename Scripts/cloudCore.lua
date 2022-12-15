local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
import "scripts/flyingScore"

class('cloudCore').extends(AnimatedSprite)


function cloudCore:init( playerCorePositionX,  playerCorePositionY)

-- crea imagen del rayo 

    coreSpriteSheet = gfx.imagetable.new("/images8bit/player/cloudCore-table-18-14")

    cloudCore.super.init(self, coreSpriteSheet)

    self: addState("pumping", 1, 2, {tickStep = 24})

    self: setCenter(0,0)

    self: setCollideRect(0, 0, 12, 12)

    self: setIgnoresDrawOffset(true)

    self: setZIndex(110)

    self.type = "cloudCore"

    self: changeState("pumping")

    self: setCollisionsEnabled(true)
    
    --self: moveWithCollisions(200, 25) -- move to Limbo position

    self: playAnimation()

    self:add()
   
 

-----------------------------------------
-- COLLISION DETECTION
-----------------------------------------


function cloudCoreCollisionResponse( self, other)

    if (other.type =="smallbuilding") then print ("EDIFICIO")

    return gfx.sprite.kCollisionTypeOverlap
  
    end


 if (other.type =="man") then print ("MAN")
    
        return gfx.sprite.kCollisionTypeOverlap
      
        end


  if (other.type =="woman") then print ("MAN")
        
            return gfx.sprite.kCollisionTypeOverlap
          
            end

            
 if (other.type =="car") then print ("MAN")
        
                return gfx.sprite.kCollisionTypeOverlap
              
                end

                

end

end


-- UPDATE


    function cloudCore:update()
    
    self:updateAnimation()
    self.collisionResponse = cloudCoreCollisionResponse
    self:moveWithCollisions(playerSprite.x, playerSprite.y)
    gfx.sprite.update()

    
end

