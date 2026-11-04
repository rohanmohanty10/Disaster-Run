 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Gamepad
-- Stephen Leitnick
-- December 23, 2021

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)

local UserInputService = game:GetService("UserInputService")
local HapticService = game:GetService("HapticService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function ApplyDeadzone(value: number, threshold: number): number
	if math.abs(value) < threshold then
		return 0
	end
	return ((math.abs(value) - threshold) / (1 - threshold)) * math.sign(value)
end

local function GetActiveGamepad(): Enum.UserInputType?
	local activeGamepad = nil
	local navGamepads = UserInputService:GetNavigationGamepads()
	if #navGamepads > 1 then
		for _, navGamepad in ipairs(navGamepads) do
			if activeGamepad == nil or navGamepad.Value < activeGamepad.Value then
				activeGamepad = navGamepad
			end
		end
	else
		local connectedGamepads = UserInputService:GetConnectedGamepads()
		for _, connectedGamepad in ipairs(connectedGamepads) do
			if activeGamepad == nil or connectedGamepad.Value < activeGamepad.Value then
				activeGamepad = connectedGamepad
			end
		end
	end
	if activeGamepad and not UserInputService:GetGamepadConnected(activeGamepad) then
		activeGamepad = nil
	end
	return activeGamepad
end

local function HeartbeatDelay(duration: number, callback: () -> nil): RBXScriptConnection
	local start = time()
	local connection
	connection = RunService.Heartbeat:Connect(function()
		local elapsed = time() - start
		if elapsed >= duration then
			connection:Disconnect()
			callback()
		end
	end)
	return connection
end

--[=[
	@class Gamepad
	@client

	The Gamepad class is part of the Input package.

	```lua
	local Gamepad = require(packages.Input).Gamepad

	local gamepad = Gamepad.new()
	```
]=]
local Gamepad = {}
Gamepad.__index = Gamepad

--[=[
	@within Gamepad
	@prop ButtonDown Signal<(button: Enum.KeyCode, processed: boolean)>
	@readonly
	The ButtonDown signal fires when a gamepad button is pressed
	down. The pressed KeyCode is passed to the signal, along with
	whether or not the event was processed.

	```lua
	gamepad.ButtonDown:Connect(function(button: Enum.KeyCode, processed: boolean)
		print("Button down", button, processed)
	end)
	```
]=]

--[=[
	@within Gamepad
	@prop ButtonUp Signal<(button: Enum.KeyCode, processed: boolean)>
	@readonly
	The ButtonUp signal fires when a gamepad button is released.
	The released KeyCode is passed to the signal, along with
	whether or not the event was processed.

	```lua
	gamepad.ButtonUp:Connect(function(button: Enum.KeyCode, processed: boolean)
		print("Button up", button, processed)
	end)
	```
]=]

--[=[
	@within Gamepad
	@prop Connected Signal
	@readonly
	Fires when the gamepad is connected. This will _not_ fire if the
	active gamepad is switched. To detect switching to different
	active gamepads, use the `GamepadChanged` signal.

	There is also a `gamepad:IsConnected()` method.

	```lua
	gamepad.Connected:Connect(function()
		print("Connected")
	end)
	```
]=]

--[=[
	@within Gamepad
	@prop Disconnected Signal
	@readonly
	Fires when the gamepad is disconnected. This will _not_ fire if the
	active gamepad is switched. To detect switching to different
	active gamepads, use the `GamepadChanged` signal.

	There is also a `gamepad:IsConnected()` method.

	```lua
	gamepad.Disconnected:Connect(function()
		print("Disconnected")
	end)
	```
]=]

--[=[
	@within Gamepad
	@prop GamepadChanged Signal<gamepad: Enum.UserInputType>
	@readonly
	Fires when the active gamepad switches. Internally, the gamepad
	object will always wrap around the active gamepad, so nothing
	needs to be changed.

	```lua
	gamepad.GamepadChanged:Connect(function(newGamepad: Enum.UserInputType)
		print("Active gamepad changed to:", newGamepad)
	end)
	```
]=]

--[=[
	@within Gamepad
	@prop DefaultDeadzone number

	:::info Default
	Defaults to `0.05`
	:::

	The default deadzone used for trigger and thumbstick
	analog readings. It is usually best to set this to
	a small value, or allow players to set this option
	themselves in an in-game settings menu.

	The `GetThumbstick` and `GetTrigger` methods also allow
	a deadzone value to be passed in, which overrides this
	value.
]=]

--[=[
	@within Gamepad
	@prop SupportsVibration boolean
	@readonly
	Flag to indicate if the currently-active gamepad supports
	haptic motor vibration.

	It is safe to use the motor methods on the gamepad without
	checking this value, but nothing will happen if the motors
	are not supported.
]=]

--[=[
	@within Gamepad
	@prop State GamepadState
	@readonly
	Maps KeyCodes to the matching InputObjects within the gamepad.
	These can be used to directly read the current input state of
	a given part of the gamepad. For most cases, the given methods
	and properties of `Gamepad` should make use of this table quite
	rare, but it is provided for special use-cases that might occur.

	:::note Do Not Cache
	These state objects will change if the active gamepad changes.
	Because a player might switch up gamepads during playtime, it cannot
	be assumed that these state objects will always be the same. Thus
	they should be accessed directly from this `State` table anytime they
	need to be used.
	:::

	```lua
	local leftThumbstick = gamepad.State[Enum.KeyCode.Thumbstick1]
	print(leftThumbstick.Position)
	-- It would be better to use gamepad:GetThumbstick(Enum.KeyCode.Thumbstick1),
	-- but this is just an example of direct state access.
	```
]=]

--[=[
	@within Gamepad
	@type GamepadState {[Enum.KeyCode]: InputObject}
]=]

--[=[
	@param gamepad Enum.UserInputType?
	@return Gamepad
	Constructs a gamepad object.

	If no gamepad UserInputType is provided, this object will always wrap
	around the currently-active gamepad, even if it changes. In most cases
	where input is needed from just the primary gamepad used by the player,
	leaving the `gamepad` argument blank is preferred.

	Only include the `gamepad` argument when it is necessary to hard-lock
	the object to a specific gamepad input type.

	```lua
	-- In most cases, construct the gamepad as such:
	local gamepad = Gamepad.new()

	-- If the exact UserInputType gamepad is needed, pass it as such:
	local gamepad = Gamepad.new(Enum.UserInputType.Gamepad1)
	```
]=]
function Gamepad.new(gamepad: Enum.UserInputType?)
	local self = setmetatable({}, Gamepad)
	self._trove = Trove.new()
	self._gamepadTrove = self._trove:Construct(Trove)
	self.ButtonDown = self._trove:Construct(Signal)
	self.ButtonUp = self._trove:Construct(Signal)
	self.Connected = self._trove:Construct(Signal)
	self.Disconnected = self._trove:Construct(Signal)
	self.GamepadChanged = self._trove:Construct(Signal)
	self.DefaultDeadzone = 0.05
	self.SupportsVibration = false
	self.State = {}
	self:_setupGamepad(gamepad)
	self:_setupMotors()
	return self
end

function Gamepad:_setupActiveGamepad(gamepad: Enum.UserInputType?)
	local lastGamepad = self._gamepad
	if gamepad == lastGamepad then
		return
	end

	self._gamepadTrove:Clean()
	table.clear(self.State)
	self.SupportsVibration = if gamepad then HapticService:IsVibrationSupported(gamepad) else false

	self._gamepad = gamepad

	-- Stop if disconnected:
	if not gamepad then
		self.Disconnected:Fire()
		self.GamepadChanged:Fire(nil)
		return
	end

	for _, inputObject in ipairs(UserInputService:GetGamepadState(gamepad)) do
		self.State[inputObject.KeyCode] = inputObject
	end

	self._gamepadTrove:Add(self, "StopMotors")

	self._gamepadTrove:Connect(UserInputService.InputBegan, function(input, processed)
		if input.UserInputType == gamepad then
			self.ButtonDown:Fire(input.KeyCode, processed)
		end
	end)

	self._gamepadTrove:Connect(UserInputService.InputEnded, function(input, processed)
		if input.UserInputType == gamepad then
			self.ButtonUp:Fire(input.KeyCode, processed)
		end
	end)

	if lastGamepad == nil then
		self.Connected:Fire()
	end
	self.GamepadChanged:Fire(gamepad)
end

function Gamepad:_setupGamepad(forcedGamepad: Enum.UserInputType?)
	if forcedGamepad then
		-- Forced gamepad:

		self._trove:Connect(UserInputService.GamepadConnected, function(gp)
			if gp == forcedGamepad then
				self:_setupActiveGamepad(forcedGamepad)
			end
		end)

		self._trove:Connect(UserInputService.GamepadDisconnected, function(gp)
			if gp == forcedGamepad then
				self:_setupActiveGamepad(nil)
			end
		end)

		if UserInputService:GetGamepadConnected(forcedGamepad) then
			self:_setupActiveGamepad(forcedGamepad)
		end
	else
		-- Dynamic gamepad:

		local function CheckToSetupActive()
			local active = GetActiveGamepad()
			if active ~= self._gamepad then
				self:_setupActiveGamepad(active)
			end
		end

		self._trove:Connect(UserInputService.GamepadConnected, CheckToSetupActive)
		self._trove:Connect(UserInputService.GamepadDisconnected, CheckToSetupActive)
		self:_setupActiveGamepad(GetActiveGamepad())
	end
end

function Gamepad:_setupMotors()
	self._setMotorIds = {}
	for _, motor in ipairs(Enum.VibrationMotor:GetEnumItems()) do
		self._setMotorIds[motor] = 0
	end
end

--[=[
	@param thumbstick Enum.KeyCode
	@param deadzoneThreshold number?
	@return Vector2
	Gets the position of the given thumbstick. The two thumbstick
	KeyCodes are `Enum.KeyCode.Thumbstick1` and `Enum.KeyCode.Thumbstick2`.

	If `deadzoneThreshold` is not included, the `DefaultDeadzone` value is
	used instead.

	```lua
	local leftThumbstick = gamepad:GetThumbstick(Enum.KeyCode.Thumbstick1)
	print("Left thumbstick position", leftThumbstick)
	```
]=]
function Gamepad:GetThumbstick(thumbstick: Enum.KeyCode, deadzoneThreshold: number?): Vector2
	local pos = self.State[thumbstick].Position
	local deadzone = deadzoneThreshold or self.DefaultDeadzone
	return Vector2.new(ApplyDeadzone(pos.X, deadzone), ApplyDeadzone(pos.Y, deadzone))
end

--[=[
	@param trigger KeyCode
	@param deadzoneThreshold number?
	@return number
	Gets the position of the given trigger. The triggers are usually going
	to be `Enum.KeyCode.ButtonL2` and `Enum.KeyCode.ButtonR2`. These trigger
	buttons are analog, and will output a value between the range of [0, 1].

	If `deadzoneThreshold` is not included, the `DefaultDeadzone` value is
	used instead.

	```lua
	local triggerAmount = gamepad:GetTrigger(Enum.KeyCode.ButtonR2)
	print(triggerAmount)
	```
]=]
function Gamepad:GetTrigger(trigger: Enum.KeyCode, deadzoneThreshold: number?): number
	return ApplyDeadzone(self.State[trigger].Position.Z, deadzoneThreshold or self.DefaultDeadzone)
end

--[=[
	@param gamepadButton KeyCode
	@return boolean
	Returns `true` if the given button is down. This includes
	any button on the gamepad, such as `Enum.KeyCode.ButtonA`,
	`Enum.KeyCode.ButtonL3`, `Enum.KeyCode.DPadUp`, etc.

	```lua
	-- Check if the 'A' button is down:
	if gamepad:IsButtonDown(Enum.KeyCode.ButtonA) then
		print("ButtonA is down")
	end
	```
]=]
function Gamepad:IsButtonDown(gamepadButton: Enum.KeyCode): boolean
	return UserInputService:IsGamepadButtonDown(self._gamepad, gamepadButton)
end

--[=[
	@param motor Enum.VibrationMotor
	@return boolean
	Returns `true` if the given motor is supported.

	```lua
	-- Pulse the trigger (e.g. shooting a weapon), but fall back to
	-- the large motor if not supported:
	local motor = Enum.VibrationMotor.Large
	if gamepad:IsMotorSupported(Enum.VibrationMotor.RightTrigger) then
		motor = Enum.VibrationMotor.RightTrigger
	end
	gamepad:PulseMotor(motor, 1, 0.1)
	```
]=]
function Gamepad:IsMotorSupported(motor: Enum.VibrationMotor): boolean
	return HapticService:IsMotorSupported(self._gamepad, motor)
end

--[=[
	@param motor Enum.VibrationMotor
	@param intensity number
	Sets the gamepad's haptic motor to a certain intensity. The
	intensity value is a number in the range of [0, 1].

	```lua
	gamepad:SetMotor(Enum.VibrationMotor.Large, 0.5)
	```
]=]
function Gamepad:SetMotor(motor: Enum.VibrationMotor, intensity: number): number
	self._setMotorIds[motor] += 1
	local id = self._setMotorIds[motor]
	HapticService:SetMotor(self._gamepad, motor, intensity)
	return id
end

--[=[
	@param motor Enum.VibrationMotor
	@param intensity number
	@param duration number
	Sets the gamepad's haptic motor to a certain intensity for a given
	period of time. The motor will stop vibrating after the given
	`duration` has elapsed.

	Calling any motor setter methods (e.g. `SetMotor`, `PulseMotor`,
	`StopMotor`) _after_ calling this method will override the pulse.
	For instance, if `PulseMotor` is called, and then `SetMotor` is
	called right afterwards, `SetMotor` will take precedent.

	```lua
	-- Pulse the large motor for 0.2 seconds with an intensity of 90%:
	gamepad:PulseMotor(Enum.VibrationMotor.Large, 0.9, 0.2)

	-- Example of PulseMotor being overridden:
	gamepad:PulseMotor(Enum.VibrationMotor.Large, 1, 3)
	task.wait(0.1)
	gamepad:SetMotor(Enum.VibrationMotor.Large, 0.5)
	-- Now the pulse won't shut off the motor after 3 seconds,
	-- because SetMotor was called, which cancels the pulse.
	```
]=]
function Gamepad:PulseMotor(motor: Enum.VibrationMotor, intensity: number, duration: number)
	local id = self:SetMotor(motor, intensity)
	local heartbeat = HeartbeatDelay(duration, function()
		if self._setMotorIds[motor] ~= id then
			return
		end
		self:StopMotor(motor)
	end)
	self._gamepadTrove:Add(heartbeat)
end

--[=[
	@param motor Enum.VibrationMotor
	Stops the given motor. This is equivalent to calling
	`gamepad:SetMotor(motor, 0)`.

	```lua
	gamepad:SetMotor(Enum.VibrationMotor.Large, 1)
	task.wait(0.1)
	gamepad:StopMotor(Enum.VibrationMotor.Large)
	```
]=]
function Gamepad:StopMotor(motor: Enum.VibrationMotor)
	self:SetMotor(motor, 0)
end

--[=[
	Stops all motors on the gamepad.

	```lua
	gamepad:SetMotor(Enum.VibrationMotor.Large, 1)
	gamepad:SetMotor(Enum.VibrationMotor.Small, 1)
	task.wait(0.1)
	gamepad:StopMotors()
	```
]=]
function Gamepad:StopMotors()
	for _, motor in ipairs(Enum.VibrationMotor:GetEnumItems()) do
		if self:IsMotorSupported(motor) then
			self:StopMotor(motor)
		end
	end
end

--[=[
	@return boolean
	Returns `true` if the gamepad is currently connected.
]=]
function Gamepad:IsConnected(): boolean
	return if self._gamepad then UserInputService:GetGamepadConnected(self._gamepad) else false
end

--[=[
	@return Enum.UserInputType?
	Gets the current gamepad UserInputType that the gamepad object
	is using. This will be `nil` if there is no connected gamepad.
]=]
function Gamepad:GetUserInputType(): Enum.UserInputType?
	return self._gamepad
end

--[=[
	@param enabled boolean
	Sets the [`GuiService.AutoSelectGuiEnabled`](https://developer.roblox.com/en-us/api-reference/property/GuiService/AutoSelectGuiEnabled)
	property.

	This sets whether or not the Select button on a gamepad will try to auto-select
	a GUI object on screen. This does _not_ turn on/off GUI gamepad navigation,
	but just the initial selection using the Select button.

	For UX purposes, it usually is preferred to set this to `false` and then
	manually set the [`GuiService.SelectedObject`](https://developer.roblox.com/en-us/api-reference/property/GuiService/SelectedObject)
	property within code to set the selected object for gamepads.

	```lua
	gamepad:SetAutoSelectGui(false)
	game:GetService("GuiService").SelectedObject = someGuiObject
	```
]=]
function Gamepad:SetAutoSelectGui(enabled: boolean)
	GuiService.AutoSelectGuiEnabled = enabled
end

--[=[
	@return boolean
	Returns the [`GuiService.AutoSelectGuiEnabled`](https://developer.roblox.com/en-us/api-reference/property/GuiService/AutoSelectGuiEnabled)
	property.
]=]
function Gamepad:IsAutoSelectGuiEnabled(): boolean
	return GuiService.AutoSelectGuiEnabled
end

--[=[
	Destroys the gamepad object.
]=]
function Gamepad:Destroy()
	self._trove:Destroy()
end

return Gamepad

]==]

 

local Trove = require(script.Parent.Parent.Trove);
local Signal = require(script.Parent.Parent.Signal);
local UserInputService = game:GetService("UserInputService");
local HapticService = game:GetService("HapticService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");

local function ApplyDeadzone(p1: number, p2: number) -- Line: 13
    return math.abs(p1) < p2 and 0 or (math.abs(p1) - p2) / (1 - p2) * math.sign(p1);
end;

local function GetActiveGamepad() -- Line: 20
    -- upvalues: UserInputService (copy)
    local v3 = nil;
    local NavigationGamepads = UserInputService:GetNavigationGamepads();

    if #NavigationGamepads > 1 then
        for _, v in ipairs(NavigationGamepads) do
            if v3 == nil or v.Value < v3.Value then
                v3 = v;
            end;
        end;
    else
        local ConnectedGamepads = UserInputService:GetConnectedGamepads();

        for _, v in ipairs(ConnectedGamepads) do
            if v3 == nil or v.Value < v3.Value then
                v3 = v;
            end;
        end;
    end;

    if v3 and not UserInputService:GetGamepadConnected(v3) then
        v3 = nil;
    end;

    return v3;
end;

local function HeartbeatDelay(u4: number, u5: function) -- Line: 43
    -- upvalues: RunService (copy)
    local u6 = time();
    local u7 = nil;
    u7 = RunService.Heartbeat:Connect(function() -- Line: 46
        -- upvalues: u6 (copy), u4 (copy), u7 (ref), u5 (copy)
        if u4 <= time() - u6 then
            u7:Disconnect();
            u5();
        end;
    end);

    return u7;
end;

local u8 = {};
u8.__index = u8;

function u8.new(p9) -- Line: 232
    -- upvalues: u8 (copy), Trove (copy), Signal (copy)
    local v10 = setmetatable({}, u8);
    v10._trove = Trove.new();
    v10._gamepadTrove = v10._trove:Construct(Trove);
    v10.ButtonDown = v10._trove:Construct(Signal);
    v10.ButtonUp = v10._trove:Construct(Signal);
    v10.Connected = v10._trove:Construct(Signal);
    v10.Disconnected = v10._trove:Construct(Signal);
    v10.GamepadChanged = v10._trove:Construct(Signal);
    v10.DefaultDeadzone = 0.05;
    v10.SupportsVibration = false;
    v10.State = {};
    v10:_setupGamepad(p9);
    v10:_setupMotors();

    return v10;
end;

function u8._setupActiveGamepad(u11, u12) -- Line: 249
    -- upvalues: HapticService (copy), UserInputService (copy)
    local _gamepad = u11._gamepad;

    if u12 == _gamepad then
        return;
    end;

    u11._gamepadTrove:Clean();
    table.clear(u11.State);
    local v13;

    if u12 then
        v13 = HapticService:IsVibrationSupported(u12);
    else
        v13 = false;
    end;

    u11.SupportsVibration = v13;
    u11._gamepad = u12;

    if not u12 then
        u11.Disconnected:Fire();
        u11.GamepadChanged:Fire(nil);

        return;
    end;

    for _, v in ipairs(UserInputService:GetGamepadState(u12)) do
        u11.State[v.KeyCode] = v;
    end;

    u11._gamepadTrove:Add(u11, "StopMotors");
    u11._gamepadTrove:Connect(UserInputService.InputBegan, function(p14, p15) -- Line: 274
        -- upvalues: u12 (copy), u11 (copy)
        if p14.UserInputType == u12 then
            u11.ButtonDown:Fire(p14.KeyCode, p15);
        end;
    end);
    u11._gamepadTrove:Connect(UserInputService.InputEnded, function(p16, p17) -- Line: 280
        -- upvalues: u12 (copy), u11 (copy)
        if p16.UserInputType == u12 then
            u11.ButtonUp:Fire(p16.KeyCode, p17);
        end;
    end);

    if _gamepad == nil then
        u11.Connected:Fire();
    end;

    u11.GamepadChanged:Fire(u12);
end;

function u8._setupGamepad(u18, u19) -- Line: 292
    -- upvalues: UserInputService (copy), GetActiveGamepad (copy)
    if u19 then
        u18._trove:Connect(UserInputService.GamepadConnected, function(p20) -- Line: 296
            -- upvalues: u19 (copy), u18 (copy)
            if p20 == u19 then
                u18:_setupActiveGamepad(u19);
            end;
        end);
        u18._trove:Connect(UserInputService.GamepadDisconnected, function(p21) -- Line: 302
            -- upvalues: u19 (copy), u18 (copy)
            if p21 == u19 then
                u18:_setupActiveGamepad(nil);
            end;
        end);

        if UserInputService:GetGamepadConnected(u19) then
            u18:_setupActiveGamepad(u19);
        end;
    else
        local function CheckToSetupActive() -- Line: 314
            -- upvalues: GetActiveGamepad (ref), u18 (copy)
            local v22 = GetActiveGamepad();

            if v22 ~= u18._gamepad then
                u18:_setupActiveGamepad(v22);
            end;
        end;

        u18._trove:Connect(UserInputService.GamepadConnected, CheckToSetupActive);
        u18._trove:Connect(UserInputService.GamepadDisconnected, CheckToSetupActive);
        u18:_setupActiveGamepad((GetActiveGamepad()));
    end;
end;

function u8._setupMotors(p23) -- Line: 327
    p23._setMotorIds = {};

    for _, v in ipairs(Enum.VibrationMotor:GetEnumItems()) do
        p23._setMotorIds[v] = 0;
    end;
end;

function u8.GetThumbstick(p24: table, p25: any, p26: number?) -- Line: 349
    local Position = p24.State[p25].Position;
    local v27 = p26 or p24.DefaultDeadzone;
    local Vector2_new = Vector2.new;
    local X = Position.X;
    local v28 = math.abs(X) < v27 and 0 or (math.abs(X) - v27) / (1 - v27) * math.sign(X);
    local Y = Position.Y;

    return Vector2_new(v28, math.abs(Y) < v27 and 0 or (math.abs(Y) - v27) / (1 - v27) * math.sign(Y));
end;

function u8.GetTrigger(p29: table, p30: any, p31: number?) -- Line: 371
    local Z = p29.State[p30].Position.Z;
    local v32 = p31 or p29.DefaultDeadzone;

    return math.abs(Z) < v32 and 0 or (math.abs(Z) - v32) / (1 - v32) * math.sign(Z);
end;

function u8.IsButtonDown(p33, p34) -- Line: 389
    -- upvalues: UserInputService (copy)
    return UserInputService:IsGamepadButtonDown(p33._gamepad, p34);
end;

function u8.IsMotorSupported(p35, p36) -- Line: 408
    -- upvalues: HapticService (copy)
    return HapticService:IsMotorSupported(p35._gamepad, p36);
end;

function u8.SetMotor(p37: table, p38: any, p39: number) -- Line: 422
    -- upvalues: HapticService (copy)
    local _setMotorIds = p37._setMotorIds;
    _setMotorIds[p38] = _setMotorIds[p38] + 1;
    local v40 = p37._setMotorIds[p38];
    HapticService:SetMotor(p37._gamepad, p38, p39);

    return v40;
end;

function u8.PulseMotor(u41: table, u42: any, p43: number, u44: number) -- Line: 454
    -- upvalues: RunService (copy)
    local u45 = u41:SetMotor(u42, p43);

    local function u46() -- Line: 456
        -- upvalues: u41 (copy), u42 (copy), u45 (copy)
        if u41._setMotorIds[u42] ~= u45 then
            return;
        end;

        u41:StopMotor(u42);
    end;

    local u47 = time();
    local u48 = nil;
    u48 = RunService.Heartbeat:Connect(function() -- Line: 46
        -- upvalues: u47 (copy), u44 (copy), u48 (ref), u46 (copy)
        if u44 <= time() - u47 then
            u48:Disconnect();
            u46();
        end;
    end);
    u41._gamepadTrove:Add(u48);
end;

function u8.StopMotor(p49, p50) -- Line: 476
    p49:SetMotor(p50, 0);
end;

function u8.StopMotors(p51) -- Line: 490
    for _, v in ipairs(Enum.VibrationMotor:GetEnumItems()) do
        if p51:IsMotorSupported(v) then
            p51:StopMotor(v);
        end;
    end;
end;

function u8.IsConnected(p52) -- Line: 502
    -- upvalues: UserInputService (copy)
    if p52._gamepad then
        return UserInputService:GetGamepadConnected(p52._gamepad);
    end;

    return false;
end;

function u8.GetUserInputType(p53) -- Line: 511
    return p53._gamepad;
end;

function u8.SetAutoSelectGui(p54: table, p55: boolean) -- Line: 533
    -- upvalues: GuiService (copy)
    GuiService.AutoSelectGuiEnabled = p55;
end;

function u8.IsAutoSelectGuiEnabled(p56) -- Line: 542
    -- upvalues: GuiService (copy)
    return GuiService.AutoSelectGuiEnabled;
end;

function u8.Destroy(p57) -- Line: 549
    p57._trove:Destroy();
end;

return u8;