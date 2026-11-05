-- MusicService (client) — shuffles & loops ReplicatedStorage.Assets.Sounds.Music
-- Fades, 2s gap between tracks, crossfade on skip, mute-aware pause.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local MusicFolder = ReplicatedStorage.Assets.Sounds.Music
local MusicGroup = SoundService:WaitForChild("Music")

-- Tunables
local FADE_TIME = .5   -- seconds for fade in / fade out
local GAP_TIME  = 2     -- silent pause between tracks (natural transitions)

local MusicService = {}
MusicService.Playlist = {}
MusicService.Index = 0
MusicService.Current = nil
MusicService.Connection = nil
MusicService.Started = false
MusicService.Muted = false
MusicService.State = "stopped"  -- "stopped" | "playing" | "paused" | "gap"
MusicService.Token = 0          -- bumped on every transition to cancel stale tasks

-- Fisher-Yates shuffle
local function shuffle(list)
	for i = #list, 2, -1 do
		local j = math.random(1, i)
		list[i], list[j] = list[j], list[i]
	end
	return list
end

local function buildPlaylist()
	local tracks = {}
	for _, sound in MusicFolder:GetChildren() do
		if sound:IsA("Sound") then
			sound.SoundGroup = MusicGroup
			sound.Looped = false
			-- remember the authored volume so fades return to the right level
			sound:SetAttribute("DefaultVolume", sound:GetAttribute("DefaultVolume") or sound.Volume)
			table.insert(tracks, sound)
		end
	end
	return tracks
end

-- tween a single sound's OWN volume (not the group's, so the slider stays independent)
function MusicService:_fade(sound, target, duration)
	if not sound then return end
	TweenService:Create(sound, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
		Volume = target,
	}):Play()
end

-- wait `duration` seconds of UNMUTED time; returns false if superseded by a newer token
function MusicService:_wait(duration, token)
	local elapsed = 0
	while elapsed < duration do
		if token ~= self.Token then return false end
		local dt = task.wait(0.1)
		if not self.Muted then
			elapsed += dt
		end
	end
	return token == self.Token
end

function MusicService:PlayNext()
	self.Token += 1
	local token = self.Token

	-- advance / reshuffle
	self.Index += 1
	if self.Index > #self.Playlist then
		local justEnded = self.Current
		shuffle(self.Playlist)
		-- avoid immediately replaying the track that just finished
		if #self.Playlist > 1 and self.Playlist[1] == justEnded then
			self.Playlist[1], self.Playlist[2] = self.Playlist[2], self.Playlist[1]
		end
		self.Index = 1
	end

	local track = self.Playlist[self.Index]
	if not track then return end
	self.Current = track
	self.State = "playing"

	local target = track:GetAttribute("DefaultVolume") or 0.5

	-- start silent, fade in
	track.TimePosition = 0
	track.Volume = 0
	track:Play()
	self:_fade(track, target, FADE_TIME)

	-- graceful fade-out over the last FADE_TIME seconds (polls TimePosition, so pause-safe)
	task.spawn(function()
		if track.TimeLength <= 0 then
			track:GetPropertyChangedSignal("TimeLength"):Wait()
		end
		local len = track.TimeLength
		if token ~= self.Token or len <= FADE_TIME then return end
		while token == self.Token and track.Playing do
			if track.TimePosition >= len - FADE_TIME then
				self:_fade(track, 0, FADE_TIME)
				break
			end
			task.wait(0.2)
		end
	end)

	-- when it ends naturally: gap, then next
	if self.Connection then self.Connection:Disconnect() end
	self.Connection = track.Ended:Connect(function()
		if token ~= self.Token then return end
		self.State = "gap"
		task.spawn(function()
			if self:_wait(GAP_TIME, token) then
				self:PlayNext()
			end
		end)
	end)
end

function MusicService:Start()
	if self.Started then return end
	self.Started = true

	self.Playlist = buildPlaylist()
	if #self.Playlist == 0 then
		warn("[MusicService] No sounds found in", MusicFolder:GetFullName())
		return
	end

	-- keep in sync with an existing mute toggle: MusicGroup:SetAttribute("Muted", true/false)
	MusicGroup:GetAttributeChangedSignal("Muted"):Connect(function()
		self:SetMuted(MusicGroup:GetAttribute("Muted") == true)
	end)
	self.Muted = MusicGroup:GetAttribute("Muted") == true

	shuffle(self.Playlist)
	self.Index = 0
	self:PlayNext()
end

-- CROSSFADE on manual skip: old fades out while new fades in (no 2s gap here)
function MusicService:Skip()
	local old = self.Current
	if old then
		self:_fade(old, 0, FADE_TIME)
		task.delay(FADE_TIME, function()
			if self.Current ~= old then old:Stop() end
		end)
	end
	self:PlayNext()
end

function MusicService:SetMuted(muted)
	if self.Muted == muted then return end
	self.Muted = muted

	if muted then
		if self.State == "playing" and self.Current then
			self.Current:Pause()
			self.State = "paused"
		end
		-- if we're in the gap, _wait halts on its own
	else
		if self.State == "paused" and self.Current then
			self.Current:Resume()
			self.State = "playing"
		end
	end
end

function MusicService:Stop()
	self.Token += 1
	if self.Connection then self.Connection:Disconnect() end
	if self.Current then self.Current:Stop() end
	self.Current = nil
	self.State = "stopped"
end

return MusicService