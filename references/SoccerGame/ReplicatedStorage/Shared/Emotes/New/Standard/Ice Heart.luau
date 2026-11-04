  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://129926738049516",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), Essentials (copy), EmitModule (copy)
        local v5 = Trove.new();
        local u6 = script.heartemoteVFX:Clone();
        u6:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(u6:GetPivot()));
        u6.Parent = workspace.Debris;
        u6.Anchored = false;
        u6.CanCollide = false;
        u6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, u6, u6);
        u6.Parent = workspace.Debris;
        v5:Add(u6);
        task.delay(0.4166666666666667, function() -- Line: 30
            -- upvalues: EmitModule (ref), u6 (copy)
            EmitModule.emit(u6);
        end);

        return v5;
    end
});