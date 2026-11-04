  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
    local u2 = ReplicatedStorage.Assets.Vfx.ChigiriRun:Clone();
    u2.Parent = u1.Humrp;
    u2.CFrame = u1.Humrp.CFrame * CFrame.new(0, 0, -4);
    Essentials:Weld(u2, u1.Humrp);
    local u3 = tick();
    local u4 = false;
    local u5 = nil;
    u5 = game:GetService("RunService").Heartbeat:Connect(function(p6) -- Line: 18
        -- upvalues: u3 (copy), u5 (ref), VfxManager (ref), u2 (copy), u1 (copy), u4 (ref)
        if tick() > u3 + 6 then
            u5:Disconnect();
            VfxManager.Enable(u2, false);
            task.delay(3, function() -- Line: 19
                -- upvalues: u2 (ref)
                u2:Destroy();
            end);

            return;
        end;

        if u1.Humrp.AssemblyLinearVelocity.Magnitude >= 5 then
            if u4 == false then
                VfxManager.Enable(u2, true);
            end;

            u4 = true;

            return;
        end;

        if u4 then
            VfxManager.Enable(u2, false);
        end;

        u4 = false;
    end);
end;