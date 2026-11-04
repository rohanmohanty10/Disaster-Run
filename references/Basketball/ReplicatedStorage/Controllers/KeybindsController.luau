 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local DefaultKeybinds = require(ReplicatedStorage.Shared.Tables.DefaultKeybinds);
local KeybindIcons = require(ReplicatedStorage.Shared.Tables.KeybindIcons);
local Signal = require(ReplicatedStorage.Packages.Signal);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = Knit.CreateController({
    Name = "KeybindsController",
    PlatformChanged = Signal.new()
});

function u1.GetInputs(p2: string) -- Line: 15
    -- upvalues: Knit (copy), DefaultKeybinds (copy)
    local Settings = Knit.GetController("Network").Player.Customization.Settings;
    local v3 = DefaultKeybinds[p2];

    return {
        Keyboard = Settings.KeyboardKeybinds[p2] and Enum[Settings.KeyboardKeybinds[p2][1]][Settings.KeyboardKeybinds[p2][2]] or v3.Keyboard,
        Controller = Settings.ControllerKeybinds[p2] and Enum[Settings.ControllerKeybinds[p2][1]][Settings.ControllerKeybinds[p2][2]] or v3.Controller
    };
end;

function u1.GetKeybindIcon(p4: string) -- Line: 26
    -- upvalues: u1 (copy), KeybindIcons (copy), UserInputService (copy)
    local v5 = u1.GetInputs(p4)[u1.GetPlatform()];

    if v5 == nil then
        return "rbxassetid://91709859431629";
    end;

    local Gamepad = KeybindIcons.Gamepad;
    local v6;

    if v5.EnumType == Enum.KeyCode then
        v6 = UserInputService:GetStringForKeyCode(v5) or v5;
    else
        v6 = v5;
    end;

    local v7 = Gamepad[v6] or KeybindIcons.Dark[v5];

    return v7 == nil and "rbxassetid://91709859431629" or v7;
end;

function u1.IsInputValid(p8: userdata, p9: string) -- Line: 42
    -- upvalues: u1 (copy)
    local Inputs = u1.GetInputs(p9);

    return (p8.KeyCode == Inputs.Keyboard or (p8.UserInputType == Inputs.Keyboard or p8.KeyCode == Inputs.Controller)) and true or p8.UserInputType == Inputs.Controller;
end;

function u1.ChangeKeybind(p10: table, p11: string, p12: any, p13: string) -- Line: 50
    -- upvalues: KeybindIcons (copy), Effects (copy), Knit (copy)
    if p12 == nil then
        return warn((`Attempt to set Keybind "{p11}" to nil`));
    end;

    if KeybindIcons[p13 == "Controller" and "Gamepad" or "Dark"][p12] == nil then
        Effects:Popup(`Cannot change keybind to {p12.Name}!`, 5, Color3.fromRGB(255, 0, 0));

        return;
    end;

    Knit.GetService("SettingsService"):UpdateKeybind(p13, p11, p12);
end;

function u1.RemoveKeybind(p14: string, p15: string) -- Line: 81
    -- upvalues: DefaultKeybinds (copy), u1 (copy)
    local v16 = DefaultKeybinds[p14];

    if v16 == nil then
        error((`There is no keybind named "{p14}"!`));
    end;

    u1:ChangeKeybind(p14, v16[p15], p15);
end;

local u17 = "Keyboard";

function u1.GetPlatform() -- Line: 92
    -- upvalues: u17 (ref)
    return u17;
end;

function u1.OnPlatformChangedConnect(u18, u19, p20) -- Line: 118
    local v21 = p20 == nil and true or p20;

    if typeof(u19) ~= "function" then
        error((`{u19} is not a function!`));
    end;

    if typeof(v21) ~= "boolean" then
        error((`{v21} is not a boolean!`));
    end;

    u18._PlatformChangedCallbacks[u19] = true;

    if v21 then
        u19(u18.GetPlatform());
    end;

    return function() -- Line: 134
        -- upvalues: u18 (copy), u19 (copy)
        u18._PlatformChangedCallbacks[u19] = nil;
    end;
end;

function u1.KnitInit(u22) -- Line: 139
    -- upvalues: u17 (ref), u1 (copy), UserInputService (copy)
    u22._PlatformChangedCallbacks = {};

    local function lastInputTypeChanged(p23) -- Line: 144
        -- upvalues: u17 (ref), u1 (ref), u22 (copy)
        local string_lower_ret = string.lower(p23.Name);
        local v24 = u17;

        if string.find(string_lower_ret, "gamepad") == nil then
            if string.find(string_lower_ret, "keyboard") == nil and string.find(string_lower_ret, "mouse") == nil then
                if string_lower_ret == "touch" then
                    u17 = "Touchscreen";
                end;
            else
                u17 = "Keyboard";
            end;
        else
            u17 = "Controller";
        end;

        if v24 == u17 then
            return;
        end;

        u1.PlatformChanged:Fire(u17);

        for i, _ in u22._PlatformChangedCallbacks do
            i(u17);
        end;
    end;

    UserInputService.LastInputTypeChanged:Connect(lastInputTypeChanged);
    lastInputTypeChanged(UserInputService:GetLastInputType());
end;

function u1.KnitStart(p25) -- Line: 173
end;

return u1;