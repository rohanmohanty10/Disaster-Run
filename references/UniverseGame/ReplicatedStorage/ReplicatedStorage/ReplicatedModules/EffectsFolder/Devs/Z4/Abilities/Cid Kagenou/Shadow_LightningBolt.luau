  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
local LightningSparks = require(ReplicatedStorage.ClientModules.LightningBolt.LightningSparks);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

return function(u3, p4) -- Line: 20
    -- upvalues: u2 (copy), Trove (copy), u1 (copy), LightningBolt (copy), LightningSparks (copy)
    local v5 = p4 or {};
    local u6 = v5.Color or Color3.fromRGB(127, 67, 255);
    local u7 = v5.Thickness or 0.65;
    local u8 = v5.Frequency or 0.3;
    local u9 = v5.AnimationSpeed or 10;
    local u10 = v5.PulseSpeed or 8;
    local u11 = v5.PulseLength or u2:NextNumber(1, 1.5);
    local u12 = v5.FadeLength or 0.1;
    local u13 = v5.MaxRadius or u2:NextNumber(2.5, 8);
    local v14 = v5.Duration or 1.2;
    local Attachment = v5.Attachment;
    local DisableHighlight = v5.DisableHighlight;
    local u15 = Trove.new();
    local u16 = u15:Construct(Instance, "Model");
    u16.Parent = workspace.Effects;
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = u16;
    local v17 = Color3.fromRGB(0, 0, 0);
    local v18 = Color3.fromRGB(0, 0, 0);
    Highlight.FillColor = v17;
    Highlight.OutlineColor = v18;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineTransparency = 0;

    if DisableHighlight then
        Highlight.FillTransparency = 1;
    else
        Highlight.FillTransparency = 0;
    end;

    local u19 = true;
    task.delay(v14, function() -- Line: 54
        -- upvalues: u19 (ref), u15 (copy)
        u19 = false;
        task.wait(1);
        u15:Destroy();
    end);
    task.spawn(function() -- Line: 60
        -- upvalues: u19 (ref), u3 (copy), u2 (ref), u1 (ref), Attachment (ref), u15 (copy), LightningBolt (ref), u16 (copy), u10 (copy), u11 (copy), u12 (copy), u8 (copy), u7 (copy), u9 (copy), u13 (copy), u6 (copy), LightningSparks (ref)
        while u19 and u3 do
            local v20 = u2:NextNumber(15, 20);
            local v21 = u2:NextNumber(-1, 1);
            local v22 = u2:NextNumber(-1, 0.5);
            local v23 = Vector3.new(v21, v22, u2:NextNumber(-1, 1)) * v20;
            local v24 = workspace:Raycast(u3.Position, v23, u1);

            if v24 then
                if not Attachment then
                    Attachment = u15:Construct(Instance, "Attachment");
                    Attachment.Parent = workspace.Terrain;
                    Attachment.WorldPosition = v24.Position;
                end;

                local v25 = u3:FindFirstChild("BodyFrontAttachment") or Attachment;
                local v26 = LightningBolt.new(v25, Attachment, 12, u16);
                v26.PulseSpeed = u10;
                v26.PulseLength = u11;
                v26.FadeLength = u12;
                v26.Frequency = u8;
                v26.Thickness = u7;
                v26.AnimationSpeed = u9;
                v26.MaxRadius = u13;
                v26.Color = u6;
                LightningSparks.new(v26);
            end;

            task.wait();
        end;
    end);
end;