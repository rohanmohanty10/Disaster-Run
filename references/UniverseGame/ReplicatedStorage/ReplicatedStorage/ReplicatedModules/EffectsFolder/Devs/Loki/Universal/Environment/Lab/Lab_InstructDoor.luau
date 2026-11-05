  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
require(ReplicatedStorage.ReplicatedModules.Types);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;

local function _(p3, p4) -- Line: 29
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local function AssertNonFatal(u5, u6) -- Line: 33
    local success, result = pcall(function() -- Line: 34
        -- upvalues: u5 (copy), u6 (copy)
        assert(u5, u6);
    end);

    if not success then
        warn(result, debug.traceback());
    end;

    return u5;
end;

local function Tween(p7, p8, p9) -- Line: 45
    -- upvalues: TweenService (copy)
    local v10 = TweenService:Create(p7, p8, p9);
    v10:Play();

    return v10;
end;

local function PlayDoorSound(p11, p12) -- Line: 53
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    if p11:FindFirstChild("Gateway") then
        local CallEffects = EffectsHandler.CallEffects;
        local v13 = {};
        local v14 = {
            Name = "Play Sound At"
        };
        local v15 = {};
        local v16 = {};
        local v17;

        if p12 == "Open" then
            v17 = AssetHandler.GetAsset("Universal/Interaction/Lab/DoorOpen");
        else
            v17 = AssetHandler.GetAsset("Universal/Interaction/Lab/DoorClose");
        end;

        v16.Object = v17;
        v16.Origin = p11:FindFirstChild("Gateway").CFrame;
        v15[1] = v16;
        v14.Data = v15;
        v13[1] = v14;
        CallEffects(v13);
    end;
end;

local u18 = {};
local u35 = {
    {
        Open = function(u19) -- Line: 73, Name: Open
            -- upvalues: TweenService (copy), PlayDoorSound (copy)
            if u19:GetAttribute("Open") then
                return;
            end;

            local v20 = u19:FindFirstChild("Left Door");
            local v21 = u19:FindFirstChild("Right Door");
            u19:SetAttribute("Animating", true);

            for i, v in { v20, v21 } do
                if not v:GetAttribute("OriginalCF") then
                    v:SetAttribute("OriginalCF", v.CFrame);
                end;

                TweenService:Create(v, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    CFrame = v.CFrame * CFrame.new((v.Size.X - 0.25) * (i == 1 and -1 or 1), 0, 0)
                }):Play();
            end;

            task.delay(3, function() -- Line: 91
                -- upvalues: u19 (copy)
                u19:SetAttribute("Open", true);
                u19:SetAttribute("Animating", nil);
            end);
            PlayDoorSound(u19, "Open");
        end,

        Close = function(u22) -- Line: 98, Name: Close
            -- upvalues: TweenService (copy), PlayDoorSound (copy)
            if not u22:GetAttribute("Open") then
                return;
            end;

            local v23 = u22:FindFirstChild("Left Door");
            local v24 = u22:FindFirstChild("Right Door");
            u22:SetAttribute("Animating", true);

            for i, v in { v23, v24 } do
                local v25 = v:GetAttribute("OriginalCF") or v.CFrame * CFrame.new(-(v.Size.X - 0.25) * (i == 1 and -1 or 1), 0, 0);
                TweenService:Create(v, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    CFrame = v25
                }):Play();
            end;

            task.delay(3, function() -- Line: 114
                -- upvalues: u22 (copy)
                u22:SetAttribute("Open", nil);
                u22:SetAttribute("Animating", nil);
            end);
            PlayDoorSound(u22, "Close");
        end
    },
    {
        Open = function(u26) -- Line: 123, Name: Open
            -- upvalues: TweenService (copy), PlayDoorSound (copy)
            if u26:GetAttribute("Open") then
                return;
            end;

            local v27 = u26:FindFirstChild("Left Door");
            local v28 = u26:FindFirstChild("Right Door");
            local v29 = u26:FindFirstChild("Middle Door");
            u26:SetAttribute("Animating", true);

            for i, v in { v27, v28, v29 } do
                if not v:GetAttribute("OriginalCF") then
                    v:SetAttribute("OriginalCF", v.CFrame);
                end;

                TweenService:Create(v, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    CFrame = v.CFrame * CFrame.new(-(v.Size.X - 0.25) * (i == 1 and -1 or (i == 2 and 1 or 0)), i ~= 3 and 0 or v.Size.Y - 0.25, 0)
                }):Play();
            end;

            task.delay(3, function() -- Line: 144
                -- upvalues: u26 (copy)
                u26:SetAttribute("Open", true);
                u26:SetAttribute("Animating", nil);
            end);
            PlayDoorSound(u26, "Open");
        end,

        Close = function(u30) -- Line: 151, Name: Close
            -- upvalues: TweenService (copy), PlayDoorSound (copy)
            if not u30:GetAttribute("Open") then
                return;
            end;

            local v31 = u30:FindFirstChild("Left Door");
            local v32 = u30:FindFirstChild("Right Door");
            local v33 = u30:FindFirstChild("Middle Door");
            u30:SetAttribute("Animating", true);

            for i, v in { v31, v32, v33 } do
                local v34 = v:GetAttribute("OriginalCF") or v.CFrame * CFrame.new((v.Size.X - 0.25) * (i == 1 and -1 or (i == 2 and 1 or 0)), i ~= 3 and 0 or -(v.Size.Y - 0.25), 0);
                TweenService:Create(v, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    CFrame = v34
                }):Play();
            end;

            task.delay(3, function() -- Line: 171
                -- upvalues: u30 (copy)
                u30:SetAttribute("Open", nil);
                u30:SetAttribute("Animating", nil);
            end);
            PlayDoorSound(u30, "Close");
        end
    }
};

return function(u36, u37, p38) -- Line: 182
    -- upvalues: u18 (copy), u35 (copy)
    local u39;

    if u36 then
        u39 = u36.Parent;
    else
        u39 = u36;
    end;

    local u40 = "Invalid door model";
    local success, result = pcall(function() -- Line: 34
        -- upvalues: u39 (copy), u40 (copy)
        assert(u39, u40);
    end);

    if not success then
        warn(result, debug.traceback());
    end;

    if not u39 then
        return;
    end;

    local v41 = p38 or "Open";

    if u36:GetAttribute("Animating") then
        return;
    end;

    if u18[u36] then
        u18[u36]:Disconnect();
        u18[u36] = nil;
    end;

    if u35[u37] and u35[u37][v41] then
        u35[u37][v41](u36);

        if v41 == "Open" and not u36:GetAttribute("Queue") then
            u36:SetAttribute("Queue", true);
            task.delay(12, function() -- Line: 206
                -- upvalues: u35 (ref), u37 (copy), u36 (copy)
                task.spawn(u35[u37].Close, u36);
                u36:SetAttribute("Queue", nil);
            end);
        end;
    end;
end;