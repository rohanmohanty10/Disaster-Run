  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    local u2 = ReplicatedStorage.Assets.Vfx.PreditationShot:Clone();
    u2.Parent = workspace.Debris;
    u2.RigidConstraint.Attachment0 = p1.weldTo;
    VfxManager.Emit(u2);
    task.delay(6, function() -- Line: 19
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);

    if p1.impactFrame then
        local u3 = 0;
        task.spawn(function() -- Line: 24
            -- upvalues: u3 (ref)
            for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation:GetChildren() do
                child.Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation.Enabled = true;

            for i = 1, 17 do
                task.delay(u3, function() -- Line: 30
                    -- upvalues: i (copy)
                    local ImpactFramesPredation = game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation;

                    if i > 1 then
                        ImpactFramesPredation[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                    end;

                    ImpactFramesPredation[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                end);
                u3 = u3 + 0.05;
                local _ = i;
            end;

            task.delay(u3, function() -- Line: 40
                -- upvalues: u3 (ref)
                for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation:GetChildren() do
                    child.Position = UDim2.new(0.5, 0, 1.5, 0);
                end;

                task.delay(0.4, function() -- Line: 44
                    -- upvalues: u3 (ref)
                    u3 = 0;

                    for i = 18, 22 do
                        task.delay(u3, function() -- Line: 47
                            -- upvalues: i (copy)
                            local ImpactFramesPredation = game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation;

                            if i > 17 then
                                ImpactFramesPredation[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                            end;

                            ImpactFramesPredation[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                        end);
                        u3 = u3 + 0.05;
                        local _ = i;
                    end;

                    task.delay(u3, function() -- Line: 56
                        for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation:GetChildren() do
                            child.Position = UDim2.new(0.5, 0, 1.5, 0);
                        end;

                        game.Players.LocalPlayer.PlayerGui.ImpactFramesPredation.Enabled = false;
                    end);
                end);
            end);
        end);
    end;
end;