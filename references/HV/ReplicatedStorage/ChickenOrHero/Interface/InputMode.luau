 

 

local UserInputService = game:GetService("UserInputService");
local u1 = {
    Changed = require(script.Parent.Signal).new()
};
local u2 = nil;
local u3 = {};

local function modeFor(p4) -- Line: 11
    return p4 == Enum.UserInputType.Touch and "Touch" or ((p4 == Enum.UserInputType.Keyboard or (p4 == Enum.UserInputType.MouseMovement or (p4 == Enum.UserInputType.MouseButton1 or (p4 == Enum.UserInputType.MouseButton2 or (p4 == Enum.UserInputType.MouseButton3 or p4 == Enum.UserInputType.MouseWheel))))) and "Pc" or (string.find(p4.Name, "^Gamepad") and "Console" or nil));
end;

function u1.image(p5, p6) -- Line: 30
    -- upvalues: UserInputService (copy)
    local success, result = pcall(UserInputService.GetImageForKeyCode, UserInputService, p5);

    if success and (result ~= "" and result) then
        p6 = result;
    end;

    return p6;
end;

local function apply(p7) -- Line: 35
    -- upvalues: u2 (ref), u1 (copy)
    p7.key.Visible = u2 == "Pc";
    p7.console.Visible = u2 == "Console";

    if u2 == "Console" then
        p7.console.Image = u1.image(p7.keyCode, p7.fallback);
    end;
end;

local function set(p8, p9) -- Line: 43
    -- upvalues: u2 (ref), u3 (copy), u1 (copy)
    if p8 == nil or p8 == u2 and not p9 then
        return;
    end;

    u2 = p8;

    for i in u3 do
        i.key.Visible = u2 == "Pc";
        i.console.Visible = u2 == "Console";

        if u2 == "Console" then
            i.console.Image = u1.image(i.keyCode, i.fallback);
        end;
    end;

    u1.Changed:Fire(u2);
end;

local function start() -- Line: 54
    -- upvalues: u2 (ref), UserInputService (copy), modeFor (copy), u3 (copy), u1 (copy)
    if u2 then
        return;
    end;

    local PreferredInput = UserInputService.PreferredInput;
    u2 = modeFor(UserInputService:GetLastInputType()) or (PreferredInput == Enum.PreferredInput.Touch and "Touch" or (PreferredInput == Enum.PreferredInput.Gamepad and "Console" or "Pc"));
    UserInputService.LastInputTypeChanged:Connect(function(p10) -- Line: 64
        -- upvalues: modeFor (ref), u2 (ref), u3 (ref), u1 (ref)
        local v11 = modeFor(p10);

        if v11 ~= nil then
            if v11 == u2 then
                return;
            end;

            u2 = v11;

            for i in u3 do
                i.key.Visible = u2 == "Pc";
                i.console.Visible = u2 == "Console";

                if u2 == "Console" then
                    i.console.Image = u1.image(i.keyCode, i.fallback);
                end;
            end;

            u1.Changed:Fire(u2);
        end;
    end);
    UserInputService.GamepadConnected:Connect(function() -- Line: 68
        -- upvalues: u2 (ref), u3 (ref), u1 (ref)
        if u2 == "Console" then
            local v12 = u2;

            if v12 ~= nil then
                local _ = v12 == u2;
                u2 = v12;

                for i in u3 do
                    i.key.Visible = u2 == "Pc";
                    i.console.Visible = u2 == "Console";

                    if u2 == "Console" then
                        i.console.Image = u1.image(i.keyCode, i.fallback);
                    end;
                end;

                u1.Changed:Fire(u2);
            end;
        end;
    end);
end;

function u1.get() -- Line: 75
    -- upvalues: start (copy), u2 (ref)
    start();

    return u2;
end;

function u1.badge(p13, p14, p15, p16) -- Line: 82
    -- upvalues: start (copy), u3 (copy), u2 (ref), u1 (copy)
    start();
    local u17 = {
        key = p13,
        console = p14,
        keyCode = p15,
        fallback = p16
    };
    u3[u17] = true;
    u17.key.Visible = u2 == "Pc";
    u17.console.Visible = u2 == "Console";

    if u2 == "Console" then
        u17.console.Image = u1.image(u17.keyCode, u17.fallback);
    end;

    return function() -- Line: 87
        -- upvalues: u3 (ref), u17 (copy)
        u3[u17] = nil;
    end;
end;

return u1;