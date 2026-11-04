 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Keyboard
-- Stephen Leitnick
-- October 10, 2021

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)

local UserInputService = game:GetService("UserInputService")

--[=[
	@class Keyboard
	@client

	The Keyboard class is part of the Input package.

	```lua
	local Keyboard = require(packages.Input).Keyboard
	```
]=]
local Keyboard = {}
Keyboard.__index = Keyboard

--[=[
	@within Keyboard
	@prop KeyDown Signal<Enum.KeyCode>
	@tag Event
	Fired when a key is pressed.
	```lua
	keyboard.KeyDown:Connect(function(key: KeyCode)
		print("Key pressed", key)
	end)
	```
]=]
--[=[
	@within Keyboard
	@prop KeyUp Signal<Enum.KeyCode>
	@tag Event
	Fired when a key is released.
	```lua
	keyboard.KeyUp:Connect(function(key: KeyCode)
		print("Key released", key)
	end)
	```
]=]

--[=[
	@return Keyboard

	Constructs a new keyboard input capturer.

	```lua
	local keyboard = Keyboard.new()
	```
]=]
function Keyboard.new()
	local self = setmetatable({}, Keyboard)
	self._trove = Trove.new()
	self.KeyDown = self._trove:Construct(Signal)
	self.KeyUp = self._trove:Construct(Signal)
	self:_setup()
	return self
end

--[=[
	Check if the given key is down.

	```lua
	local w = keyboard:IsKeyDown(Enum.KeyCode.W)
	if w then ... end
	```
]=]
function Keyboard:IsKeyDown(keyCode: Enum.KeyCode): boolean
	return UserInputService:IsKeyDown(keyCode)
end

--[=[
	Check if _both_ keys are down. Useful for key combinations.

	```lua
	local shiftA = keyboard:AreKeysDown(Enum.KeyCode.LeftShift, Enum.KeyCode.A)
	if shiftA then ... end
	```
]=]
function Keyboard:AreKeysDown(keyCodeOne: Enum.KeyCode, keyCodeTwo: Enum.KeyCode): boolean
	return self:IsKeyDown(keyCodeOne) and self:IsKeyDown(keyCodeTwo)
end

--[=[
	Check if _either_ of the keys are down. Useful when two keys might perform
	the same operation.

	```lua
	local wOrUp = keyboard:AreEitherKeysDown(Enum.KeyCode.W, Enum.KeyCode.Up)
	if wOrUp then
		-- Go forward
	end
	```
]=]
function Keyboard:AreEitherKeysDown(keyCodeOne: Enum.KeyCode, keyCodeTwo: Enum.KeyCode): boolean
	return self:IsKeyDown(keyCodeOne) or self:IsKeyDown(keyCodeTwo)
end

function Keyboard:_setup()
	self._trove:Connect(UserInputService.InputBegan, function(input, processed)
		if processed then
			return
		end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			self.KeyDown:Fire(input.KeyCode)
		end
	end)

	self._trove:Connect(UserInputService.InputEnded, function(input, processed)
		if processed then
			return
		end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			self.KeyUp:Fire(input.KeyCode)
		end
	end)
end

--[=[
	Destroy the keyboard input capturer.
]=]
function Keyboard:Destroy()
	self._trove:Destroy()
end

return Keyboard

]==]

 

local Trove = require(script.Parent.Parent.Trove);
local Signal = require(script.Parent.Parent.Signal);
local UserInputService = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 55
    -- upvalues: u1 (copy), Trove (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2._trove = Trove.new();
    v2.KeyDown = v2._trove:Construct(Signal);
    v2.KeyUp = v2._trove:Construct(Signal);
    v2:_setup();

    return v2;
end;

function u1.IsKeyDown(p3, p4) -- Line: 72
    -- upvalues: UserInputService (copy)
    return UserInputService:IsKeyDown(p4);
end;

function u1.AreKeysDown(p5, p6, p7) -- Line: 84
    local v8 = p5:IsKeyDown(p6) and p5:IsKeyDown(p7);

    return v8;
end;

function u1.AreEitherKeysDown(p9, p10, p11) -- Line: 99
    return p9:IsKeyDown(p10) or p9:IsKeyDown(p11);
end;

function u1._setup(u12) -- Line: 103
    -- upvalues: UserInputService (copy)
    u12._trove:Connect(UserInputService.InputBegan, function(p13, p14) -- Line: 104
        -- upvalues: u12 (copy)
        if p14 then
            return;
        end;

        if p13.UserInputType == Enum.UserInputType.Keyboard then
            u12.KeyDown:Fire(p13.KeyCode);
        end;
    end);
    u12._trove:Connect(UserInputService.InputEnded, function(p15, p16) -- Line: 113
        -- upvalues: u12 (copy)
        if p16 then
            return;
        end;

        if p15.UserInputType == Enum.UserInputType.Keyboard then
            u12.KeyUp:Fire(p15.KeyCode);
        end;
    end);
end;

function u1.Destroy(p17) -- Line: 126
    p17._trove:Destroy();
end;

return u1;