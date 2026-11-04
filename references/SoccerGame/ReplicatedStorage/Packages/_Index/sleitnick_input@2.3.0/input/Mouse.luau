 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Mouse
-- Stephen Leitnick
-- November 07, 2020

local Signal = require(script.Parent.Parent.Signal)
local Trove = require(script.Parent.Parent.Trove)

local UserInputService = game:GetService("UserInputService")

local RAY_DISTANCE = 1000

--[=[
	@class Mouse
	@client

	The Mouse class is part of the Input package.

	```lua
	local Mouse = require(packages.Input).Mouse
	```
]=]
local Mouse = {}
Mouse.__index = Mouse

--[=[
	@within Mouse
	@prop LeftDown Signal
	@tag Event
]=]
--[=[
	@within Mouse
	@prop LeftUp Signal
	@tag Event
]=]
--[=[
	@within Mouse
	@prop RightDown Signal
	@tag Event
]=]
--[=[
	@within Mouse
	@prop RightUp Signal
	@tag Event
]=]
--[=[
	@within Mouse
	@prop MiddleDown Signal
	@tag Event
]=]
--[=[
	@within Mouse
	@prop MiddleUp Signal
	@tag Event
]=]
--[=[
	@within Mouse
	@prop Moved Signal<Vector2>
	@tag Event
	```lua
	mouse.Moved:Connect(function(position) ... end)
	```
]=]
--[=[
	@within Mouse
	@prop Scrolled Signal<number>
	@tag Event
	```lua
	mouse.Scrolled:Connect(function(scrollAmount) ... end)
	```
]=]

--[=[
	@return Mouse

	Constructs a new mouse input capturer.

	```lua
	local mouse = Mouse.new()
	```
]=]
function Mouse.new()
	local self = setmetatable({}, Mouse)

	self._trove = Trove.new()

	self.LeftDown = self._trove:Construct(Signal)
	self.LeftUp = self._trove:Construct(Signal)
	self.RightDown = self._trove:Construct(Signal)
	self.RightUp = self._trove:Construct(Signal)
	self.MiddleDown = self._trove:Construct(Signal)
	self.MiddleUp = self._trove:Construct(Signal)
	self.Scrolled = self._trove:Construct(Signal)
	self.Moved = self._trove:Construct(Signal)

	self._trove:Connect(UserInputService.InputBegan, function(input, processed)
		if processed then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self.LeftDown:Fire()
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			self.RightDown:Fire()
		elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
			self.MiddleDown:Fire()
		end
	end)

	self._trove:Connect(UserInputService.InputEnded, function(input, processed)
		if processed then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self.LeftUp:Fire()
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			self.RightUp:Fire()
		elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
			self.MiddleUp:Fire()
		end
	end)

	self._trove:Connect(UserInputService.InputChanged, function(input, processed)
		if processed then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			local position = input.Position
			self.Moved:Fire(Vector2.new(position.X, position.Y))
		elseif input.UserInputType == Enum.UserInputType.MouseWheel then
			self.Scrolled:Fire(input.Position.Z)
		end
	end)

	return self
end

--[=[
	Checks if the left mouse button is down.
]=]
function Mouse:IsLeftDown(): boolean
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end

--[=[
	Checks if the right mouse button is down.
]=]
function Mouse:IsRightDown(): boolean
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end

--[=[
	Checks if the middle mouse button is down.
]=]
function Mouse:IsMiddleDown(): boolean
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)
end

--[=[
	Gets the screen position of the mouse.
]=]
function Mouse:GetPosition(): Vector2
	return UserInputService:GetMouseLocation()
end

--[=[
	Gets the delta screen position of the mouse. In other words, the
	distance the mouse has traveled away from its locked position in
	a given frame (see note about mouse locking below).

	:::info Only When Mouse Locked
	Getting the mouse delta is only intended for when the mouse is locked. If the
	mouse is _not_ locked, this will return a zero Vector2. The mouse can be locked
	using the `mouse:Lock()` and `mouse:LockCenter()` method.
]=]
function Mouse:GetDelta(): Vector2
	return UserInputService:GetMouseDelta()
end

--[=[
	Returns the viewport point ray for the mouse at the current mouse
	position (or the override position if provided).
]=]
function Mouse:GetRay(overridePos: Vector2?): Ray
	local mousePos = overridePos or UserInputService:GetMouseLocation()
	local viewportMouseRay = workspace.CurrentCamera:ViewportPointToRay(mousePos.X, mousePos.Y)
	return viewportMouseRay
end

--[=[
	Performs a raycast operation out from the mouse position (or the
	`overridePos` if provided) into world space. The ray will go
	`distance` studs forward (or 1000 studs if not provided).

	Returns the `RaycastResult` if something was hit, else returns `nil`.

	Use `Raycast` if it is important to capture any objects that could be
	hit along the projected ray. If objects can be ignored and only the
	final position of the ray is needed, use `Project` instead.

	```lua
	local params = RaycastParams.new()
	local result = mouse:Raycast(params)
	if result then
		print(result.Instance)
	else
		print("Mouse raycast did not hit anything")
	end
	```
]=]
function Mouse:Raycast(raycastParams: RaycastParams, distance: number?, overridePos: Vector2?): RaycastResult?
	local viewportMouseRay = self:GetRay(overridePos)
	local result = workspace:Raycast(
		viewportMouseRay.Origin,
		viewportMouseRay.Direction * (distance or RAY_DISTANCE),
		raycastParams
	)
	return result
end

