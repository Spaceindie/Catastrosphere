local pd <const> = playdate
local gfx <const> = pd.graphics

import 'libraries/AnimatedSprite.lua'

function introScreen()

-- Intro Screen and main credits

-- FRAME IMAGE UP




backgroundImage = gfx.image.new("/images8bit/UI/mainScreenUp.png")
mainScreenSpriteUp = gfx.sprite.new(backgroundImage)


mainScreenSpriteUp : setIgnoresDrawOffset(true)
mainScreenSpriteUp : setCenter(0,0)
mainScreenSpriteUp : moveTo(0,0)
mainScreenSpriteUp : setZIndex(200)
mainScreenSpriteUp : add()

-- FRAME IMAGE DOWN

backgroundImage = gfx.image.new("/images8bit/UI/mainScreenDown.png")
mainScreenSpriteDown = gfx.sprite.new(backgroundImage)

mainScreenSpriteDown: setIgnoresDrawOffset(true)
mainScreenSpriteDown: setCenter(0,0)
mainScreenSpriteDown: moveTo(0,225)
mainScreenSpriteDown: setZIndex(200)
mainScreenSpriteDown: add()

--[[
-- CURTAIN

backgroundImage = gfx.image.new("/images8bit/UI/mainScreenCurtain.png")
mainScreenCurtainSprite = gfx.sprite.new(backgroundImage)

--backgroundSprite: setIgnoresDrawOffset(true)
mainScreenCurtainSprite: setCenter(0,0)
mainScreenCurtainSprite: moveTo(0,0)
mainScreenCurtainSprite: setZIndex(0)
mainScreenCurtainSprite: add()

--]]


-- GAME LOGO

logoImage = playdate.graphics.imagetable.new("/images8bit/UI/logo-table-258-32.png")
logoUISprite = AnimatedSprite.new(logoImage) -- Creating AnimatedSprite instance

logoUISprite: addState("blinking", 1, 4, {tickStep = 18})


logoUISprite: setIgnoresDrawOffset(true)
logoUISprite: setCenter(0,0)
logoUISprite: moveTo(80,100)
logoUISprite: setZIndex(201)
logoUISprite: add()
logoUISprite: changeState("blinking")
logoUISprite: playAnimation()



-- THUNDER

thunderImage = playdate.graphics.imagetable.new("/images8bit/UI/rayo-table-86-134.png")
thunderUISprite = AnimatedSprite.new(thunderImage) -- Creating AnimatedSprite instance

thunderUISprite:  addState("hold", 1, 1, {tickStep = 12})
thunderUISprite: addState("charging", 1, 8, {tickStep = 4})

thunderUISprite: setIgnoresDrawOffset(true)
thunderUISprite: setCenter(0,0)
thunderUISprite: moveTo(160,40)
thunderUISprite: setZIndex(202)
thunderUISprite: add()
thunderUISprite: changeState("hold")
thunderUISprite: playAnimation()


-- CREDITS 


creditImagetable = gfx.image.new("/images8bit/UI/credits.png")
creditsUISprite = gfx.sprite.new(creditImagetable)

creditsUISprite : setIgnoresDrawOffset(true)
creditsUISprite : setCenter(0,0)
creditsUISprite : moveTo(10,190)
creditsUISprite : add()
creditsUISprite : setZIndex(200)



end
