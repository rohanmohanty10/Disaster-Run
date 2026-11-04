  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), RunService (copy)
    local Character = u1.Plr.Character;
    local u2 = ReplicatedStorage.Assets.Vfx.Cards:Clone();
    u2.Parent = workspace;
    u2.PrimaryPart.CFrame = Character.HumanoidRootPart.CFrame;
    u2.PrimaryPart.Anchored = true;
    local u3 = 1;
    local u4 = nil;
    u4 = RunService.RenderStepped:Connect(function() -- Line: 21
        -- upvalues: u1 (copy), u4 (ref), u2 (copy), u3 (ref), Character (copy)
        if u1.Plr == nil then
            u4:Disconnect();
            u2:Destroy();

            return;
        end;

        if u1.Plr.Character == nil then
            u4:Disconnect();
            u2:Destroy();

            return;
        end;

        if u1.Plr.Team == game.Teams.Visitor then
            u4:Disconnect();
            u2:Destroy();

            return;
        end;

        if u1.Plr.PlayerStats.InFlow.Value == false then
            u4:Disconnect();
            u2:Destroy();

            return;
        end;

        u3 = u3 + 2;
        u2.PrimaryPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, (math.rad(u3)));
    end);
end;