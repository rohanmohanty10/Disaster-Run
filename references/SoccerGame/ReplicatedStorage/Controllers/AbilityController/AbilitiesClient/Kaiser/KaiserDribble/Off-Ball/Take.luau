  

local ReplicatedStorage = game:WaitForChild("ReplicatedStorage");
require(ReplicatedStorage.Shared.CameraShaker);
local Popup = require(ReplicatedStorage.Shared.Popup);
local KaiserDribble = require(ReplicatedStorage.AbilityBalancing).KaiserDribble;

return function(u1, p2, u3) -- Line: 8
    -- upvalues: KaiserDribble (copy), Popup (copy)
    local v4 = p2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");
    local UIScale = v4:FindFirstChild("UIScale");

    if not v4 then
        return;
    end;

    if u1.LostBallConnection then
        u1.LostBallConnection:Disconnect();
        u1.LostBallConnection = nil;
    end;

    if u1.UITween2 then
        u1.UITween2:Cancel();
        u1.UITween2 = nil;
    end;

    if u1.UITween1 then
        u1.UITween1:Cancel();
        u1.UITween1 = nil;
    end;

    UIScale.Scale = 1;
    v4.ImageColor3 = Color3.fromRGB(255, 255, 255);
    u1.OverwriteText["2"] = "Royal Route";
    u1.KaiserDribbleShot = nil;
    u3:SetAttribute("KaiserDribbleShot", nil);
    u1:AbilityCooldown("2", KaiserDribble.Cooldown);
    local v5 = {};

    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == p2.Team and (v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude <= 100)) then
            table.insert(v5, v.Character);
        end;
    end;

    if game.Workspace:FindFirstChild("PassRig") then
        table.insert(v5, game.Workspace.PassRig);
    end;

    local v6 = nil;

    for _, v in pairs(v5) do
        if v.Values.HasBall.Value then
            v6 = v;
        end;
    end;

    if not v6 then
        if not game.Workspace:FindFirstChild("PassRig") then
            return Popup.Popup(p2, "None of your teammates have the ball or out of range!");
        end;

        v6 = game.Workspace.PassRig;
        Popup.Popup(p2, "Testing skill with PassRig");
    end;

    u1.AbilityService.Ability:Fire("KaiserDribble", {
        State = script.Parent.Name,
        Action = script.Name,
        Object = v6
    });
    u1.Animations:StopAnims();
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7) -- Line: 59
        -- upvalues: u1 (copy), u3 (copy)
        if p7.State == "Failed" then
            u1.ABC:Clean();

            return;
        end;

        if p7.State == "Recieve" then
            local HumanoidRootPart = u3.HumanoidRootPart;
            local HumanoidRootPart2 = p7.Object.HumanoidRootPart;
            local Ball = p7.Ball;
            local u8 = (HumanoidRootPart.Position + HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart2.Position).Unit + Vector3.new(0, 0.5, 0);
            local math_clamp_ret = math.clamp((HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude * 1.5, 0, 150);
            u1.BallController:DragBall(Ball);
            Ball.AssemblyLinearVelocity = u8 * math_clamp_ret;
            local u9 = tick();
            local u10 = nil;
            u10 = u1.ABC:Connect(game:GetService("RunService").Heartbeat, function(p11) -- Line: 78
                -- upvalues: u9 (copy), u10 (ref), HumanoidRootPart2 (copy), u8 (ref), HumanoidRootPart (copy), Ball (copy), math_clamp_ret (ref), u1 (ref)
                if tick() > u9 + 1.5 then
                    return u10:Disconnect();
                end;

                local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                u8 = u8:Lerp((HumanoidRootPart.Position - Ball.Position).Unit + Vector3.new(0, 0.1, 0), 6.5 * p11);
                math_clamp_ret = math.clamp((HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude * 2.75, 0, 150);

                if (HumanoidRootPart.Position - Ball.Position).Magnitude <= 7 then
                    u1.BallController:DragBall(Ball);
                    u10:Disconnect();
                end;

                Ball.AssemblyLinearVelocity = Ball.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 6.5 * p11);
            end);

            repeat
                task.wait();
            until tick() > u9 + 1.5 or u3.Values.HasBall.Value;

            if not u3.Values.HasBall.Value then
                return u1.ABC:Clean();
            end;

            u1.ABC:Clean();
        end;
    end);
end;