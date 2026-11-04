  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://136702485178488",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), Essentials (copy), EmitModule (copy)
        local v5 = Trove.new();
        local u6 = script.VFX:Clone();
        u6:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(u6:GetPivot()));

        for _, child in u6:GetChildren() do
            if child:IsA("BasePart") then
                child.CanCollide = false;
                child.Massless = true;
                child.Anchored = false;
                child.Transparency = 1;
                Essentials:Weld(p2.HumanoidRootPart, child, child);
            end;
        end;

        u6.Parent = workspace.Debris;
        task.delay(0.06666666666666667, function() -- Line: 30
            -- upvalues: EmitModule (ref), u6 (copy)
            EmitModule.emit(u6.HandPump);
        end);
        task.delay(0.5, function() -- Line: 35
            -- upvalues: EmitModule (ref), u6 (copy)
            EmitModule.emit(u6.BodyEmit, u6.BodyIntensity);
        end);
        v5:Add(u6);

        return v5;
    end
});