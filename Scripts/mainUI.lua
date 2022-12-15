local pd <const> = playdate
local gfx <const> = pd.graphics

import 'libraries/AnimatedSprite.lua'

function mainUI()

-- Pone los elementos basicos de la UI 

-- BACKGROUND IMAGE 

backgroundImage = gfx.image.new("/images8bit/UI/background.png")
backgroundSprite = gfx.sprite.new(backgroundImage)

-- Impide que el scroll afecte a los sprites de la UI

--backgroundSprite: setIgnoresDrawOffset(true)
backgroundSprite: setCenter(0,0)
backgroundSprite: moveTo(-100,-150)
backgroundSprite: setZIndex(2)
backgroundSprite: add()



-- SUN

sunTable = playdate.graphics.imagetable.new("/images8bit/UI/whitesun-table-31-31.png")
sunUISprite = AnimatedSprite.new(sunTable) -- Creating AnimatedSprite instance

sunUISprite: addState("rising", 1, 4, {tickStep = 12, nextAnimation="idle"})
sunUISprite: addState("idle", 3, 4, {tickStep = 12})
sunUISprite: addState("shining", 5, 8, {tickStep = 6})
--sunUISprite: setIgnoresDrawOffset(true)
sunUISprite: setCenter(0,0)
sunUISprite: moveTo(220,70)
sunUISprite: setZIndex(0)
sunUISprite: add()
sunUISprite: changeState("rising")
sunUISprite: playAnimation()



-- TIMER WEATHER INDICATOR 

imagetable = gfx.image.new("/images8bit/UI/timer/1.png")
lifeTimerUISprite = gfx.sprite.new(imagetable)

-- Impide que el scroll afecte a los sprites de la UI

lifeTimerUISprite: setIgnoresDrawOffset(true)
lifeTimerUISprite: setCenter(0,0)
lifeTimerUISprite: moveTo(-200,50)
lifeTimerUISprite: setZIndex(0)
lifeTimerUISprite: add()


-- ROOSTER INDICATOR

imagetable = playdate.graphics.imagetable.new("/images8bit/UI/roosterdoble-table-32-32.png") 
roosterUISprite = AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance

roosterUISprite: addState("turnRight", 1, 8, {tickStep = 8, nextAnimation="turnRight", nextAnimation="idleRight"})
roosterUISprite: addState("turnLeft", 9, 16, {tickStep = 8, nextAnimation="turnLeft", nextAnimation="idleLeft"})
roosterUISprite: addState("turn", 1, 16, {tickStep = 12})
roosterUISprite: addState("idleRight", 1, 1, {tickStep = 10})
roosterUISprite: addState("idleLeft", 9, 9, {tickStep = 10})

-- Impide que el scroll afecte a los sprites de la UI

roosterUISprite: setIgnoresDrawOffset(true)
roosterUISprite: setCenter(0,0)
roosterUISprite: moveTo(15,10)
roosterUISprite: add()
roosterUISprite: setZIndex(0)

roosterUISprite: changeState("idleLeft")
roosterUISprite: playAnimation()



-- ATTITUDE INDICATOR

local uiNewImage = gfx.image.new("/images8bit/UI/attitude.png")
local attitudeUISprite = gfx.sprite.new(uiNewImage)

-- Impide que el scroll afecte a los sprites de la UI

attitudeUISprite: setIgnoresDrawOffset(true)
attitudeUISprite: setCenter(0,0)
attitudeUISprite: moveTo(370,188)
attitudeUISprite: add()
attitudeUISprite: setZIndex(100)


-- ATTITUDE LEVEL MARKER

local uiNewImage = gfx.image.new("/images8bit/UI/levelmarker.png")
local levelmarkerUISprite = gfx.sprite.new(uiNewImage)

-- Impide que el scroll afecte a los sprites de la UI

levelmarkerUISprite: setIgnoresDrawOffset(true)
levelmarkerUISprite: setCenter(0,0)
levelmarkerUISprite: moveTo(392,210)
levelmarkerUISprite: add()
levelmarkerUISprite: setZIndex(100)
levelMarkerY = 210


-- WEATHER INDICATORS 


uiNewImage = playdate.graphics.imagetable.new("/images8bit/UI/weatherindicators-table-28-28.png")

weatherUISprite = AnimatedSprite.new(uiNewImage) -- Creating AnimatedSprite instance

