  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = false;
local u2 = Random.new();

local function GetGlitcherMusic(p3) -- Line: 15
    -- upvalues: LocalPlayer (copy)
    for _, v in p3 == LocalPlayer.Character and not p3:GetAttribute("LocalMusic") and p3:GetChildren() or p3:GetDescendants() do
        if v:IsA("Sound") and (v.IsPlaying or v:GetAttribute("IsPaused")) and v:GetAttribute("EmoteSound") then
            return v;
        end;
    end;

    return nil;
end;

local function GetGlitcherPoseMusic(p4) -- Line: 25
    -- upvalues: LocalPlayer (copy)
    for _, v in p4 == LocalPlayer.Character and not p4:GetAttribute("LocalMusic") and p4:GetChildren() or p4:GetDescendants() do
        if v:IsA("Sound") and (string.find(v.Name, "PoseMusic") and v.IsPlaying) then
            return v;
        end;
    end;

    return nil;
end;

local function MuffleConnect(p5) -- Line: 36
    -- upvalues: GetGlitcherMusic (copy), u1 (ref), TweenService (copy)
    local v6 = GetGlitcherMusic(p5);

    if not v6 then
        u1 = false;

        return;
    end;

    local Muffler = v6:FindFirstChild("Muffler");
    local v7 = Muffler or Instance.new("EqualizerSoundEffect");

    if not Muffler then
        v7.HighGain = 0;
        v7.LowGain = 0;
        v7.MidGain = 0;
        v7.Name = "Muffler";
    end;

    v7.Parent = v6;
    local u8 = TweenService:Create(v7, TweenInfo.new(0.825, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        HighGain = -25,
        MidGain = -25
    });
    local u9 = TweenService:Create(v7, TweenInfo.new(0.69, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        HighGain = 0,
        MidGain = 0
    });
    u8:Play();
    p5:GetAttributeChangedSignal("Quoting"):Once(function() -- Line: 65
        -- upvalues: u8 (copy), u9 (copy), u1 (ref)
        u8:Cancel();
        u9:Play();
        u1 = false;
    end);
end;

local function RainbowCharacter(p10, p11) -- Line: 72
    -- upvalues: EffectsHandler (copy), u2 (copy)
    EffectsHandler.CallEffect("RainbowCharacter", {
        Character = p10,
        Remove = not p11,
        Tween = p11 and 0.75 or 1.75
    });
    local RainbowEasterEgg = p10:FindFirstChild("RainbowEasterEgg", true);

    if RainbowEasterEgg then
        if p11 and u2:NextInteger(1, 100) <= 5 then
            RainbowEasterEgg:Play();

            return;
        end;

        RainbowEasterEgg:Stop();
    end;
end;

