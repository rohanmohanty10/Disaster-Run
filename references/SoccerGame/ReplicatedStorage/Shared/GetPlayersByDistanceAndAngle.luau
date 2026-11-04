  

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");

return function(p1: number, p2: number, p3: userdata, p4: table, p5: function) -- Line: 8
    -- upvalues: Players (copy), RunService (copy)
    local v6 = math.rad(p1 or 70) / 2;
    local math_cos_ret = math.cos(v6);
    local v7 = p2 or 30;
    local Character = p3.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return {};
    end;

    local v8 = {};

    for _, v in ipairs(Players:GetPlayers()) do
        if p5(v) and (v ~= p3 and (v.Character and v.Character.PrimaryPart)) then
            table.insert(v8, v.Character);
        end;
    end;

    if RunService:IsStudio() then
        for _, v in ipairs(p4 or { workspace.PassRig }) do
            if v and v:FindFirstChild("HumanoidRootPart") then
                table.insert(v8, v);
            end;
        end;
    end;

    if #v8 == 0 then
        return {};
    end;

    local LookVector = Character.CFrame.LookVector;
    local v9 = nil;
    local u10 = nil;

    for _, v in ipairs(v8) do
        local v11 = v.HumanoidRootPart.Position - Character.Position;

        if v7 >= v11.Magnitude and LookVector:Dot(v11) > 0 then
            local Magnitude = v11.Magnitude;

            if not v9 or Magnitude < v9 then
                u10 = v;
                v9 = Magnitude;
            end;
        end;
    end;

    if not u10 then
        return {};
    end;

    local Unit = (u10.HumanoidRootPart.Position - Character.Position).Unit;
    local v12 = { u10 };

    for _, v in ipairs(v8) do
        if v ~= u10 then
            local HumanoidRootPart = v.HumanoidRootPart;
            local v13 = HumanoidRootPart.Position - Character.Position;
            local v14 = HumanoidRootPart.Position - u10.HumanoidRootPart.Position;
            local v15;

            if Unit:Dot(v13) > 0 then
                v15 = v9 < v13.Magnitude;
            else
                v15 = false;
            end;

            local v16 = math_cos_ret <= Unit:Dot(v14.Unit);

            if v7 >= v13.Magnitude and (v15 or v16) then
                table.insert(v12, v);
            end;
        end;
    end;

    local Position = u10.HumanoidRootPart.Position;
    table.sort(v12, function(p17, p18) -- Line: 90
        -- upvalues: u10 (ref), Position (copy)
        if p17 == u10 then
            return true;
        end;

        if p18 == u10 then
            return false;
        end;

        return (p17.HumanoidRootPart.Position - Position).Magnitude < (p18.HumanoidRootPart.Position - Position).Magnitude;
    end);

    return v12;
end;