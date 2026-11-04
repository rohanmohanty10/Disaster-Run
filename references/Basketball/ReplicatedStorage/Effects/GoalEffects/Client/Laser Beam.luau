 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1, u2) -- Line: 12
    -- upvalues: SfxManager (copy), VfxManager (copy), Essentials (copy), RunService (copy)
    if not u2.Preview then
        SfxManager:playSound({
            Sound = "Laser BeamSFX",
            Parent = workspace
        });
        local u3 = script.Model:Clone();
        u3.Parent = workspace.Debris;
        u3:PivotTo(u2.CFrame);
        VfxManager.DestroyEffect(u3, 5.5);
        local v4 = u2.CFrame * CFrame.new(-12.322, 0, -76);
        local Vector3_new_ret = Vector3.new(v4.Position.X, 1, v4.Position.Z);
        local CFrame_new_ret = CFrame.new(u2.CFrame.Position, Vector3_new_ret);
        local u5, u6, _ = CFrame_new_ret:ToOrientation();
        u3.Start.CFrame = CFrame_new_ret;
        u3.End.CFrame = CFrame.new(Vector3_new_ret) * CFrame.fromOrientation(u2.CFrame:ToOrientation()) * CFrame.new(0, 3.141592653589793, 0);
        Essentials:Weld(u3.End, u3.Start);
        VfxManager.Emit(u3.Score);
        VfxManager.Enable(u3.Start, true);
        VfxManager.Enable(u3.End, true);
        local u7 = tick();
        local u8 = nil;
        u8 = RunService.RenderStepped:Connect(function() -- Line: 37
            -- upvalues: u3 (copy), u8 (ref), u2 (copy), u5 (copy), u6 (copy), u7 (copy)
            if not (u3 and u3:FindFirstChild("Start")) then
                u8:Disconnect();

                return;
            end;

            local Start = u3.Start;
            local CFrame_new_ret2 = CFrame.new(u2.CFrame.Position);
            local CFrame_fromOrientation = CFrame.fromOrientation;
            local v9 = 180 * (tick() - u7) / 1.5;
            Start.CFrame = CFrame_new_ret2 * CFrame_fromOrientation(u5, u6 + math.rad(v9), 0);
        end);
        task.wait(1.5);

        if u8 then
            u8:Disconnect();
        end;

        VfxManager.Emit(u3.Final);
        VfxManager.Enable(u3.Start, false);
        VfxManager.Enable(u3.End, false);

        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = u2.CFrame.Position;
    SfxManager:playSound({
        Sound = "Laser BeamSFX",
        Parent = Attachment
    }).Ended:Once(function() -- Line: 60
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
    local u10 = script.Model:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(u2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    VfxManager.DestroyEffect(u10, 5.5);
    local v11 = u2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(-12.322, 0, -76);
    local Vector3_new_ret = Vector3.new(v11.Position.X, u2.CFrame.Position.Y - 15.964, v11.Position.Z);
    local CFrame_new_ret = CFrame.new(u2.CFrame.Position, Vector3_new_ret);
    local u12, u13, _ = CFrame_new_ret:ToOrientation();
    u10.Start.CFrame = CFrame_new_ret;
    u10.End.CFrame = CFrame.new(Vector3_new_ret) * CFrame.fromOrientation((u2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)):ToOrientation()) * CFrame.new(0, 3.141592653589793, 0);
    Essentials:Weld(u10.End, u10.Start);
    u10:ScaleTo(0.1);
    VfxManager.Emit(u10.Score);
    VfxManager.Enable(u10.Start, true);
    VfxManager.Enable(u10.End, true);
    local u14 = tick();
    local u15 = nil;
    u15 = RunService.RenderStepped:Connect(function() -- Line: 86
        -- upvalues: u10 (copy), u15 (ref), u2 (copy), u12 (copy), u13 (copy), u14 (copy)
        if not (u10 and u10:FindFirstChild("Start")) then
            u15:Disconnect();

            return;
        end;

        local Start = u10.Start;
        local CFrame_new_ret2 = CFrame.new(u2.CFrame.Position);
        local CFrame_fromOrientation = CFrame.fromOrientation;
        local v16 = 180 * (tick() - u14) / 1.5;
        Start.CFrame = CFrame_new_ret2 * CFrame_fromOrientation(u12, u13 + math.rad(v16), 0);
    end);
    task.wait(1.5);

    if u15 then
        u15:Disconnect();
    end;

    VfxManager.Emit(u10.Final);
    VfxManager.Enable(u10.Start, false);
    VfxManager.Enable(u10.End, false);
    VfxManager.DestroyEffect(u10, 4);
end;