
local snd = playdate.sound

soundIntro = playdate.sound.fileplayer.new( "/sound/intro" )

--[[
SoundManager = {}

SoundManager.kSoundLevelintro = 'levelintro'
SoundManager.kSoundBump= 'bump'
SoundManager.kSoundScore = 'score'
SoundManager.kSoundDead = 'death'
SoundManager.kSoundStomp = 'stomp'
SoundManager.kSoundJet = 'jet'

local sounds = {}

for _, v in pairs(SoundManager) do
	sounds[v] = snd.sampleplayer.new('sound/' .. v)
end

SoundManager.sounds = sounds

function SoundManager:playSound(name)
	self.sounds[name]:play(1)
end


function SoundManager:stopSound(name)
	self.sounds[name]:stop()
end


--]]