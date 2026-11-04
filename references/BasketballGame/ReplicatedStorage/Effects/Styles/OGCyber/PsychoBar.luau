 
 

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
    local v3 = ({
        Color3.fromRGB(66, 252, 255),
        Color3.fromRGB(65, 141, 255),
        Color3.fromRGB(255, 248, 43),
        Color3.fromRGB(255, 200, 61)
    })[math.random(1, 4)];

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
    Highlight.FillColor = v3;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineColor = v3;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = v2;
    Highlight.Enabled = true;

    return v2, v3;
end;

return function(p4, u5) -- Line: 68
    -- upvalues: LocalPlayer (copy), Lighting (copy), Players (copy), createClone (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    if u5.Task ~= "Boost" then
        if u5.Task == "Stun" and u5.Char == LocalPlayer.Character then
            local u6 = script.Blur:Clone();
            u6.Size = 0;
            u6.Parent = Lighting;
            local u7 = script.DepthOfField:Clone();
            u7.FarIntensity = 0;
            u7.NearIntensity = 0;
            u7.Parent = Lighting;
            TweenService:Create(u7, TweenInfo_new_ret, {
                FarIntensity = script.DepthOfField.FarIntensity,
                NearIntensity = script.DepthOfField.NearIntensity
            }):Play();
            TweenService:Create(u6, TweenInfo_new_ret, {
                Size = script.Blur.Size
            }):Play();
            task.delay(10, function() -- Line: 142
                -- upvalues: TweenService (ref), u7 (copy), TweenInfo_new_ret2 (ref), u6 (copy)
                TweenService:Create(u7, TweenInfo_new_ret2, {
                    FarIntensity = 0,
                    NearIntensity = 0
                }):Play();
                TweenService:Create(u6, TweenInfo_new_ret2, {
                    Size = 0
                }):Play();
                task.wait(5);
                u7:Destroy();
                u6:Destroy();
            end);
        end;

        return;
    end;

    if u5.Char:GetAttribute("TheMoon") then
        return;
    end;

    if u5.Char == LocalPlayer.Character then
        local u8 = script.ColorCorrection:Clone();
        u8.Parent = Lighting;
        task.delay(u5.Time, function() -- Line: 80
            -- upvalues: u8 (copy)
            u8:Destroy();
        end);
    end;

    if u5.Char then
        u5.Char.Archivable = true;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u5.Char);
    local u9 = {};
    task.spawn(function() -- Line: 92
        -- upvalues: u5 (copy), PlayerFromCharacter (copy), createClone (ref), u9 (copy)
        local os_clock_ret = os.clock();

        while u5.Char:IsDescendantOf(workspace) and (os.clock() - os_clock_ret < u5.Time and (PlayerFromCharacter == nil or PlayerFromCharacter:GetAttribute("PsychoBar") == -1)) do
            local u10 = createClone(u5.Char);
            table.insert(u9, u10);
            task.delay(1, function() -- Line: 103
                -- upvalues: u10 (copy)
                u10:Destroy();
            end);
            task.wait(0.1);
        end;

        if u5.Char then
            u5.Char.Archivable = false;
        end;
    end);
    task.delay(u5.Time, function() -- Line: 115
        -- upvalues: u9 (copy)
        for _, v in u9 do
            v:Destroy();
        end;

        table.clear(u9);
    end);
end;