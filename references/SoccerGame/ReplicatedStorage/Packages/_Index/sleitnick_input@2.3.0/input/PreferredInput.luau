 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
--!strict

-- PreferredInput
-- Stephen Leitnick
-- April 05, 2021

--[=[
	@within PreferredInput
	@type InputType "MouseKeyboard" | "Touch" | "Gamepad"

	The InputType is just a string that is either `"MouseKeyboard"`,
	`"Touch"`, or `"Gamepad"`.
]=]
export type InputType = "MouseKeyboard" | "Touch" | "Gamepad"

local UserInputService = game:GetService("UserInputService")

local touchUserInputType = Enum.UserInputType.Touch
local keyboardUserInputType = Enum.UserInputType.Keyboard

type PreferredInput = {
	Current: InputType,
	Observe: (handler: (inputType: InputType) -> ()) -> () -> (),
}

--[=[
	@class PreferredInput
	@client

	A helper library for observing the preferred user input of the
	player. This is useful for determining what input schemes
	to use during gameplay. A player might switch from using
	a mouse to a gamepad mid-game, and it is important for the
	game to respond to this change.

	The Preferred class is part of the Input package.

	```lua
	local PreferredInput = require(packages.Input).PreferredInput
	```
]=]
--[=[
	@within PreferredInput
	@prop Current InputType
	@readonly

	The current preferred InputType.

	```lua
	print(PreferredInput.Current)
	```
]=]
--[=[
	@within PreferredInput
	@function Observe
	@param handler (preferred: InputType) -> ()
	@return () -> ()

	Observes the preferred input. In other words, the handler function will
	be fired immediately, as well as any time the preferred input changes.

	The returned function can be called to disconnect the observer.

	```lua
	local disconnect = PreferredInput.Observe(function(preferred)
		-- Fires immediately & any time the preferred input changes
		print(preferred)
	end)

	-- If/when desired, observer can be stopped by calling the returned function:
	disconnect()
	```
]=]

local PreferredInput: PreferredInput

local subscribers = {}

PreferredInput = {

	Current = "MouseKeyboard",

	Observe = function(handler: (inputType: InputType) -> ()): () -> ()
		if table.find(subscribers, handler) then
			error("function already subscribed", 2)
		end
		table.insert(subscribers, handler)

		task.spawn(handler, PreferredInput.Current)

		return function()
			local index = table.find(subscribers, handler)
			if index then
				local n = #subscribers
				subscribers[index], subscribers[n] = subscribers[n], nil
			end
		end
	end,
}

local function SetPreferred(preferred: InputType)
	if preferred == PreferredInput.Current then
		return
	end
	PreferredInput.Current = preferred

	for _, subscriber in subscribers do
		task.spawn(subscriber, preferred)
	end
end

local function DeterminePreferred(inputType: Enum.UserInputType)
	if inputType == touchUserInputType then
		SetPreferred("Touch")
	elseif inputType == keyboardUserInputType or string.sub(inputType.Name, 1, 5) == "Mouse" then
		SetPreferred("MouseKeyboard")
	elseif string.sub(inputType.Name, 1, 7) == "Gamepad" then
		SetPreferred("Gamepad")
	end
end

DeterminePreferred(UserInputService:GetLastInputType())
UserInputService.LastInputTypeChanged:Connect(DeterminePreferred)

return PreferredInput

]==]

 

local UserInputService = game:GetService("UserInputService");
local Touch = Enum.UserInputType.Touch;
local Keyboard = Enum.UserInputType.Keyboard;
local u1 = nil;
local u2 = {};
u1 = {
    Current = "MouseKeyboard",

    Observe = function(u3: function) -- Line: 83, Name: Observe
        -- upvalues: u2 (copy), u1 (ref)
        if table.find(u2, u3) then
            error("function already subscribed", 2);
        end;

        table.insert(u2, u3);
        task.spawn(u3, u1.Current);

        return function() -- Line: 91
            -- upvalues: u2 (ref), u3 (copy)
            local table_find_ret = table.find(u2, u3);

            if table_find_ret then
                local v4 = #u2;
                u2[table_find_ret] = u2[v4];
                u2[v4] = nil;
            end;
        end;
    end
};

local function SetPreferred(p5: string) -- Line: 101
    -- upvalues: u1 (ref), u2 (copy)
    if p5 == u1.Current then
        return;
    end;

    u1.Current = p5;

    for _, v in u2 do
        task.spawn(v, p5);
    end;
end;

local function DeterminePreferred(p6) -- Line: 112
    -- upvalues: Touch (copy), SetPreferred (copy), Keyboard (copy)
    if p6 == Touch then
        SetPreferred("Touch");

        return;
    end;

    if p6 == Keyboard or string.sub(p6.Name, 1, 5) == "Mouse" then
        SetPreferred("MouseKeyboard");

        return;
    end;

    if string.sub(p6.Name, 1, 7) == "Gamepad" then
        SetPreferred("Gamepad");
    end;
end;

local LastInputType = UserInputService:GetLastInputType();

if LastInputType == Touch then
    SetPreferred("Touch");
elseif LastInputType == Keyboard or string.sub(LastInputType.Name, 1, 5) == "Mouse" then
    SetPreferred("MouseKeyboard");
elseif string.sub(LastInputType.Name, 1, 7) == "Gamepad" then
    SetPreferred("Gamepad");
end;

UserInputService.LastInputTypeChanged:Connect(DeterminePreferred);

return u1;