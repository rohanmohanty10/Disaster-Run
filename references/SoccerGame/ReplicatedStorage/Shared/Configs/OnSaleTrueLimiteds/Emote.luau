  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage.Assets;
require(ReplicatedStorage.Packages.Knit.KnitClient);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1: string, p2: any, p3: any) -- Line: 11
    -- upvalues: makePlayerModel (copy), ReplicatedStorage (copy), Essentials (copy), EmitModule (copy)
    return {
        Type = "Emote",
        HeaderOffset = 14,
        Name = p1,
        ProductId = p2,
        GiftProductId = p3,
        Gradient = script.EmoteGradient,

        LoadVisual = function(p4, p5) -- Line: 19, Name: LoadVisual
            -- upvalues: makePlayerModel (ref), ReplicatedStorage (ref), Essentials (ref), EmitModule (ref)
            local v6 = makePlayerModel();
            v6:PivotTo(p5.Origin.CFrame * CFrame.new(0, 1, 0));
            v6.Parent = p5;
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://96198169756628";
            local u7 = v6.Humanoid:LoadAnimation(Animation);
            u7.Priority = Enum.AnimationPriority.Action4;
            u7:Play();
            local BlackholeDomain = ReplicatedStorage.Assets.Misc.BlackholeDomain;
            local u8 = BlackholeDomain.Part:Clone();
            u8:PivotTo(v6.HumanoidRootPart.CFrame * BlackholeDomain.HumanoidRootPart.CFrame:ToObjectSpace(u8:GetPivot()));
            u8.CanCollide = false;
            u8.Massless = true;
            u8.Anchored = false;
            u8.Transparency = 1;
            Essentials:Weld(v6.HumanoidRootPart, u8, u8);
            u8.Parent = workspace.Debris;
            task.delay(0.3333333333333333, function() -- Line: 45
                -- upvalues: EmitModule (ref), u8 (copy)
                EmitModule.emit(u8);
            end);
            task.spawn(function() -- Line: 50
                -- upvalues: u7 (copy), EmitModule (ref), u8 (copy)
                while true do
                    task.wait(3);
                    u7:Play();
                    task.delay(0.3333333333333333, function() -- Line: 55
                        -- upvalues: EmitModule (ref), u8 (ref)
                        EmitModule.emit(u8);
                    end);
                end;
            end);
        end
    };
end;