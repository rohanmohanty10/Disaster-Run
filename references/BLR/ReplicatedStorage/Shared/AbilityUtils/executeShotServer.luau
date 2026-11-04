  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Spring);
require(ReplicatedStorage.Shared.utils.getCharacter);
local _ = workspace.CurrentCamera;

return function(p1: any, p2: table?) -- Line: 22, Name: executeShotServer
    -- upvalues: RunService (copy)
    if RunService:IsClient() then
        warn("Function executeShotServer can only be called from server");

        return;
    end;

    local v3 = p2 or {};
    local Player = v3.Player;
    local v4 = v3.IFrame or 2;
    local CFrame_new_ret = CFrame.new(Player.Character.PlrFootball.BallAnims.BALL.Position + (v3.BallCFrame or Player.Character.HumanoidRootPart.AssemblyLinearVelocity / 20));
    p1.BallService.NewBall:Remove();
    p1.BallService.NewBall.Ball.IFrame.Value = tick() + v4;
    Player.PlayerStats.HasShot.Value = true;
    task.delay(1, function() -- Line: 43
        -- upvalues: Player (copy)
        Player.PlayerStats.HasShot.Value = false;
    end);
    p1.BallService.NewBall.Ball.CFrame = CFrame_new_ret + Vector3.new(0, 0.75, 0);
    p1.BallService.NewBall.Ball:SetNetworkOwner(Player);
end;