--[=[
	Gets the 3D world position of the mouse when projected forward. This would be the
	end-position of a raycast if nothing was hit. Similar to `Raycast`, optional
	`distance` and `overridePos` arguments are allowed.
	
	Use `Project` if you want to get the 3D world position of the mouse at a given
	distance but don't care about any objects that could be in the way. It is much
	faster to project a position into 3D space than to do a full raycast operation.

	```lua
	local params = RaycastParams.new()
	local distance = 200

	local result = mouse:Raycast(params, distance)
	if result then
		-- Do something with result
	else
		-- Raycast failed, but still get the world position of the mouse:
		local worldPosition = mouse:Project(distance)
	end
	```
]=]
function Mouse:Project(distance: number?, overridePos: Vector2?): Vector3
	local viewportMouseRay = self:GetRay(overridePos)
	return viewportMouseRay.Origin + (viewportMouseRay.Direction.Unit * (distance or RAY_DISTANCE))
end

--[=[
	Locks the mouse in its current position on screen. Call `mouse:Unlock()`
	to unlock the mouse.

	:::caution Must explicitly unlock
	Be sure to explicitly call `mouse:Unlock()` before cleaning up the mouse.
	The `Destroy` method does _not_ unlock the mouse since there is no way
	to guarantee who "owns" the mouse lock.
]=]
function Mouse:Lock()
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
end

--[=[
	Locks the mouse in the center of the screen. Call `mouse:Unlock()`
	to unlock the mouse.

	:::caution Must explicitly unlock
	See cautionary in `Lock` method above.
]=]
function Mouse:LockCenter()
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

--[=[
	Unlocks the mouse.
]=]
function Mouse:Unlock()
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

--[=[
	Destroys the mouse.
]=]
function Mouse:Destroy()
	self._trove:Destroy()
end

return Mouse

]==]

 

local Signal = require(script.Parent.Parent.Signal);
local Trove = require(script.Parent.Parent.Trove);
local UserInputService = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 81
    -- upvalues: u1 (copy), Trove (copy), Signal (copy), UserInputService (copy)
    local u2 = setmetatable({}, u1);
    u2._trove = Trove.new();
    u2.LeftDown = u2._trove:Construct(Signal);
    u2.LeftUp = u2._trove:Construct(Signal);
    u2.RightDown = u2._trove:Construct(Signal);
    u2.RightUp = u2._trove:Construct(Signal);
    u2.MiddleDown = u2._trove:Construct(Signal);
    u2.MiddleUp = u2._trove:Construct(Signal);
    u2.Scrolled = u2._trove:Construct(Signal);
    u2.Moved = u2._trove:Construct(Signal);
    u2._trove:Connect(UserInputService.InputBegan, function(p3, p4) -- Line: 95
        -- upvalues: u2 (copy)
        if p4 then
            return;
        end;

        if p3.UserInputType == Enum.UserInputType.MouseButton1 then
            u2.LeftDown:Fire();

            return;
        end;

        if p3.UserInputType == Enum.UserInputType.MouseButton2 then
            u2.RightDown:Fire();

            return;
        end;

        if p3.UserInputType == Enum.UserInputType.MouseButton3 then
            u2.MiddleDown:Fire();
        end;
    end);
    u2._trove:Connect(UserInputService.InputEnded, function(p5, p6) -- Line: 108
        -- upvalues: u2 (copy)
        if p6 then
            return;
        end;

        if p5.UserInputType == Enum.UserInputType.MouseButton1 then
            u2.LeftUp:Fire();

            return;
        end;

        if p5.UserInputType == Enum.UserInputType.MouseButton2 then
            u2.RightUp:Fire();

            return;
        end;

        if p5.UserInputType == Enum.UserInputType.MouseButton3 then
            u2.MiddleUp:Fire();
        end;
    end);
    u2._trove:Connect(UserInputService.InputChanged, function(p7, p8) -- Line: 121
        -- upvalues: u2 (copy)
        if p8 then
            return;
        end;

        if p7.UserInputType ~= Enum.UserInputType.MouseMovement then
            if p7.UserInputType == Enum.UserInputType.MouseWheel then
                u2.Scrolled:Fire(p7.Position.Z);
            end;

            return;
        end;

        local Position = p7.Position;
        u2.Moved:Fire(Vector2.new(Position.X, Position.Y));
    end);

    return u2;
end;

function u1.IsLeftDown(p9) -- Line: 139
    -- upvalues: UserInputService (copy)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1);
end;

function u1.IsRightDown(p10) -- Line: 146
    -- upvalues: UserInputService (copy)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
end;

function u1.IsMiddleDown(p11) -- Line: 153
    -- upvalues: UserInputService (copy)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3);
end;

function u1.GetPosition(p12) -- Line: 160
    -- upvalues: UserInputService (copy)
    return UserInputService:GetMouseLocation();
end;

function u1.GetDelta(p13) -- Line: 174
    -- upvalues: UserInputService (copy)
    return UserInputService:GetMouseDelta();
end;

function u1.GetRay(p14: table, p15) -- Line: 182
    -- upvalues: UserInputService (copy)
    local v16 = p15 or UserInputService:GetMouseLocation();

    return workspace.CurrentCamera:ViewportPointToRay(v16.X, v16.Y);
end;

function u1.Raycast(p17: table, p18: userdata, p19: number?, p20) -- Line: 209
    local Ray = p17:GetRay(p20);

    return workspace:Raycast(Ray.Origin, Ray.Direction * (p19 or 1000), p18);
end;

function u1.Project(p21: table, p22: number?, p23) -- Line: 241
    local Ray = p21:GetRay(p23);

    return Ray.Origin + Ray.Direction.Unit * (p22 or 1000);
end;

function u1.Lock(p24) -- Line: 255
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
end;

function u1.LockCenter(p25) -- Line: 266
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
end;

function u1.Unlock(p26) -- Line: 273
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
end;

function u1.Destroy(p27) -- Line: 280
    p27._trove:Destroy();
end;

return u1;