weatherUISprite: addState("windPower", 1, 1, {tickStep = 20})
weatherUISprite: addState("rainPower", 2, 2, {tickStep = 20})
weatherUISprite: addState("granizoPower", 3, 3, {tickStep = 20})
weatherUISprite: addState("snowPower", 4, 4, {tickStep = 20})
weatherUISprite: addState("rayPower", 5, 5, {tickStep = 20})
weatherUISprite: addState("tornadoPower", 6, 6, {tickStep = 20})
weatherUISprite: addState("firePower", 7, 7, {tickStep = 20})
weatherUISprite: addState("floodPower", 8, 8, {tickStep = 20})
weatherUISprite: addState("tsunamiPower", 9, 9, {tickStep = 20})


-- Impide que el scroll afecte a los sprites de la UI

weatherUISprite: setIgnoresDrawOffset(true)
weatherUISprite: setCenter(0,0)
weatherUISprite: moveTo(15,40)
weatherUISprite: changeState("windPower")
weatherUISprite: add()
weatherUISprite: setZIndex(0)


-- ATTACK POWER INDICATOR

imagetable = gfx.image.new("/images8bit/UI/power/5.png")
powerAttackUISprite = gfx.sprite.new(imagetable)

powerAttackUISprite: setIgnoresDrawOffset(true)
powerAttackUISprite: setCenter(0,0)
powerAttackUISprite: moveTo(15,44)
powerAttackUISprite: add()
powerAttackUISprite: setZIndex(0)


-- PRESS A TO START


pressStartImagetable = playdate.graphics.imagetable.new("/images8bit/UI/msgstart-table-200-46.png")
pressStartUISprite = AnimatedSprite.new(pressStartImagetable)

pressStartUISprite : addState("blink", 1, 2, {tickStep = 24})
pressStartUISprite : addState("off", 3, 3, {tickStep = 1})

-- Impide que el scroll afecte a los sprites de la UI

--pressStartUISprite : setIgnoresDrawOffset(true)
pressStartUISprite : setCenter(0,0)
pressStartUISprite : moveTo(600,120)
pressStartUISprite : add()
pressStartUISprite : setZIndex(50)
pressStartUISprite : playAnimation()


-- GAME OVER MESSAGE


gameOverImagetable = playdate.graphics.imagetable.new("/images8bit/UI/msgameover-table-128-64")
gameOverUISprite = AnimatedSprite.new(gameOverImagetable)

gameOverUISprite : addState("blink", 1, 2, {tickStep = 24})
--pressStartUISprite : addState("off", 3, 3, {tickStep = 1})

-- Impide que el scroll afecte a los sprites de la UI

gameOverUISprite : setIgnoresDrawOffset(true)
gameOverUISprite : setCenter(0,0)
gameOverUISprite : changeState("blink")
gameOverUISprite : moveTo(600,120)
gameOverUISprite : add()
gameOverUISprite : setZIndex(50)
gameOverUISprite : playAnimation()



-- POSICIONA LOS TITULOS DEL UI

lineSegmentStartTitle = pd.geometry.lineSegment.new(500, 120, 100, 120)
lineAnimatorStartTitle = gfx.animator.new(30000, lineSegmentStartTitle, pd.easingFunctions.outBounce)


-- POSICIONA LOS TITULOS DEL RE BOOT

lineSegmentRebootTitle = pd.geometry.lineSegment.new(500, 120, 100, 120)
lineAnimatorRebootTitle = gfx.animator.new(30000, lineSegmentStartTitle, pd.easingFunctions.outBounce)


-- FUNCTIONS


function attitudeUIUp(quantityUp)

  --print("Marcad up"..levelMarkerY)

  levelMarkerY =   levelMarkerY - quantityUp
  levelmarkerUISprite:moveTo(392, levelMarkerY)

  
end

function attitudeUIDown(quantityDown)

  --print("Marca down"..levelMarkerY)

  levelMarkerY = levelMarkerY + quantityDown
  
  levelmarkerUISprite: moveTo(392,  levelMarkerY)
  

end



function updateCurrentScore(currentScore)

  
  -- SCORE COUNTER
  
  -- Size of the sprite 'canvas' for the score. The current value of the score is in currentScore Variable
  
    scoreImage = gfx.image.new(100, 40)
  
    gfx.pushContext(scoreImage)
    
    gfx.drawText("Score  "..currentScore, 0, 0)
    
    gfx.popContext()
    
    scoreSprite = gfx.sprite.new(scoreImage)
   
    scoreSprite: setIgnoresDrawOffset(true)
    scoreSprite: setZIndex (100)
    scoreSprite: moveTo(360,30)
    scoreSprite: add()
    scoreSprite: markDirty()
  end



end