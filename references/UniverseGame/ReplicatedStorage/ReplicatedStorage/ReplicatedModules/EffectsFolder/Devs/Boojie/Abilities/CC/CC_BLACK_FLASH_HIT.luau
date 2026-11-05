  

 

local u1 = Random.new();
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LightningBolt = require(script.Parent.Lightning.LightningBolt);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u2 = {
    Color = Color3.fromRGB(125, 0, 0)
};

local function CreateBolt(p3) -- Line: 14
    -- upvalues: u2 (copy), LightningBolt (copy), ParticleHandler (copy)
    local v4 = p3 or {};
    local v5 = v4.Start or Vector3.new(0, 0, 0);
    local v6 = v4.End or Vector3.new(0, 0, 0);
    local v7 = v4.Amount or 12;

    if not v4.Color then
        local _ = u2.Color;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Position = v5;
    Attachment.Archivable = false;
    Attachment.Parent = game.Workspace.Terrain;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Position = v6;
    Attachment2.Archivable = false;
    Attachment2.Parent = game.Workspace.Terrain;
    local u8 = LightningBolt.new(Attachment, Attachment2, v7);
    u8.Color = u2.Color;

    if v4.HSVShift then
        u8.Color = ParticleHandler.HSVShift(u8.Color, v4.HSVShift);
    end;

    u8.MinRadius = 0;
    u8.MaxRadius = 2.5;
    u8.PulseLength = 1.5;
    u8.PulseSpeed = 4;
    u8.Thickness = 0.6;
    u8.FadeLength = 0.25;
    u8.AnimationSpeed = 8;

    if v4.Info then
        for i, v in pairs(v4.Info) do
            u8[i] = v;
        end;
    end;

    return u8, function(p9, p10) -- Line: 51
        -- upvalues: u8 (copy), Attachment (copy), Attachment2 (copy)
        if getmetatable(u8) then
            u8:DestroyDissipate(p9, p10);
        end;

        Attachment:Destroy();
        Attachment2:Destroy();
    end;
end;

local function GetMultiplier() -- Line: 60
    -- upvalues: u1 (copy)
    return u1:NextInteger(0, 1) == 0 and -1 or 1;
end;

return function(p11, p12) -- Line: 64
    -- upvalues: ParticleHandler (copy), Trove (copy), u1 (copy), CreateBolt (copy)
    if p11 == nil then
        return;
    end;

    if typeof(p11) == "Instance" and p11:IsA("BasePart") then
        p11 = p11.CFrame;
    end;

    local v13 = p12 or {};
    local _BlackFlash = workspace.CurrentCamera:FindFirstChild("_BlackFlash");

    if _BlackFlash then
        _BlackFlash = _BlackFlash:FindFirstChild("Highlight");
    end;

    if _BlackFlash then
        if v13.HSVShift then
            _BlackFlash.OutlineColor = ParticleHandler.HSVShift(_BlackFlash:GetAttribute("OriginalColor"), v13.HSVShift);
        else
            _BlackFlash.OutlineColor = _BlackFlash:GetAttribute("OriginalColor");
        end;
    end;

    local v14 = Trove.new();

    for _ = 1, 4 do
        local v15 = u1:NextNumber(12, 18) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
        local v16 = u1:NextNumber(-8, 12);
        local v17 = u1:NextNumber(12, 18) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
        local _, u18 = CreateBolt({
            Start = (p11 * CFrame.new(-v15, -v16, -v17)).Position,
            End = (p11 * CFrame.new(v15, v16, v17)).Position,
            Info = {
                Thickness = 0.75,
                PulseLength = 4,
                PulseSpeed = 4,
                MaxRadius = 8,
                AnimationSpeed = 12
            },
            HSVShift = v13.HSVShift
        });
        v14:Add(function() -- Line: 98
            -- upvalues: u18 (copy)
            u18();
        end);
    end;

    for _ = 1, 3 do
        local v19 = u1:NextNumber(18, 36) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
        local v20 = u1:NextNumber(6, 12);
        local v21 = u1:NextNumber(2, 12);
        local v22 = u1:NextInteger(0, 1) == 0 and -1 or 1;
        local _, u23 = CreateBolt({
            Start = p11.Position,
            End = (p11 * CFrame.new(v19, v20, v21 * v22)).Position,
            Info = {
                Thickness = 1.75,
                MaxRadius = 16,
                PulseLength = 4,
                PulseSpeed = 12,
                AnimationSpeed = 64
            },
            HSVShift = v13.HSVShift
        });
        v14:Add(function() -- Line: 119
            -- upvalues: u23 (copy)
            u23();
        end);
    end;

    task.wait(1);
    v14:Destroy();
end;