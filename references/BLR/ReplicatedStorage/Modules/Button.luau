  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
local Signal = require(ReplicatedStorage.Packages.Signal);
local Janitor = require(ReplicatedStorage.Packages.Janitor);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local u1 = {};

for _, child in ipairs(script.Styles:GetChildren()) do
    u1[tostring(child)] = require(child);
end;

local u2 = {};
u2.__index = u2;

function u2.CheckValidInputObject(p3: table, p4: userdata) -- Line: 18
    -- upvalues: TableUtil (copy)
    local Gamepad = p3.Settings.Gamepad;
    local v5 = (Gamepad and p4[Gamepad.EnumType] == Gamepad or TableUtil.SearchArray({ Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }, p4.UserInputType)) and not p3.Locked;

    return v5;
end;

function u2.SetStyle(p6: table, p7: string) -- Line: 24
    -- upvalues: u1 (copy)
    p6.Style = u1[p7].new(p6);
end;

function u2.Ended(p8) -- Line: 28
    if p8.Style then
        p8.Style:Ended();
    end;

    p8.OnEnded:Fire();
end;

function u2.Click(p9) -- Line: 35
    -- upvalues: SoundManager (copy)
    local Cooldown = p9.Settings.Cooldown;

    if Cooldown then
        local v10 = tick();
        local LastInput = p9.LastInput;

        if LastInput and v10 - LastInput <= Cooldown then
            return;
        end;

        p9.LastInput = v10;
    end;

    local ClickSound = p9.Settings.ClickSound;

    if ClickSound then
        SoundManager.SpawnSound(ClickSound);
    end;

    if p9.Style then
        p9.Style:Click();
    end;

    p9.OnClick:Fire();
end;

function u2.Hover(p11: table, p12: boolean) -- Line: 61
    p11.IsHovering = p12;

    if p11.Style then
        p11.Style:Hover();
    end;

    p11.OnHover:Fire(p12);
end;

function u2.Destroy(p13) -- Line: 69
    p13.Janitor:Destroy();
    setmetatable(p13, nil);
end;

function u2.new(p14: userdata, p15: any) -- Line: 74
    -- upvalues: Janitor (copy), u2 (copy), Signal (copy)
    local v16 = Janitor.new();
    local v17 = p15 or {};
    local u18 = setmetatable({
        Instance = v17.MainObject or p14,
        Settings = v17,
        Janitor = v16
    }, u2);

    for _, v in ipairs({ "OnClick", "OnEnded", "OnHover" }) do
        u18[v] = v16:Add(Signal.new());
    end;

    if v17.Style then
        u18:SetStyle(v17.Style);
    end;

    v16:Add(p14.InputBegan:Connect(function(p19: userdata) -- Line: 92
        -- upvalues: u18 (copy)
        if u18:CheckValidInputObject(p19) then
            u18:Click();
        end;
    end));
    v16:Add(p14.InputEnded:Connect(function(p20: userdata) -- Line: 98
        -- upvalues: u18 (copy)
        if u18:CheckValidInputObject(p20) then
            u18:Ended();
        end;
    end));
    v16:Add(p14.MouseEnter:Connect(function() -- Line: 104
        -- upvalues: u18 (copy)
        u18:Hover(true);
    end));
    v16:Add(p14.MouseLeave:Connect(function() -- Line: 108
        -- upvalues: u18 (copy)
        u18:Hover(false);
    end));

    return u18;
end;

function u2.CreateDefaultButton(p21: userdata, p22: any) -- Line: 115
    -- upvalues: u2 (copy), TableUtil (copy)
    return u2.new(p21, TableUtil.Assign(p22 or {}, {
        ClickSound = "Click",
        Style = "Default"
    }));
end;

return u2;