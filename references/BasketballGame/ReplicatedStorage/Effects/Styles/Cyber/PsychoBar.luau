 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function createClone(p1: userdata) -- Line: 17
    p1.Archivable = true;
    local v2 = p1:Clone();
    v2.Parent = workspace.Debris;
    local Color3_fromRGB_ret = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));

    for _, descendant in v2:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or descendant:IsA("Sound"))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if descendant:GetAttribute("Invis") and (descendant.Name ~= "BALL" and descendant.Name ~= "Model") then
                descendant.Transparency = 0;
            end;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant:Destroy();
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineColor = Color3_fromRGB_ret;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = v2;
    Highlight.Enabled = true;

    return v2, Color3_fromRGB_ret;
end;

return function(p3, u4) -- Line: 62
    -- upvalues: LocalPlayer (copy), Lighting (copy), Players (copy), createClone (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    if u4.Task ~= "Boost" then
        if u4.Task == "Stun" and u4.Char == LocalPlayer.Character then
            local u5 = script.Blur:Clone();
            u5.Size = 0;
            u5.Parent = Lighting;
            local u6 = script.DepthOfField:Clone();
            u6.FarIntensity = 0;
            u6.NearIntensity = 0;
            u6.Parent = Lighting;
            TweenService:Create(u6, TweenInfo_new_ret, {
                FarIntensity = script.DepthOfField.FarIntensity,
                NearIntensity = script.DepthOfField.NearIntensity
            }):Play();
            TweenService:Create(u5, TweenInfo_new_ret, {
                Size = script.Blur.Size
            }):Play();
            task.delay(10, function() -- Line: 136
                -- upvalues: TweenService (ref), u6 (copy), TweenInfo_new_ret2 (ref), u5 (copy)
                TweenService:Create(u6, TweenInfo_new_ret2, {
                    FarIntensity = 0,
                    NearIntensity = 0
                }):Play();
                TweenService:Create(u5, TweenInfo_new_ret2, {
                    Size = 0
                }):Play();
                task.wait(5);
                u6:Destroy();
                u5:Destroy();
            end);
        end;

        return;
    end;

    if u4.Char:GetAttribute("TheMoon") then
        return;
    end;

    if u4.Char == LocalPlayer.Character then
        local u7 = script.ColorCorrection:Clone();
        u7.Parent = Lighting;
        task.delay(u4.Time, function() -- Line: 74
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    end;

    if u4.Char then
        u4.Char.Archivable = true;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u4.Char);
    local u8 = {};
    task.spawn(function() -- Line: 86
        -- upvalues: u4 (copy), PlayerFromCharacter (copy), createClone (ref), u8 (copy)
        local os_clock_ret = os.clock();

        while u4.Char:IsDescendantOf(workspace) and (os.clock() - os_clock_ret < u4.Time and (PlayerFromCharacter == nil or PlayerFromCharacter:GetAttribute("PsychoBar") == -1)) do
            local u9 = createClone(u4.Char);
            table.insert(u8, u9);
            task.delay(1, function() -- Line: 97
                -- upvalues: u9 (copy)
                u9:Destroy();
            end);
            task.wait(0.1);
        end;

        if u4.Char then
            u4.Char.Archivable = false;
        end;
    end);
    task.delay(u4.Time, function() -- Line: 109
        -- upvalues: u8 (copy)
        for _, v in u8 do
            v:Destroy();
        end;

        table.clear(u8);
    end);
end;