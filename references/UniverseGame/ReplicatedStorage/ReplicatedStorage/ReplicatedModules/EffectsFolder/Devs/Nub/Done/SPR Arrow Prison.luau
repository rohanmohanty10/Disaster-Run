  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");
local Sound = Instance.new("Sound");
local cos = math.cos;
local sin = math.sin;
local _ = math.rad;
local _ = math.random;
local insert = table.insert;
local Angles = CFrame.Angles;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function createsound(p2, p3) -- Line: 15
    -- upvalues: Sound (copy)
    local v4 = Sound:Clone();

    for i, v in pairs(p3) do
        v4[i] = v;
    end;

    v4.SoundId = "rbxassetid://" .. p2;

    return v4;
end;

local function getang(p5, p6) -- Line: 23
    -- upvalues: cos (copy), sin (copy)
    return { cos(p5) * p6, sin(p5) * p6 };
end;

local function createradians(p7, p8, p9) -- Line: 26
    -- upvalues: cos (copy), sin (copy), insert (copy)
    local v10 = p9 or 0;
    local v11 = {};

    for i = 1, p7 do
        local v12 = 6.283185307179586 / p7 * i + v10;
        insert(v11, { cos(v12) * p8, sin(v12) * p8 });
    end;

    return v11;
end;

local function tweendeb(p13, p14) -- Line: 35
    p13:Play();
    p13.Completed:Wait();

    if p14 then
        p14:Destroy();
    end;

    return true;
end;

return function(p15, p16, p17) -- Line: 41
    -- upvalues: u1 (copy), createradians (copy), ParticleHandler (copy), Angles (copy), Sound (copy), SoundGroups (copy), wrap (copy), TweenService (copy)
    local v18;

    if u1:FindFirstChild(p15.StandName) then
        v18 = u1[p15.StandName];
    else
        v18 = u1["Star Platinum Requiem"];
    end;

    local HumanoidRootPart = p16:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local reqeffect = v18.reqeffect;
    local ArrowData = p15.ArrowData;
    local Size = ArrowData.Size;
    local EndOffset = ArrowData.EndOffset;
    local v19 = createradians(ArrowData.Amount, ArrowData.StartOffset);
    local v20 = {};
    local Color = reqeffect.Color;
    local v21 = ParticleHandler.GetUnusualHSVData({
        Character = p16
    });

    if v21 ~= nil then
        Color = ParticleHandler.HSVShift(Color, v21);
    end;

    for i, v in ipairs(v19) do
        local v22 = reqeffect:Clone();
        v22.Color = ArrowData.Colors[i % 2 + 1];
        v22.Size = v22.Size * Size;
        v22.Transparency = 1;
        v22.CFrame = CFrame.new((p17 * CFrame.new(v[1], 0, v[2])).Position, p17.Position) * Angles(-1.5707963267948966, 0, 0);
        v22.CFrame = v22.CFrame * CFrame.new(0, 0, EndOffset);
        v22.Color = Color;
        v22.Parent = workspace.Effects;
        table.insert(v20, v22);
    end;

    local v23 = Sound:Clone();

    for i, v in pairs({
        PlayOnRemove = true,
        Parent = HumanoidRootPart
    }) do
        v23[i] = v;
    end;

    v23.SoundId = "rbxassetid://" .. 2959894855;
    SoundGroups:AssignSoundTag(v23);
    v23:Destroy();

    for _, v in ipairs(v20) do
        wrap(function() -- Line: 80
            -- upvalues: TweenService (ref), v (copy), EndOffset (copy)
            local v24 = TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Transparency = 0
            });
            v24:Play();
            v24.Completed:Wait();
            local v25 = TweenService:Create(v, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                CFrame = v.CFrame * CFrame.new(0, 0, -EndOffset)
            });
            v25:Play();
            v25.Completed:Wait();
            local v26 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Transparency = 1
            });
            v26:Play();
            v26.Completed:Wait();
            v:Destroy();
        end)();
    end;
end;