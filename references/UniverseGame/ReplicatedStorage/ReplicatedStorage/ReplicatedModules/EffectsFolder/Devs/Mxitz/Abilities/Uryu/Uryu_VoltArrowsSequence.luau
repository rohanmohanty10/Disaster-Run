  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);

local function ScaleArrow(p1, p2, p3, p4) -- Line: 16
    -- upvalues: TweenService (copy)
    local v5 = p3 or 1;

    for _, child in p2:GetChildren() do
        if child:IsA("BasePart") then
            if p4 then
                TweenService:Create(child, p4, {
                    Size = p1:FindFirstChild(child.Name).Size * v5
                }):Play();
            else
                child.Size = p1:FindFirstChild(child.Name).Size * v5;
            end;
        end;
    end;
end;

return function(u6, p7) -- Line: 32
    -- upvalues: AssetHandler (copy), Sequence_V2 (copy), ScaleArrow (copy), TweenService (copy), EffectsHandler (copy), Players (copy)
    local HumanoidRootPart = u6:FindFirstChild("HumanoidRootPart");
    local u8 = AssetHandler.GetAsset("Models/VoltSmallArrow", p7) or AssetHandler.GetAsset("Models/VoltSmallArrow", {
        AbilityName = "Sternritter A: Antithesis"
    });
    local v9 = Sequence_V2.new();
    local u10 = v9:GetCache("Arrows");
    local u11 = v9:GetTrove();
    v9:AddFrame(30, function(p12) -- Line: 47
        -- upvalues: HumanoidRootPart (copy), u11 (copy), u8 (ref), ScaleArrow (ref), u10 (copy)
        for i = 7, 0, -1 do
            local v13 = math.rad(i * 180 / 7 + -90);
            local v14 = HumanoidRootPart.Position + (HumanoidRootPart.CFrame.LookVector * math.cos(v13) + HumanoidRootPart.CFrame.RightVector * math.sin(v13)) * 5;
            local v15 = u11:Clone(u8);
            local v16 = u8;
            local v17 = 0 or 1;

            for _, child in v15:GetChildren() do
                if child:IsA("BasePart") then
                    child.Size = v16:FindFirstChild(child.Name).Size * v17;
                end;
            end;

            local Weld = Instance.new("Weld");
            Weld.Name = "Join";
            Weld.Part0 = HumanoidRootPart;
            Weld.Part1 = v15;
            Weld.C0 = HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(v14, v14 + HumanoidRootPart.CFrame.LookVector));
            Weld.Parent = v15;
            v15.Parent = workspace;
            ScaleArrow(u8, v15, nil, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
            table.insert(u10, v15);
            task.wait(0.06666666666666667);
        end;
    end);
    v9:AddFrame(110, function(p18) -- Line: 73
        -- upvalues: HumanoidRootPart (copy), u10 (copy), TweenService (ref), ScaleArrow (ref), u8 (ref)
        local v19 = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5;

        for i, v in u10 do
            local v20 = math.rad(360 * (i - 1) / #u10);
            local v21 = v19 + (HumanoidRootPart.CFrame.RightVector * math.cos(v20) + HumanoidRootPart.CFrame.UpVector * math.sin(v20)) * 2;
            local Join = v.Join;
            local v22 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v23 = {};
            local CFrame2 = HumanoidRootPart.CFrame;
            local fromMatrix = CFrame.fromMatrix;
            local v24 = vector.normalize(v21 - v19);
            v23.C0 = CFrame2:ToObjectSpace(fromMatrix(v21, vector.cross(v24, -HumanoidRootPart.CFrame.LookVector), (vector.normalize(-HumanoidRootPart.CFrame.LookVector))));
            TweenService:Create(Join, v22, v23):Play();
            ScaleArrow(u8, v, 2, TweenInfo.new(0.1, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut));
            task.delay(0.1, ScaleArrow, u8, v, 1, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out));
        end;
    end);
    v9:AddFrame(150, function(p25) -- Line: 90
        -- upvalues: HumanoidRootPart (copy), u10 (copy), TweenService (ref), ScaleArrow (ref), u8 (ref)
        local v26 = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5;

        for i, v in u10 do
            local v27 = math.rad(360 * (i - 1) / #u10);
            local v28 = v26 + (HumanoidRootPart.CFrame.RightVector * math.cos(v27) + HumanoidRootPart.CFrame.UpVector * math.sin(v27));
            local Join = v.Join;
            local v29 = TweenInfo.new(0.75, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
            local v30 = {};
            local CFrame2 = HumanoidRootPart.CFrame;
            local fromMatrix = CFrame.fromMatrix;
            local v31 = vector.normalize(v28 - v26);
            v30.C0 = CFrame2:ToObjectSpace(fromMatrix(v28, vector.cross(v31, -HumanoidRootPart.CFrame.LookVector), (vector.normalize(-HumanoidRootPart.CFrame.LookVector))));
            TweenService:Create(Join, v29, v30):Play();
            ScaleArrow(u8, v, 0.5, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
        end;
    end);
    v9:AddFrame(180, function(p32) -- Line: 106
        -- upvalues: EffectsHandler (ref), Players (ref), u6 (copy), HumanoidRootPart (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Explode",
            AutoSerialize = true,
            Scale = 0.75,
            Player = Players:GetPlayerFromCharacter(u6) or u6,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        });
        p32:Destroy();
    end);
    v9:SetValidate(function() -- Line: 118
        -- upvalues: u6 (copy), HumanoidRootPart (copy)
        return u6 and HumanoidRootPart;
    end);
    v9:Play();
end;