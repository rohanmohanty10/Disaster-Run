  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local environment = require(ReplicatedStorage.Shared.environment);

return {
    trackBall = function(u1: userdata) -- Line: 7, Name: trackBall
        -- upvalues: ReplicatedStorage (copy), environment (copy)
        local WireframeHandleAdornment = Instance.new("WireframeHandleAdornment");
        WireframeHandleAdornment.Adornee = workspace.Terrain;
        WireframeHandleAdornment.Color3 = Color3.fromRGB(255, 0, 0);
        WireframeHandleAdornment.Thickness = 3;
        WireframeHandleAdornment.Parent = u1;
        local u2 = ReplicatedStorage.Assets.UI.ShotDistance:Clone();
        u2.BillboardGui.Enabled = false;
        u2.Parent = workspace.Terrain;
        task.spawn(function() -- Line: 19
            -- upvalues: environment (ref), WireframeHandleAdornment (copy), u2 (copy), u1 (copy)
            local function shotStarted() -- Line: 20
                -- upvalues: environment (ref), WireframeHandleAdornment (ref), u2 (ref), u1 (ref)
                local v3;

                if environment.env == "Dev" then
                    v3 = not game:GetService("RunService"):IsStudio();
                else
                    v3 = false;
                end;

                if not (workspace.ServerSettings:GetAttribute("ShowBalancing") or v3) then
                    return;
                end;

                WireframeHandleAdornment:Clear();
                u2.BillboardGui.Enabled = false;
                local Position = u1.Position;
                local Position2 = u1.Position;
                local v4 = 0;

                while u1.Parent and (u1.AssemblyLinearVelocity.Magnitude > 12 or v4 < 1.5) do
                    v4 = v4 + task.wait();
                    local Position3 = u1.Position;

                    if Position3.Y < 9.5 then
                        break;
                    end;

                    WireframeHandleAdornment:AddLine(Position2, Position3);
                    Position2 = Position3;
                end;

                local Magnitude = (Position - Position2).Magnitude;

                if Magnitude < 10 then
                    WireframeHandleAdornment:Clear();

                    return;
                end;

                u2.BillboardGui.Frame.TextLabel.Text = `{math.floor(Magnitude)}m`;
                u2.CFrame = CFrame.new(Position2);
                u2.BillboardGui.Enabled = true;
            end;

            while u1:IsDescendantOf(workspace) do
                if u1.Parent == workspace then
                    shotStarted();

                    while u1.Parent == workspace do
                        task.wait();
                    end;
                end;

                task.wait(0.03333333333333333);
            end;

            u2:Destroy();
            WireframeHandleAdornment:Destroy();
        end);
    end
};