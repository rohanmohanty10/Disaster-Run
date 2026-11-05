  

 

local PathShortcuts = require(game:GetService("ReplicatedStorage").ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

function Bezier(p2, p3, p4, p5)
    return (1 - p2) ^ 2 * p3 + 2 * (1 - p2) * p2 * p4 + p2 ^ 2 * p5;
end;

local u7 = {
    Bicubic = function(p6) -- Line: 15, Name: Bicubic
        return 2.8 * (p6 - 0.5) ^ 3 + 0.5 + 0.3 * (p6 - 0.5);
    end
};

return function(p8) -- Line: 20
    -- upvalues: u7 (copy), u1 (copy), Trove (copy)
    local Character = p8.Character;
    local v9 = p8.RootPart or Character.HumanoidRootPart;
    local EndPosition = p8.EndPosition;
    local v10 = p8.Range or 50;
    local v11 = p8.Up or 25;
    local v12 = p8.Quality or 38;
    local Replicator = p8.Replicator;
    local Easing = p8.Easing;
    local MaxHeight = p8.MaxHeight;
    local v13;

    if Easing and u7[Easing] then
        v13 = u7[Easing];
    else
        v13 = nil;
    end;

    if not Character:GetAttribute("NPC") then
        local Position = v9.Position;
        local v14 = Position - EndPosition;
        local v15 = math.clamp(v14.Magnitude, 0, v10);
        EndPosition = -(v14.Unit * v15) + Position;
    end;

    local v16 = workspace:Raycast(EndPosition + Vector3.new(0, MaxHeight or 3.5, 0), Vector3.new(0, -110, 0), u1);

    if v16 then
        local Position = v9.Position;
        local v17 = v16.Position + Vector3.new(0, 2.5, 0);
        local v18 = math.clamp((Position - v17).Magnitude / 1.5, v11, 75);
        local v19 = (Position + v17) / 2 + Vector3.new(0, v18, 0);
        v9.CFrame = CFrame.new(v9.Position, v17);
        local v20 = Trove.new();
        v20:AttachToInstance(Replicator);
        local v21 = v20:Construct(Instance, "Attachment");
        v21.Name = "RootAttachment";
        v21.Parent = v9;
        local v22 = v20:Construct(Instance, "AlignPosition");
        v22.MaxForce = 1000000;
        v22.Responsiveness = 35;
        v22.Mode = Enum.PositionAlignmentMode.OneAttachment;
        v22.Attachment0 = v21;
        v22.Parent = v9;
        local v23 = 0;

        for i = 1, v12 do
            local v24 = i / v12;
            local v25 = (i - 1) / v12;

            if v13 then
                v24 = v13(v24);
                v25 = v13(v25);
            end;

            local v26 = Bezier(v24, Position, v19, v17);
            local v27 = Bezier(v25, Position, v19, v17);
            local v28 = workspace:Raycast(v27, (v26 - v27).Unit * (v26 - v27).Magnitude, u1);

            if v28 then
                local _ = v28.Position + v28.Normal * 2;
                break;
            end;

            v22.Position = v26;

            while v23 < 0.016666666666666666 do
                v23 = v23 + task.wait();
            end;

            v23 = v23 - 0.016666666666666666;
        end;

        if workspace:Raycast(EndPosition, Vector3.new(0, -5, 0), u1) then
            task.wait(0.15);
            v22:Destroy();
        end;
    end;
end;