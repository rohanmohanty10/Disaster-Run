  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.EmitModule).init();
require(ReplicatedStorage.Shared.LoadParticleRig);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local VfxManager = require(ReplicatedStorage.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local highlightEffect = require(ReplicatedStorage.Shared.utils.highlightEffect);
local u1 = {
    [script.CatchEmit] = CFrame.new(
        0.118026733,
        8.47500038,
        -7.51602173,
        0.040637821,
        0,
        -0.999173939,
        0,
        1,
        0,
        0.999173939,
        0,
        0.040637821
    ),
    [script.Startup] = CFrame.new(0, -2.84838033, -0.757770538, 0.00298922369, 0, -1, 0, -1, 0, -1, 0, -0.00298900018)
};

return function(p2: table) -- Line: 17
    -- upvalues: ReplicatedStorage (copy), SoundManager (copy), VfxManager (copy), highlightEffect (copy), u1 (copy), EmitModule (copy)
    local HumanoidRootPart = p2.Character:FindFirstChild("HumanoidRootPart");
    local Humanoid = p2.Character:FindFirstChild("Humanoid");

    if not (HumanoidRootPart and (Humanoid and p2.Character:FindFirstChild("Values"))) then
        return;
    end;

    if p2.Effect == "Startup" then
        local u3 = {};
        table.insert(u3, Humanoid.StateChanged:Connect(function(p4) -- Line: 36
            -- upvalues: u3 (copy), HumanoidRootPart (copy), ReplicatedStorage (ref), SoundManager (ref), VfxManager (ref)
            if p4 == Enum.HumanoidStateType.Landed then
                for _, v in u3 do
                    v:Disconnect();
                end;

                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Field };
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
                local v5 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -6, 0), RaycastParams_new_ret);

                if not v5 then
                    return;
                end;

                local v6 = ReplicatedStorage.Assets.Vfx.FloorHit:Clone();
                v6.Position = v5.Position;
                v6.Parent = workspace.Debris;
                SoundManager.SpawnSound("SwiftLand", 1, v6, 70).PlaybackSpeed = 1.2;
                VfxManager.Emit(v6);
                task.delay(3, v6.Destroy, v6);
            end;
        end));
        task.delay(4, function() -- Line: 31, Name: cleanup
            -- upvalues: u3 (copy)
            for _, v in u3 do
                v:Disconnect();
            end;
        end);
        SoundManager.SpawnSound("SwiftJump", 0.5, HumanoidRootPart, 160);
    else
        SoundManager.SpawnSound("SwiftCatch", 0.5, HumanoidRootPart, 160);
    end;

    highlightEffect(p2.Character, Color3.fromRGB(255, 155, 33), 0.3, 1.75);

    for i, v in u1 do
        if i.Name == p2.Effect then
            local v7 = i:Clone();
            v7:PivotTo(HumanoidRootPart.CFrame * v);
            v7.Parent = workspace.Debris;
            task.delay(5, v7.Destroy, v7);
            EmitModule.emit(v7);
        end;
    end;
end;