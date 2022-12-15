local pd <const> = playdate
local gfx <const> = pd.graphics

import 'libraries/AnimatedSprite.lua'


function walker()

  walkerCounter +=1
  
  guy1PositionOriginX = isoMap [ startingFreeTileX ] [ startingFreeTileY ].x
  guy1PositionOriginY = isoMap [ startingFreeTileX ] [ startingFreeTileY ].y
 
  guySprite [1]: moveTo(guy1PositionOriginX, guy1PositionOriginY)
 
   lineSegmentGo = pd.geometry.lineSegment.new(guy1PositionOriginX, guy1PositionOriginY , destinationPathX  , destinationPathY)
   lineAnimatorGo = gfx.animator.new(walkSpeed, lineSegmentGo)
 
   -- Once the path is calculated the characters can move around 
 
   characterIsWalking = true

end

