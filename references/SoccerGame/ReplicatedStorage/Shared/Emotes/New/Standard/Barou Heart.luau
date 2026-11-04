  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://122735321019354",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), Essentials (copy), EmitModule (copy)
        local v5 = Trove.new();
        local u6 = script.Jump:Clone();
        u6:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(u6:GetPivot()));
        u6.Parent = workspace.Debris;
        u6.Anchored = false;
        u6.CanCollide = false;
        u6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, u6, u6);
        u6.Parent = workspace.Debris;
        v5:Add(u6);
        local u7 = script.Torso:Clone();
        u7:PivotTo(p2.Torso.CFrame);
        u7.Anchored = false;
        u7.CanCollide = false;
        u7.Massless = true;
        u7.Transparency = 1;
        Essentials:Weld(p2.Torso, u7, u7);
        task.delay(0.4166666666666667, function() -- Line: 40
            -- upvalues: EmitModule (ref), u6 (copy)
            EmitModule.emit(u6);
        end);
        task.delay(0.8166666666666667, function() -- Line: 45
            -- upvalues: EmitModule (ref), u6 (copy)
            EmitModule.emit(u6);
        end);
        task.delay(1.5, function() -- Line: 50
            -- upvalues: EmitModule (ref), u7 (copy)
            EmitModule.emit(u7);
        end);
        u7.Parent = workspace.Debris;
        v5:Add(u7);

        return v5;
    end
});