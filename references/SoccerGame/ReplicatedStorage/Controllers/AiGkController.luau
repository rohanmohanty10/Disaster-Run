  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = HumanoidRootPart:WaitForChild("RootJoint").C0;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local v3 = Knit.CreateController({
    Name = "AiGkController"
});

function v3.KnitStart(p4) -- Line: 21
    -- upvalues: Knit (copy), RunService (copy)
    local Service = Knit.GetService("AIService");
    local u5 = {};
    Service.UpdatePositions:Connect(function(p6) -- Line: 25
        -- upvalues: u5 (copy)
        if p6.h then
            u5[workspace.AI.Home.GK] = p6.h;
        end;

        if p6.a then
            u5[workspace.AI.Away.GK] = p6.a;
        end;
    end);
    RunService.Heartbeat:Connect(function(p7) -- Line: 36
        -- upvalues: u5 (copy)
        for i, v in u5 do
            local Pivot = i:GetPivot();

            if (Pivot.Position - v.Position).Magnitude > 10 then
                i:PivotTo(v);
            else
                i:PivotTo(Pivot:Lerp(v, 1 - 0.1 ^ (p7 * 8)));
            end;
        end;
    end);
    Service.Ready:Fire();
end;

function v3.KnitInit(u8) -- Line: 52
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u8.BaseTrove = Trove.new();
    u8.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p9) -- Line: 55
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p9;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u8.BaseTrove:Connect(game.Players.PlayerRemoving, function(p10) -- Line: 61
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u8 (copy)
        if p10 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u8.BaseTrove:Destroy();
        end;
    end);
end;

return v3;