return function(u12) -- Line: 86
    -- upvalues: Trove (copy), u1 (ref), MuffleConnect (copy), EffectsHandler (copy), u2 (copy), GetGlitcherMusic (copy), TweenService (copy), LocalPlayer (copy), GetGlitcherPoseMusic (copy)
    if u12:GetAttribute("_MayhemConnected") then
        return;
    end;

    u12:SetAttribute("_MayhemConnected", true);
    local v13 = Trove.new();
    v13:AttachToInstance(u12);
    v13:Connect(u12:GetAttributeChangedSignal("Quoting"), function() -- Line: 93
        -- upvalues: u12 (copy), u1 (ref), MuffleConnect (ref)
        if u12:GetAttribute("Quoting") == true and not u1 then
            u1 = true;
            MuffleConnect(u12);
        end;
    end);
    v13:Connect(u12:GetAttributeChangedSignal("UmbraBarDrain"), function() -- Line: 100
        -- upvalues: u12 (copy), EffectsHandler (ref), u2 (ref)
        local v14 = u12:GetAttribute("GlitcherForm");

        if v14 == "Rainbow" and u12:GetAttribute("UmbraBarDrain") then
            local v15 = u12;
            EffectsHandler.CallEffect("RainbowCharacter", {
                Remove = false,
                Tween = 0.75,
                Character = v15
            });
            local RainbowEasterEgg = v15:FindFirstChild("RainbowEasterEgg", true);

            if RainbowEasterEgg then
                if u2:NextInteger(1, 100) <= 5 then
                    RainbowEasterEgg:Play();

                    return;
                end;

                RainbowEasterEgg:Stop();
            end;
        elseif v14 == "Rainbow" and not u12:GetAttribute("UmbraBarDrain") then
            if u12:GetAttribute("Posing") then
                u12:GetAttributeChangedSignal("Posing"):Once(function() -- Line: 106
                    -- upvalues: u12 (ref), EffectsHandler (ref)
                    local v16 = u12;
                    EffectsHandler.CallEffect("RainbowCharacter", {
                        Remove = true,
                        Tween = 1.75,
                        Character = v16
                    });
                    local RainbowEasterEgg = v16:FindFirstChild("RainbowEasterEgg", true);

                    if RainbowEasterEgg then
                        RainbowEasterEgg:Stop();
                    end;
                end);

                return;
            end;

            local v17 = u12;
            EffectsHandler.CallEffect("RainbowCharacter", {
                Remove = true,
                Tween = 1.75,
                Character = v17
            });
            local RainbowEasterEgg = v17:FindFirstChild("RainbowEasterEgg", true);

            if RainbowEasterEgg then
                RainbowEasterEgg:Stop();
            end;
        end;
    end);
    v13:Connect(u12:GetAttributeChangedSignal("GlitcherForm"), function() -- Line: 114
        -- upvalues: u12 (copy), EffectsHandler (ref), u2 (ref)
        local v18 = u12:GetAttribute("GlitcherForm");

        if v18 == "Rainbow" and u12:GetAttribute("UmbraBarDrain") then
            local v19 = u12;
            EffectsHandler.CallEffect("RainbowCharacter", {
                Remove = false,
                Tween = 0.75,
                Character = v19
            });
            local RainbowEasterEgg = v19:FindFirstChild("RainbowEasterEgg", true);

            if RainbowEasterEgg then
                if u2:NextInteger(1, 100) <= 5 then
                    RainbowEasterEgg:Play();

                    return;
                end;

                RainbowEasterEgg:Stop();
            end;
        elseif v18 ~= "Rainbow" and u12:GetAttribute("UmbraBarDrain") then
            local v20 = u12;
            EffectsHandler.CallEffect("RainbowCharacter", {
                Remove = true,
                Tween = 1.75,
                Character = v20
            });
            local RainbowEasterEgg = v20:FindFirstChild("RainbowEasterEgg", true);

            if RainbowEasterEgg then
                RainbowEasterEgg:Stop();
            end;
        end;
    end);
    v13:Connect(u12:GetAttributeChangedSignal("PoseAudioRemove"), function() -- Line: 122
        -- upvalues: GetGlitcherMusic (ref), u12 (copy), TweenService (ref), LocalPlayer (ref), GetGlitcherPoseMusic (ref)
        local u21 = GetGlitcherMusic(u12);

        if not u21 then
            return;
        end;

        local v22 = u12:GetAttribute("PoseAudioRemove");

        if not v22 then
            if not v22 and u21:GetAttribute("_OrigVol") then
                u21:SetAttribute("IsPaused", nil);
                TweenService:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.01), {
                    Volume = u21:GetAttribute("_OrigVol")
                }):Play();
                u21:Resume();

                if u12 == LocalPlayer.Character then
                    local u23 = GetGlitcherPoseMusic(u12);

                    if not u23 then
                        return;
                    end;

                    u23.Name = "";
                    local v24 = TweenService:Create(u23, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    });
                    v24:Play();
                    v24.Completed:Once(function() -- Line: 156
                        -- upvalues: u23 (copy)
                        if u23 then
                            u23:Destroy();
                        end;
                    end);
                end;
            end;

            return;
        end;

        if not u21:GetAttribute("_OrigVol") then
            u21:SetAttribute("_OrigVol", u21.Volume);
        end;

        u21:SetAttribute("IsPaused", true);
        local v25 = TweenService:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Volume = 0
        });
        v25:Play();
        v25.Completed:Once(function(p26) -- Line: 136
            -- upvalues: u21 (copy)
            if p26 == Enum.PlaybackState.Completed and u21 then
                u21:Pause();
            end;
        end);
    end);
end;