  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");

return function(u2, p3) -- Line: 4
    -- upvalues: u1 (copy), TweenService (copy), CollectionService (copy)
    u2.Character:FindFirstChild("HumanoidRootPart");
    local Humanoid = u2.Character:FindFirstChild("Humanoid");
    local Duration = p3.Duration;
    local u4 = p3.Text or "ABILITY DURATION";
    local v5 = p3.Tag or "None";

    if u2 then
        coroutine.wrap(function() -- Line: 16
            -- upvalues: u1 (ref), u4 (copy), u2 (copy), Humanoid (copy), TweenService (ref), Duration (copy)
            local u6 = u1.DurationBar:Clone();
            u6.Mainframe.txt.Text = string.upper(u4);
            u6.Mainframe.Visible = true;
            u6.Parent = u2.PlayerGui;
            Humanoid.Died:Connect(function() -- Line: 22
                -- upvalues: u6 (copy)
                u6:Destroy();
            end);
            local v7 = TweenService:Create(u6.Mainframe.bar, TweenInfo.new(tonumber(Duration), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 0, 1, 0)
            });
            v7:Play();
            v7.Completed:Connect(function() -- Line: 29
                -- upvalues: u6 (copy)
                u6:Destroy();
            end);
        end)();
    end;

    if p3.CameraFOV then
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            FieldOfView = 100
        }):Play();
    end;

    local v8 = tick();

    repeat
        task.wait();
    until not CollectionService:HasTag(u2.Character, v5) or (u2.Character == nil or (u2 == nil or Duration < tick() - v8));

    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
    }):Play();
end;