  

local RunService = game:GetService("RunService");
game:GetService("ReplicatedStorage");

return function(u1: table) -- Line: 4, Name: BallAfterShot
    -- upvalues: RunService (copy)
    local u2 = u1.time or 3;
    local u3 = u1.effect:Clone();
    u3.Parent = workspace.Debris;
    local u4 = nil;
    u4 = RunService.RenderStepped:Connect(function(p5) -- Line: 11
        -- upvalues: u2 (ref), u1 (copy), u4 (ref), u3 (copy)
        u2 = u2 - p5;

        if u2 > 0 and (u1.ball and u1.ball.Parent) then
            u3.CFrame = CFrame.lookAlong(u1.ball.CFrame.Position, u1.ball.CFrame.LookVector);

            return;
        end;

        u4:Disconnect();
        u3:Destroy();
    end);
end;