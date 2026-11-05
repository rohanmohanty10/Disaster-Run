  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u1 = Random.new();
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p2, p3, p4, p5) -- Line: 6
    -- upvalues: RunService (copy), AssetHandler (copy), u1 (copy), TweenService (copy)
    local u6;

    if type(p4) == "table" then
        u6 = p4.Reference;
        p4 = p4.SwirlOnly;
    else
        u6 = nil;
    end;

    local function IsStillValid() -- Line: 16
        -- upvalues: u6 (ref)
        return not u6 or u6.Parent ~= nil;
    end;

    local v7 = os.clock();
    local u8 = {};
    local u9 = nil;

    if u6 then
        u9 = RunService.Heartbeat:Connect(function() -- Line: 25
            -- upvalues: u6 (ref), u8 (copy), u9 (ref)
            if not u6 or u6.Parent ~= nil then
                return;
            end;

            for _, v in pairs(u8) do
                if v.Parent then
                    v:Destroy();
                end;
            end;

            u9:Disconnect();
        end);
    end;

    while os.clock() - v7 < p3 and (not u6 or u6.Parent ~= nil) do
        task.wait(0.1);
        local u10 = AssetHandler.CloneAsset("Particles/Wamuu/Swirl", {
            AbilityName = "Kars"
        });
        u10.CFrame = p2 * CFrame.Angles(0, 3.141592653589793, 0);
        u10.Size = Vector3.new(0, 0, 0);
        u10.Transparency = 0.5;
        local Orientation = u10.Orientation;
        local v11 = u1:NextNumber(-360, 360);
        u10.Orientation = Orientation + Vector3.new(0, v11, 0);
        u10.Parent = workspace.Effects;
        table.insert(u8, u10);
        local v12 = TweenService:Create(u10, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(12.5, 5, 12.5) * u1:NextNumber(3, 5),
            Orientation = u10.Orientation + Vector3.new(0, p5 and -720 or 720, 0)
        });
        v12:Play();
        v12.Completed:Connect(function() -- Line: 56
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);

        if not p4 then
            local u13 = AssetHandler.CloneAsset("Particles/Wamuu/Shock", {
                AbilityName = "Kars"
            });
            u13.CFrame = p2 * CFrame.new(0, 10, 0) * CFrame.Angles(0, 0, 3.141592653589793);
            u13.Size = Vector3.new(0, 0, 0);
            u13.Transparency = 0.9;
            local v14 = u1:NextNumber(20, 30);
            u13.Size = Vector3.new(30, v14, 30) * u1:NextNumber(1, 1.5) / 2;
            u13.Parent = workspace.Effects;
            table.insert(u8, u13);
            local v15 = TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            local v16 = {
                Transparency = 1
            };
            local v17 = u1:NextNumber(20, 30);
            v16.Size = Vector3.new(30, v17, 30) * u1:NextNumber(1, 1.5);
            v16.Orientation = u13.Orientation + Vector3.new(0, 360, 0);
            local v18 = TweenService:Create(u13, v15, v16);
            v18:Play();
            v18.Completed:Connect(function() -- Line: 75
                -- upvalues: u13 (copy)
                u13:Destroy();
            end);
        end;
    end;

    if u9 then
        u9:Disconnect();
    end;
end;