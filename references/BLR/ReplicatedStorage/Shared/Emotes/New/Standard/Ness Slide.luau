  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return v1({
    animationId = "rbxassetid://123574474841503",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 14, Name: effect
        -- upvalues: Trove (copy), EmitModule (copy)
        local u5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local CFrame = script.HumanoidRootPart.CFrame;

        local function place(p6) -- Line: 20
            -- upvalues: HumanoidRootPart (copy), CFrame (copy), u5 (copy)
            local v7 = p6:Clone();
            v7:PivotTo(HumanoidRootPart.CFrame * CFrame:ToObjectSpace(p6:GetPivot()));

            local function prepare(p8) -- Line: 23
                p8.Anchored = true;
                p8.CanCollide = false;
                p8.CanTouch = false;
                p8.CanQuery = false;
                p8.Massless = true;
                p8.Transparency = 1;
            end;

            for _, descendant in v7:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                    descendant.Massless = true;
                    descendant.Transparency = 1;
                end;
            end;

            if v7:IsA("BasePart") then
                v7.Anchored = true;
                v7.CanCollide = false;
                v7.CanTouch = false;
                v7.CanQuery = false;
                v7.Massless = true;
                v7.Transparency = 1;
            end;

            v7.Parent = workspace.Debris;
            u5:Add(v7);

            return v7;
        end;

        local u9 = place(script.Slide);
        local u10 = place(script.Hit);
        local u11 = place(script.SpinModel);
        task.delay(math.max((p3.Length > 0 and p3.Length or 2.517) - 1.5, 0), function() -- Line: 50
            -- upvalues: u9 (copy), u10 (copy), u11 (copy), EmitModule (ref)
            for _, v in { u9, u10, u11 } do
                if v.Parent then
                    EmitModule.emit(v);
                end;
            end;
        end);

        return u5;
    end
});